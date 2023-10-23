function LocalResponse_SW_T2_S3_4(datafolder)
%datafolder = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_recordersHeightvsHorStrain_v2';
% We define the name of the directory to store the figures in
dir_name = 'Figuras modelos';

NodeCtrlDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));        % Control node
NodeCtrlDispX = NodeCtrlDisp(:,2);

Hw = 750;       % Altura del muro [mm]
Lw  = 1500;     % Largo del muro [mm]
deriva = NodeCtrlDispX/Hw*100;
% Identificacion de load steps correspondientes a 1er, 2do y 3er ciclo de cada drift
% de interes
figure()
plot(NodeCtrlDispX)
grid on
xlabel('Pasos de Carga')
ylabel('Desplazamiento Lateral (mm)')
title('Protocolo de Carga')
box on
% We define the name for the results figure to be saved
figureName = 'Wall-SWT2S34_LoadingProtocol-Model';
% We save the figure
print(fullfile(dir_name,figureName),'-dpng')


% Desplazamientos objetivos
PosDisp = [0.375 0.75 1.125 1.5 2.25 3 4.5 6 7.5];
NegDisp = -PosDisp;

% Se identifican los indices donde se alcanzan los 3 peaks para cada
% desplazamiento objetivo
for i = 1:length(PosDisp)
    LoadStepsMatrixPosCycle(i,:) = find(NodeCtrlDispX == PosDisp(i),3);
    LoadStepsMatrixNegCycle(i,:) = find(NodeCtrlDispX == NegDisp(i),3);
end

%% Test --------------------------------------------------------------------
folderToAdd_Note = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\SW-T2-S3-4\Documentation'; % Ruta de la carpeta a agregar - Note
folderToAdd_PCcivil = 'C:\repos\Ejemplos\Validacion\SW-T2-S3-4\Documentation'; % Ruta de la carpeta a agregar - PC Civil
addpath(folderToAdd_Note);
addpath(folderToAdd_PCcivil);

filename = 'Documentacion SW-T2-S3-4.xlsx';
sheet = 'Resp local exp y analitica ';
xlRange_PosCycle = 'C32:K36';
xlRange_NegCycle = 'L32:T36';
xlRange_Height = 'B32:B36';

RespLocalTest_PosCycle = xlsread(filename,sheet,xlRange_PosCycle);
RespLocalTest_NegCycle = xlsread(filename,sheet,xlRange_NegCycle);
RespLocalTest_Height = xlsread(filename,sheet,xlRange_Height);

figure()
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(RespLocalTest_PosCycle(:,i),RespLocalTest_Height,'-*','DisplayName',[num2str(drift), '%'])
    hold on
end
legend('Location', 'NorthEast')
title('Local Response SW-T2-S3-4: Test - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
legend('0.05%','0.10%','0.15%','0.20%', '0.30%', '0.40%', '0.60%', '0.80%', '1%')
text(0.0015, 700,datafolder, 'FontSize', 14);
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
box on
grid on
hold off

figure()
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(RespLocalTest_NegCycle(:,i),RespLocalTest_Height,'-*','DisplayName',[num2str(drift), '%'])
    hold on
end
legend('Location', 'NorthEast')
title('Local Response SW-T2-S3-4: Test - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
legend('0.05%','0.10%','0.15%','0.20%', '0.30%', '0.40%', '0.60%', '0.80%', '1%')
text(0.0015, 700,datafolder, 'FontSize', 14);
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
box on
grid on
hold off

%% ========================================================================
% FORMA N�1
% =========================================================================
% Inicializacion de estructura para almacenamiento de variables
node_HorDisp = struct();
for i = 4:18        % 18 nodos
    % Se importa la informacion
    nombre = ['NodeDisp_x_' num2str(i)];
    file = ['NODE_DISPx_' num2str(i) '.out'];
    valor = importdata(fullfile(datafolder,file));
    node_HorDisp.(nombre) = valor;
end

% Se extraen los desplazamientos en x
NodesDispx = fieldnames(node_HorDisp);
for i = 1:numel(NodesDispx)
    Dx = node_HorDisp.(NodesDispx{i});
    HorDisp(:,i) = Dx(:,2);
end

% Calculo de deformaciones a la altura de los nodos 
nLevels = 5;
nSteps = size(HorDisp, 1);

for i = 1:nSteps
    for j = 1:nLevels
        NodeHorStrain(j,i) = (HorDisp(i,j*3-2)-HorDisp(i,j*3))/Lw;
    end
end

% Se extraen las deformaciones horizontales nodales alcanzadas en aquellos
% loadsteps asociados a los diferentes drifts (+)
for i = 1:length(PosDisp)
    NodeHorStrain_PosCycle(:,i) = NodeHorStrain(:,LoadStepsMatrixPosCycle(i,1)); % Se identifican los LoadSteps para cada drift para el ciclo 1
end
% Se extraen las deformaciones horizontales nodales alcanzadas en aquellos
% loadsteps asociados a los diferentes drifts (-)
for i = 1:length(PosDisp)
    NodeHorStrain_NegCycle(:,i) = NodeHorStrain(:,LoadStepsMatrixNegCycle(i,1)); % Se identifican los LoadSteps para cada drift para el ciclo 1
end

Height = [150 300 450 600 750];

figure()
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(-NodeHorStrain_PosCycle(:,i),Height,'--*','DisplayName',[num2str(drift), '%'])
    hold on
end
legend('Location', 'NorthEast')
text(0.0015, 700,datafolder, 'FontSize', 14);
title('Local Response SW-T2-S3-4 (Nodes): Model - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height(mm)')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
box on
grid on
hold off

figure()
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(-NodeHorStrain_NegCycle(:,i),Height,'--*','DisplayName',[num2str(drift), '%'])
    hold on
end
legend('Location', 'NorthEast')
text(0.0015, 700,datafolder, 'FontSize', 14);
title('Local Response SW-T2-S3-4 (Nodes): Model - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height(mm)')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
box on
grid on
hold off

% Comparacion: Modelo vs Test ---------------------------------------------
markers = {'o','+','*','x','s','d','^','p','h'};
colors = {'b','g','r','k','c','m'};
% this function will do the circular selection
% Example:  getprop(colors, 7) = 'b'
getFirst = @(v)v{1}; 
getprop = @(options, idx)getFirst(circshift(options,-idx+1));

%PosDisp = [0.375 0.75 1.125 1.5 2.25 3 4.5 6 7.5];
PosDispReducido = [1.125 1.5 3 6];       % Asi no se grafican todas las curvas
index = [3 4 6 8];                      % Indices de los desplazamientos objetivos segun vector PosDisp

figure()    % Ciclo Positivo
hold on
for i = 1:length(PosDispReducido)
    plot(-NodeHorStrain_PosCycle(:,index(i)),Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--','HandleVisibility','off')
    plot(RespLocalTest_PosCycle(:,index(i)),RespLocalTest_Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-','HandleVisibility','off')
end
legend('Location', 'NorthEastOutside')
%text(0.0015, 700,datafolder, 'FontSize', 14);
%title('Local Response SW-T2-S3-4 (Nodes): Test vs Model - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
%legend('0.05%','0.10%','0.15%','0.20%', '0.30%', '0.40%', '0.60%', '0.80%', '1%')
%xlim([-1e-4 0.005])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
box on
grid on

%figure()    % Ciclo Negativo
%hold on
for i = 1:length(PosDispReducido)
    drift = PosDispReducido(i)/Hw*100;
    plot(-1*(-NodeHorStrain_NegCycle(:,index(i))),Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'HandleVisibility','off')
    plot(-1*(RespLocalTest_NegCycle(:,index(i))),RespLocalTest_Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'DisplayName',[num2str(drift), '%'])
end
legend('Location', 'NorthEastOutside')
%text(0.0015, 700,datafolder, 'FontSize', 14);
text(-0.0028, 750,datafolder, 'FontSize', 12);
title('Respuesta Local SW-T2-S3-4 (Nodos): Test vs Modelo')
xlabel('Deformaci�n Horizontal')
ylabel('Altura (mm)')
xlim([-3e-3 3e-3])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
xticks(-3e-3:1e-3:3e-3);  % Establece las ubicaciones de las etiquetas
xticklabels({'0.003', '0.002', '0.001','0', '0.001', '0.002', '0.003'});  % Etiquetas personalizadas
box on
grid on
hold off

% We define the name for the results figure to be saved
figureName = [datafolder '-HeightvsHorStrain_Nodes_ModelvsTest'];
% We save the figure
print(fullfile(dir_name,figureName),'-dpng')
%% ====================================================================
% FORMA N�2
% =====================================================================
% Iniacializacion de estructura para almacenamiento de variables
panel_strain = struct();
for i = 1:10        % 10 elementos
    for j = 1:4     % 4 paneles
        % Se importa la informacion
        nombre = ['epsE' num2str(i) 'P' num2str(j)];
        file = ['MEFISection_panel_strain' num2str(i) num2str(j) '.out'];
        valor = importdata(fullfile(datafolder,file));
        panel_strain.(nombre) = valor;
    end
end

% Se extraen las deformaciones en x
epsEP = fieldnames(panel_strain);
for i = 1:numel(epsEP)
    strains = panel_strain.(epsEP{i});
    eps_xx(:,i) = strains(:,2);
end

% Se suman(?) las deformaciones horizontales por piso
nSteps = size(eps_xx, 1);
nLevels = 5;

for i = 1:nSteps
    for j = 1:nLevels
        %eps_xx_height(j,i) = sum(eps_xx(i,j*8-7:j*8)); 
        eps_xx_height(j,i) = mean(eps_xx(i,j*8-7:j*8));
        %eps_xx_height(j,i) = max(eps_xx(i,j*8-7:j*8));
    end
end

% Se extraen las deformaciones horizontales alcanzadas en aquellos
% loadsteps asociados a los diferentes drifts (+)
for i = 1:length(PosDisp)
    eps_xx_height_PosCycle(:,i) = eps_xx_height(:,LoadStepsMatrixPosCycle(i,1)); % Se identifican los LoadSteps para cada drift para el ciclo 1
end
% Se extraen las deformaciones horizontales alcanzadas en aquellos
% loadsteps asociados a los diferentes drifts (-)
for i = 1:length(PosDisp)
    eps_xx_height_NegCycle(:,i) = eps_xx_height(:,LoadStepsMatrixNegCycle(i,1)); % Se identifican los LoadSteps para cada drift para el ciclo 1
end

height = 75:150:675;
Hw = 750; %[mm]

figure()
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(eps_xx_height_PosCycle(:,i),height,'--*','DisplayName',[num2str(drift), '%'])
    hold on
end
legend('Location', 'NorthEast')
text(0.0015, 700,datafolder, 'FontSize', 14);
title('Local Response SW-T2-S3-4: Model - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height(mm)')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
box on
grid on
hold off

figure()
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(eps_xx_height_NegCycle(:,i),height,'--*','DisplayName',[num2str(drift), '%'])
    hold on
end
legend('Location', 'NorthEast')
text(0.0015, 700,datafolder, 'FontSize', 14);
title('Local Response SW-T2-S3-4: Model - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height(mm)')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
box on
grid on
hold off

% Comparacion: Modelo vs Test ---------------------------------------------
markers = {'o','+','*','x','s','d','^','p','h'};
colors = {'b','g','r','k','c','m'};
% this function will do the circular selection
% Example:  getprop(colors, 7) = 'b'
getFirst = @(v)v{1}; 
getprop = @(options, idx)getFirst(circshift(options,-idx+1));

%PosDisp = [0.375 0.75 1.125 1.5 2.25 3 4.5 6 7.5];
PosDispReducido = [1.125 1.5 3 6];       % Asi no se grafican todas las curvas
index = [3 4 6 8];                      % Indices de los desplazamientos objetivos segun vector PosDisp

figure()    % Ciclo Positivo
hold on
for i = 1:length(PosDispReducido)
    plot(eps_xx_height_PosCycle(:,index(i)),height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--','HandleVisibility','off')
    plot(RespLocalTest_PosCycle(:,index(i)),RespLocalTest_Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-','HandleVisibility','off')
end
legend('Location', 'NorthEast')
%text(0.0015, 700,datafolder, 'FontSize', 14);
title('Respuesta Local SW-T2-S3-4: Test vs Modelo')
xlabel('Deformaci�n Horizontal')
ylabel('Altura (mm)')
%legend('0.05%','0.10%','0.15%','0.20%', '0.30%', '0.40%', '0.60%', '0.80%', '1%')
%xlim([-1e-4 0.005])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
box on
grid on

%figure()    % Ciclo Negativo
%hold on
for i = 1:length(PosDispReducido)
    drift = PosDispReducido(i)/Hw*100;
    plot(-1*(eps_xx_height_NegCycle(:,index(i))),height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'HandleVisibility','off')
    plot(-1*(RespLocalTest_NegCycle(:,index(i))),RespLocalTest_Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'DisplayName',[num2str(drift), '%'])
end
legend('Location', 'NorthEastOutside')
%text(0.0015, 700,datafolder, 'FontSize', 14);
text(-0.0028, 750,datafolder, 'FontSize', 12);
%title('Local Response SW-T2-S3-4: Test vs Model - Negative Cycle')
%xlabel('Horizontal Strain')
%ylabel('Height (mm)')
xlim([-3e-3 3e-3])
ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
xticks(-3e-3:1e-3:3e-3);  % Establece las ubicaciones de las etiquetas
xticklabels({'0.003', '0.002', '0.001','0', '0.001', '0.002', '0.003'});  % Etiquetas personalizadas
grid on 
box on
hold off

% We define the name for the results figure to be saved
figureName = [datafolder '-HeightvsHorStrain_Panels_ModelvsTest'];
% We save the figure
print(fullfile(dir_name,figureName),'-dpng')
% Comparacion: Modelo Nodos vs Modelo paneles -----------------------------

figure()    % Ciclo Positivo
hold on
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(-NodeHorStrain_PosCycle(:,i),Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'DisplayName',['Model (Nodes) - ', num2str(drift), '%'])
    plot(eps_xx_height_PosCycle(:,i),height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'DisplayName',['Model (Panels) - ', num2str(drift), '%'])
end
legend('Location', 'NorthEast')
text(0.0015, 700,datafolder, 'FontSize', 14);
title('Local Response SW-T2-S3-4 Model: Nodes vs Panels - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
%legend('0.05%','0.10%','0.15%','0.20%', '0.30%', '0.40%', '0.60%', '0.80%', '1%')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
box on
grid on

figure()    % Ciclo Negativo
hold on
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(-NodeHorStrain_NegCycle(:,i),Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'DisplayName',['Model (Nodes) - ', num2str(drift), '%'])
    plot(eps_xx_height_NegCycle(:,i),height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'DisplayName',['Model (Panels) - ', num2str(drift), '%'])
end
legend('Location', 'NorthEast')
text(0.0015, 700,datafolder, 'FontSize', 14);
title('Local Response SW-T2-S3-4 Model: Nodes vs Panels - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
box on
grid on








% Tm = 1.35;
% FontSize = 12;
% set(gca,'FontSize',FontSize)
% set(gca, 'FontName', 'Arial')
% set(gca,'LabelFontSizeMultiplier',Tm)
% set(gca,'TitleFontSizeMultiplier',Tm)
% set(gca,'Linewidth',1.5)
end