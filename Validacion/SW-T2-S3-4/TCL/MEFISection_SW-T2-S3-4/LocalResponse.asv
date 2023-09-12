datafolder = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_recordersHeightvsHorStrain';
% Node4Disp = importdata(fullfile(datafolder,'NODE_DISPx_4.out'));
% Node5Disp = importdata(fullfile(datafolder,'NODE_DISPx_5.out'));
% Node6Disp = importdata(fullfile(datafolder,'NODE_DISPx_6.out'));
% NodeCtrlDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));        % Control node
% 
% Node4DispX = Node4Disp(:,2);
% Node5DispX = Node5Disp(:,2);
% Node6DispX = Node6Disp(:,2);
% NodeCtrlDispX = NodeCtrlDisp(:,2);             
% 
% % Suma de desplazamientos por nivel y calculo de deformaciones por nivel
% NodeDispX_1erNivel = Node4DispX + Node5DispX + Node6DispX;
% Lw = 1500;       %[mm] 
% NodeStrainX_1erNivel = NodeDispX_1erNivel/Lw;
% 
% % Identificacion de load steps correspondientes a 3er ciclo de cada drift
% % de interes
% figure()
% plot(NodeCtrlDispX)
% grid on
% grid minor
% xlabel('Load Step')
% ylabel('Lateral Displacement (mm)')
% 
% PosDisp = [0.375 0.75 1.125 1.5 2.25 3 4.5 6 7.5];
% NegDisp = -PosDisp;
% %LoadStepsMatrix = zeros(9,3);
% 
% for i = 1:length(PosDisp)
%     LoadStepsMatrixPosCycle(i,:) = find(NodeCtrlDispX == PosDisp(i),3);
%     LoadStepsMatrixNegCycle(i,:) = find(NodeCtrlDispX == NegDisp(i),3);
% end
% 
% %find(NodeCtrlDispX == -0.75,3)
% for i = 1:length(PosDisp)
%     HorizStrain_PosCycle(1,i) = NodeStrainX_1erNivel(LoadStepsMatrixPosCycle(i,3));
%     HorizStrain_NegCycle(1,i) = NodeStrainX_1erNivel(LoadStepsMatrixNegCycle(i,3));
% end
%% ========================================================================
% FORMA N°1
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
    % FORMA N°2
    % =====================================================================
    % Se importa la informacion
    eps_P1E1 = importdata(fullfile(datafolder,'MEFISection_panel_1_ele_1_strain.out'));
    eps_P2E1 = importdata(fullfile(datafolder,'MEFISection_panel_2_ele_1_strain.out'));
    eps_P3E1 = importdata(fullfile(datafolder,'MEFISection_panel_3_ele_1_strain.out'));
    eps_P4E1 = importdata(fullfile(datafolder,'MEFISection_panel_4_ele_1_strain.out'));
    
    eps_P1E2 = importdata(fullfile(datafolder,'MEFISection_panel_1_ele_2_strain.out'));
    eps_P2E2 = importdata(fullfile(datafolder,'MEFISection_panel_2_ele_2_strain.out'));
    eps_P3E2 = importdata(fullfile(datafolder,'MEFISection_panel_3_ele_2_strain.out'));
    eps_P4E2 = importdata(fullfile(datafolder,'MEFISection_panel_4_ele_2_strain.out'));
    
    % Se extraen las deformaciones en x
    eps_xx_P1E1 = eps_P1E1(:,2);
    eps_xx_P2E1 = eps_P2E1(:,2);
    eps_xx_P3E1 = eps_P3E1(:,2);
    eps_xx_P4E1 = eps_P4E1(:,2);
    
    eps_xx_P1E2 = eps_P1E2(:,2);
    eps_xx_P2E2 = eps_P2E2(:,2);
    eps_xx_P3E2 = eps_P3E2(:,2);
    eps_xx_P4E2 = eps_P4E2(:,2);
    
    eps_xx = eps_xx_P1E1+eps_xx_P2E1+eps_xx_P3E1+eps_xx_P4E1+...
        eps_xx_P1E2+eps_xx_P2E2+eps_xx_P3E2+eps_xx_P4E2;
    
    for i = 1:length(PosDisp)
        eps_xx_PosCycle(1,i) = eps_xx(LoadStepsMatrixPosCycle(i,3));
        eps_xx_NegCycle(1,i) = eps_xx(LoadStepsMatrixNegCycle(i,3));
    end
    
%end
