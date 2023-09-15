datafolder = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_recordersHeightvsHorStrain_v2';
% Node4Disp = importdata(fullfile(datafolder,'NODE_DISPx_4.out'));
% Node5Disp = importdata(fullfile(datafolder,'NODE_DISPx_5.out'));
% Node6Disp = importdata(fullfile(datafolder,'NODE_DISPx_6.out'));
NodeCtrlDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));        % Control node
% 
% Node4DispX = Node4Disp(:,2);
% Node5DispX = Node5Disp(:,2);
% Node6DispX = Node6Disp(:,2);
NodeCtrlDispX = NodeCtrlDisp(:,2);             
% 
% % Suma de desplazamientos por nivel y calculo de deformaciones por nivel
% NodeDispX_1erNivel = Node4DispX + Node5DispX + Node6DispX;
% Lw = 1500;       %[mm] 
% NodeStrainX_1erNivel = NodeDispX_1erNivel/Lw;
% 
% Identificacion de load steps correspondientes a 3er ciclo de cada drift
% de interes
figure()
plot(NodeCtrlDispX)
grid on
grid minor
xlabel('Load Step')
ylabel('Lateral Displacement (mm)')

PosDisp = [0.375 0.75 1.125 1.5 2.25 3 4.5 6 7.5];
NegDisp = -PosDisp;
%LoadStepsMatrix = zeros(9,3);

for i = 1:length(PosDisp)
    LoadStepsMatrixPosCycle(i,:) = find(NodeCtrlDispX == PosDisp(i),3);
    LoadStepsMatrixNegCycle(i,:) = find(NodeCtrlDispX == NegDisp(i),3);
end
% 
% %find(NodeCtrlDispX == -0.75,3)
% for i = 1:length(PosDisp)
%     HorizStrain_PosCycle(1,i) = NodeStrainX_1erNivel(LoadStepsMatrixPosCycle(i,3));
%     HorizStrain_NegCycle(1,i) = NodeStrainX_1erNivel(LoadStepsMatrixNegCycle(i,3));
% end
%% ========================================================================
% FORMA N�1
% =========================================================================
%function LocalResponse(datafolder)
    % Se importan los datos
%     Node4Disp = importdata(fullfile(datafolder,'NODE_DISPx_4.out'));
%     Node5Disp = importdata(fullfile(datafolder,'NODE_DISPx_5.out'));
%     Node6Disp = importdata(fullfile(datafolder,'NODE_DISPx_6.out'));
%     
%     Node7Disp = importdata(fullfile(datafolder,'NODE_DISPx_7.out'));
%     Node8Disp = importdata(fullfile(datafolder,'NODE_DISPx_8.out'));
%     Node9Disp = importdata(fullfile(datafolder,'NODE_DISPx_9.out'));
%     
%     Node10Disp = importdata(fullfile(datafolder,'NODE_DISPx_10.out'));
%     Node11Disp = importdata(fullfile(datafolder,'NODE_DISPx_11.out'));
%     Node12Disp = importdata(fullfile(datafolder,'NODE_DISPx_12.out'));
%     
%     Node13Disp = importdata(fullfile(datafolder,'NODE_DISPx_13.out'));
%     Node14Disp = importdata(fullfile(datafolder,'NODE_DISPx_14.out'));
%     Node15Disp = importdata(fullfile(datafolder,'NODE_DISPx_15.out'));
%     
%     Node16Disp = importdata(fullfile(datafolder,'NODE_DISPx_16.out'));
%     Node17Disp = importdata(fullfile(datafolder,'NODE_DISPx_17.out'));
%     Node18Disp = importdata(fullfile(datafolder,'NODE_DISPx_18.out'));
%     
%     NodeCtrlDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));        % Control node
%     
%     % Se extraen los desplazamientos en X
%     Node4DispX = Node4Disp(:,2);
%     Node5DispX = Node5Disp(:,2);
%     Node6DispX = Node6Disp(:,2);
%     
%     Node7DispX = Node7Disp(:,2);
%     Node8DispX = Node8Disp(:,2);
%     Node9DispX = Node9Disp(:,2);
%     
%     Node10DispX = Node10Disp(:,2);
%     Node11DispX = Node11Disp(:,2);
%     Node12DispX = Node12Disp(:,2);
%     
%     Node13DispX = Node13Disp(:,2);
%     Node14DispX = Node14Disp(:,2);
%     Node15DispX = Node15Disp(:,2);
%     
%     Node16DispX = Node16Disp(:,2);
%     Node17DispX = Node17Disp(:,2);
%     Node18DispX = Node18Disp(:,2);
%     
%     NodeCtrlDispX = NodeCtrlDisp(:,2);             
% 
%     % Suma de desplazamientos por nivel y calculo de deformaciones por nivel
%     NodeDispX_1erNivel = Node4DispX + Node5DispX + Node6DispX;
%     NodeDispX_2doNivel = Node7DispX + Node8DispX + Node9DispX;
%     NodeDispX_3erNivel = Node10DispX + Node11DispX + Node12DispX;
%     NodeDispX_4toNivel = Node13DispX + Node14DispX + Node15DispX;
%     NodeDispX_5toNivel = Node16DispX + Node17DispX + Node18DispX;
%     
%     Lw = 1500;       %[mm]
%     
%     NodeStrainX_1erNivel = NodeDispX_1erNivel/Lw;
%     NodeStrainX_2doNivel = NodeDispX_2doNivel/Lw;
%     NodeStrainX_3erNivel = NodeDispX_3erNivel/Lw;
%     NodeStrainX_4toNivel = NodeDispX_4toNivel/Lw;
%     NodeStrainX_5toNivel = NodeDispX_5toNivel/Lw;
%     
%     NodeStrainX = [NodeStrainX_1erNivel';NodeStrainX_2doNivel';NodeStrainX_3erNivel';NodeStrainX_4toNivel';NodeStrainX_5toNivel'];
%     
%     PosDisp = [0.375 0.75 1.125 1.5 2.25 3 4.5 6 7.5];
%     NegDisp = -PosDisp;
%     nroDrifts = length(PosDisp); 
%     %LoadStepsMatrix = zeros(9,3);
% 
%     for i = 1:length(PosDisp)
%         LoadStepsMatrixPosCycle(i,:) = find(NodeCtrlDispX == PosDisp(i),3);
%         LoadStepsMatrixNegCycle(i,:) = find(NodeCtrlDispX == NegDisp(i),3);
%     end
% 
%     for i = 1:length(PosDisp)
%         HorizStrain_PosCycle(1,i) = NodeStrainX_1erNivel(LoadStepsMatrixPosCycle(i,3));
%         HorizStrain_NegCycle(1,i) = NodeStrainX_1erNivel(LoadStepsMatrixNegCycle(i,3));
%     end
% 
%     
%     for i = 1:5
%         for j=1:nroDrifts
%             HorizStrain_PosCycle(i,j) = NodeStrainX(i,LoadStepsMatrixPosCycle(j,3));
%             HorizStrain_NegCycle(i,j) = NodeStrainX(i,LoadStepsMatrixNegCycle(j,3));
%         end
%     end
%     
%     
%     Height = [150 300 450 600 750];
%     figure()
%     hold on
%     plot(HorizStrain_PosCycle(:,1),Height)
%     plot(HorizStrain_PosCycle(:,2),Height)
%     plot(HorizStrain_PosCycle(:,3),Height)
%     plot(HorizStrain_PosCycle(:,4),Height)
%     plot(HorizStrain_PosCycle(:,5),Height)
%     plot(HorizStrain_PosCycle(:,6),Height)
%     plot(HorizStrain_PosCycle(:,7),Height)
%     plot(HorizStrain_PosCycle(:,8),Height)
%     plot(HorizStrain_PosCycle(:,9),Height)
%     hold off
%     grid on
%     grid minor
%     xlabel('Horizontal Strain')
%     ylabel('Height (mm)')
    
    %% ====================================================================
    % FORMA N�2
    % =====================================================================
    
%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        %eps_xx_height(j,i) = mean(eps_xx(i,j*8-7:j*8));
        eps_xx_height(j,i) = max(eps_xx(i,j*8-7:j*8));
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
title('Local Response: Model - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height(mm)')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
hold off

figure()
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(eps_xx_height_NegCycle(:,i),height,'--*','DisplayName',[num2str(drift), '%'])
    hold on
end
legend('Location', 'NorthEast')
title('Local Response: Model - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height(mm)')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
hold off


% Test --------------------------------------------------------------------
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
title('Local Response: Test - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
legend('0.05%','0.10%','0.15%','0.20%', '0.30%', '0.40%', '0.60%', '0.80%', '1%')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
hold off

figure()
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(RespLocalTest_NegCycle(:,i),RespLocalTest_Height,'-*','DisplayName',[num2str(drift), '%'])
    hold on
end
legend('Location', 'NorthEast')
title('Local Response: Test - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
legend('0.05%','0.10%','0.15%','0.20%', '0.30%', '0.40%', '0.60%', '0.80%', '1%')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});
%yticklabels({'0', ' ', '200', ' ', '400', ' ', '600', ' ', '800'});
hold off

% Comparacion: Modelo vs Test ---------------------------------------------
markers = {'o','+','*','x','s','d','^','p','h'};
colors = {'b','g','r','k','c','m'};
% this function will do the circular selection
% Example:  getprop(colors, 7) = 'b'
getFirst = @(v)v{1}; 
getprop = @(options, idx)getFirst(circshift(options,-idx+1));

figure()
hold on
for i = 1:length(PosDisp)
    drift = PosDisp(i)/Hw*100;
    plot(eps_xx_height_PosCycle(:,i),height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'DisplayName',['Model - ', num2str(drift), '%'])
    plot(RespLocalTest_PosCycle(:,i),RespLocalTest_Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'DisplayName',['Test - ', num2str(drift), '%'])
end
legend('Location', 'NorthEast')
title('Local Response: Test vs Model - Positive Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
%legend('0.05%','0.10%','0.15%','0.20%', '0.30%', '0.40%', '0.60%', '0.80%', '1%')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});

figure()
hold on
for i = 1:length(PosDisp)
    plot(eps_xx_height_NegCycle(:,i),height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','--', 'DisplayName',['Model - ', num2str(drift), '%'])
    plot(RespLocalTest_NegCycle(:,i),RespLocalTest_Height,'Marker',getprop(markers,i),'color',getprop(colors,i),'linestyle','-', 'DisplayName',['Test - ', num2str(drift), '%'])
end
legend('Location', 'NorthEast')
title('Local Response: Test vs Model - Negative Cycle')
xlabel('Horizontal Strain')
ylabel('Height (mm)')
xlim([-1e-4 0.005])
ylim([0 800])
xticks([0 0.001 0.002 0.003 0.004 0.005]);
yticks([0 100 200 300 400 500 600 700 800]);
xticklabels({'0', ' ', '0.002', ' ', '0.004', ' '});