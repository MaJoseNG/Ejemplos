function LocalResponse_RW_A20_P10_S38(datafolder)

% We define the name of the directory to store the figures in
dir_name = 'Figuras modelos';

NodeCtrlDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));        % Control node
NodeCtrlDispX = NodeCtrlDisp(:,2);    

Hw = 2438.4;        % Altura del muro [mm]
Lw  = 1220;         % Largo del muro [mm]
deriva = NodeCtrlDispX/Hw*100;
% Identificacion de load step correspondiente a 1er  ciclo de cada drift
% de interes
figure()
% [ax,h1,h2] = plotyy(22:length(NodeCtrlDispX),NodeCtrlDispX,NodeCtrlDispX,deriva);
% xlabel(ax(1), 'Pasos de Carga');
% ylabel(ax(1), 'Desplazamiento Lateral [mm]');
% ylabel(ax(2), 'Deriva [%]');

plot(NodeCtrlDispX)
xlabel('Pasos de Carga')
ylabel('Desplazamiento Lateral (mm)')
title('Protocolo de Carga')
grid on
box on
% We define the name for the results figure to be saved
figureName = 'Wall-RWA20P10S38_LoadingProtocol-Model';
% We save the figure
print(fullfile(dir_name,figureName),'-dpng')

% Desplazamientos objetivos
%PosDisp = [2.4 7.2 12 17 24.2 36.4 53.6 75.4];
PosDisp = [6.8 9.2 13.6 18.2 26.8 36.4 56 75.4];
NegDisp = -PosDisp;

% Se identifican los indices donde se alcanzan los peaks para cada
% desplazamiento objetivo
for i = 1:length(PosDisp)
    LoadStepsMatrixPosCycle(i,:) = find(NodeCtrlDispX == PosDisp(i),1);
    LoadStepsMatrixNegCycle(i,:) = find(NodeCtrlDispX == NegDisp(i),1);
end

%% Test --------------------------------------------------------------------
folderToAdd_Note = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\RW-A20-P10-S38\Documentation'; % Ruta de la carpeta a agregar - Note
folderToAdd_PCcivil = 'C:\repos\Ejemplos\Validacion\RW-A20-P10-S38\Documentation'; % Ruta de la carpeta a agregar - PC Civil
addpath(folderToAdd_Note);
addpath(folderToAdd_PCcivil);

filename = 'Documentacion RW-A20-P10-S38.xlsx';
sheet = 'Resp local exp y analitica';
xlRange_PosCycle = 'D4:K10';
xlRange_NegCycle = 'L4:S10';
xlRange_Height = 'C4:C10';

RespLocalTest_PosCycle = xlsread(filename,sheet,xlRange_PosCycle);
RespLocalTest_NegCycle = xlsread(filename,sheet,xlRange_NegCycle);
RespLocalTest_Height = xlsread(filename,sheet,xlRange_Height);

figure()
for i = 1:length(PosDisp)
    %drift = PosDisp(i)/Hw*100;
    %plot(RespLocalTest_PosCycle(:,i),RespLocalTest_Height,'-*','DisplayName',[num2str(drift), '%'])
    plot(RespLocalTest_PosCycle(:,i),RespLocalTest_Height,'-*')
    hold on
end
legend('Location', 'NorthEast')
title('Local Response RW-A20-P10-S38: Test - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
legend('0.28%','0.38%','0.56%','0.75%', '1.1%', '1.5%', '2.3%', '3.1%')
text(2e-3, 2300,datafolder, 'FontSize', 14);
%xlim([-1e-4 0.005])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
box on
grid on
hold off

figure()
for i = 1:length(PosDisp)
    %drift = PosDisp(i)/Hw*100;
    %plot(RespLocalTest_NegCycle(:,i),RespLocalTest_Height,'-*','DisplayName',[num2str(drift), '%'])
    plot(RespLocalTest_NegCycle(:,i),RespLocalTest_Height,'-*')
    hold on
end
legend('Location', 'NorthEast')
title('Local Response RW-A20-P10-S38: Test - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
legend('0.28%','0.38%','0.56%','0.75%', '1.1%', '1.5%', '2.3%', '3.1%')
text(2e-3, 2300, datafolder, 'FontSize', 14);
%xlim([-1e-4 0.005])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
box on
grid on
hold off

%% ========================================================================
% FORMA N�1
% =========================================================================
% Inicializacion de estructura para almacenamiento de variables
node_HorDisp = struct();
for i = 3:18        % 18 nodos
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
nLevels = 8;
nSteps = size(HorDisp, 1);

for i = 1:nSteps
    for j = 1:nLevels
        NodeHorStrain(j,i) = (HorDisp(i,j*2-1)-HorDisp(i,j*2))/Lw;
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

Height = [315.69 631.37 947.06 1262.74 1578.43 1894.11 2209.8 2438.4]; 

figure()
for i = 1:length(PosDisp)
    %drift = PosDisp(i)/Hw*100;
    %plot(-NodeHorStrain_PosCycle(:,i),Height,'--*','DisplayName',[num2str(drift), '%'])
     plot(-NodeHorStrain_PosCycle(:,i),Height,'--*')
    hold on
end
legend('Location', 'NorthEast')
text(2e-3, 2300, datafolder, 'FontSize', 14);
title('Local Response RW-A20-P10-S38 (Nodes): Model - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height(mm)')
legend('0.28%','0.38%','0.56%','0.75%', '1.1%', '1.5%', '2.3%', '3.1%')
%text(20, -300, sprintf('E_{D} = %.2f [kNmm]', area_total), 'FontSize', 11);
%xlim([-1e-4 0.005])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
box on
grid on
hold off

figure()
for i = 1:length(PosDisp)
    %drift = PosDisp(i)/Hw*100;
    %plot(-NodeHorStrain_NegCycle(:,i),Height,'--*','DisplayName',[num2str(drift), '%'])
    plot(-NodeHorStrain_NegCycle(:,i),Height,'--*')
    hold on
end
legend('Location', 'NorthEast')
text(2e-3, 2300, datafolder, 'FontSize', 14);
title('Local Response RW-A20-P10-S38 (Nodes): Model - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height(mm)')
legend('0.28%','0.38%','0.56%','0.75%', '1.1%', '1.5%', '2.3%', '3.1%')
%xlim([-1e-4 0.005])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
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

figure()    % Ciclo Positivo
hold on
for i = 1:length(PosDisp)
    drift = [0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1];
    plot(-NodeHorStrain_PosCycle(:,i),Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'HandleVisibility','off')
    plot(RespLocalTest_PosCycle(:,i),RespLocalTest_Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'HandleVisibility','off')
end
legend('Location', 'NorthEast')
%text(2e-3, 2300, datafolder, 'FontSize', 14);
%title('Local Response RW-A20-P10-S38 (Nodes): Test vs Model - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
%xlim([-1e-4 0.005])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
box on
grid on

%figure()    % Ciclo Negativo
%hold on
for i = 1:length(PosDisp)
    drift = [0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1];
    plot(-1*(-NodeHorStrain_NegCycle(:,i)),Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--','HandleVisibility','off')
    plot(-1*(RespLocalTest_NegCycle(:,i)),RespLocalTest_Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'DisplayName',[num2str(drift(i)), '%'])
end
legend('Location', 'NorthEast')
text(-7e-3, 2300, datafolder, 'FontSize', 14);
title('Respuesta Local RW-A20-P10-S38 (Nodos): Test vs Modelo')
xlabel('Deformaci�n Horizontal')
ylabel('Altura (mm)')
xlim([-8e-3 8e-3])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
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
for i = 1:8         % 8 elementos
    for j = 1:8     % 8 paneles
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
nLevels = 8;

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

height = [157.85 473.53 789.22 1104.90 1420.59 1736.27 2051.96 2324.10];

figure()
for i = 1:length(PosDisp)
    drift = [0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1];
    plot(eps_xx_height_PosCycle(:,i),height,'--*','DisplayName',[num2str(drift(i)), '%'])
    hold on
end
legend('Location', 'NorthEast')
text(2e-3, 2300, datafolder, 'FontSize', 14);
title('Local Response RW-A20-P10-S38: Model - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height(mm)')
%xlim([-1e-4 0.005])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
box on
grid on
hold off

figure()
for i = 1:length(PosDisp)
    drift = [0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1];
    plot(eps_xx_height_NegCycle(:,i),height,'--*','DisplayName',[num2str(drift(i)), '%'])
    hold on
end
legend('Location', 'NorthEast')
text(2e-3, 2300, datafolder, 'FontSize', 14);
title('Local Response RW-A20-P10-S38: Model - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height(mm)')
%xlim([-1e-4 0.005])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
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

figure()    % Ciclo Positivo
hold on
for i = 1:length(PosDisp)
    drift = [0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1];
    plot(eps_xx_height_PosCycle(:,i),height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'HandleVisibility','off')
    plot(RespLocalTest_PosCycle(:,i),RespLocalTest_Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'HandleVisibility','off')
end
legend('Location', 'NorthEast')
%text(2e-3, 2300, datafolder, 'FontSize', 14);
title('Respuesta Local RW-A20-P10-S38: Test vs Modelo')
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
for i = 1:length(PosDisp)
    drift = [0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1];
    plot(-1*(eps_xx_height_NegCycle(:,i)),height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'HandleVisibility','off')
    plot(-1*(RespLocalTest_NegCycle(:,i)),RespLocalTest_Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'DisplayName',[num2str(drift(i)), '%'])
end
legend('Location', 'NorthEast')
text(-7e-3, 2300, datafolder, 'FontSize', 14);
%title('Local Response RW-A20-P10-S38: Test vs Model - Negative Cycle')
%xlabel('Horizontal Strain')
%ylabel('Height (mm)')
xlim([-8e-3 8e-3])
%ylim([0 800])
%xticks([0 0.001 0.002 0.003 0.004 0.005]);
%yticks([0 100 200 300 400 500 600 700 800]);
%xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
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
    drift = [0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1];
    plot(-NodeHorStrain_PosCycle(:,i),Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'DisplayName',['Model (Nodes) - ', num2str(drift(i)), '%'])
    plot(eps_xx_height_PosCycle(:,i),height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'DisplayName',['Model (Panels) - ', num2str(drift(i)), '%'])
end
legend('Location', 'NorthEast')
text(2e-3, 2300, datafolder, 'FontSize', 14);
title('Local Response RW-A20-P10-S38 Model: Nodes vs Panels - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
%legend('0.05%','0.10%','0.15%','0.20%', '0.30%', '0.40%', '0.60%', '0.80%', '1%')
% xlim([-1e-4 0.005])
% ylim([0 800])
% xticks([0 0.001 0.002 0.003 0.004 0.005]);
% yticks([0 100 200 300 400 500 600 700 800]);
% xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
box on
grid on

figure()    % Ciclo Negativo
hold on
for i = 1:length(PosDisp)
    drift = [0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1];
    plot(-NodeHorStrain_NegCycle(:,i),Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'DisplayName',['Model (Nodes) - ', num2str(drift(i)), '%'])
    plot(eps_xx_height_NegCycle(:,i),height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'DisplayName',['Model (Panels) - ', num2str(drift(i)), '%'])
end
legend('Location', 'NorthEast')
text(2e-3, 2300, datafolder, 'FontSize', 14);
title('Local Response RW-A20-P10-S38 Model: Nodes vs Panels - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
% xlim([-1e-4 0.005])
% ylim([0 800])
% xticks([0 0.001 0.002 0.003 0.004 0.005]);
% yticks([0 100 200 300 400 500 600 700 800]);
% xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
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