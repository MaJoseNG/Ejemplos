%function [LatLoad_Test, LatDisp_Test, DFlexure_Test, DShear_Test, LatLoad, NodeLateralDisp] = plotGlobalResponse_SW_T2_S3_4(datafolder, directoryTest, model_name)
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %BORRAR 
    datafolder = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_recordersHeightvsHorStrain_v3';
    directoryTest = 'C:\repos\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt';          % PC Civil
    %directoryTest = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt'; %Note
    model_name = 'RCLMS01C02S02';
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Se cargan los datos del test
    Test = load(directoryTest);
    % Se extraen los datos
    LatLoad_Test = Test(:, 1);
    LatDisp_Test = Test(:, 2);
    DFlexure_Test = Test(:, 3);
    DShear_Test = Test(:, 4);

    figure()
    plot(LatDisp_Test)
    xlabel('Número de mediciones')
    ylabel('Lateral Displacement (mm)')
    title('Global Response SW-T2-S3-4: Test')
    grid on
    box on
    
    figure()
    plot(LatDisp_Test,LatLoad_Test)
    xlabel('Lateral Displacement (mm)')
    ylabel('Lateral Load (kN)')
    title('Global Response SW-T2-S3-4: Test')
    grid on
    box on
    
    figure()
    plot(DShear_Test(1:18249),LatLoad_Test(1:18249))
    xlabel('Lateral Shear Displacement (mm)')
    ylabel('Lateral Load (kN)')
    xlim([-8 8])
    ylim([-1000 1000])
    title('Global Response SW-T2-S3-4: Test')
    grid on
    box on

    figure()
    plot(DFlexure_Test(1:18249),LatLoad_Test(1:18249))
    xlabel('Lateral Flexural Displacement (mm)')
    ylabel('Lateral Load (kN)')
    xlim([-8 8])
    ylim([-1000 1000])
    title('Global Response SW-T2-S3-4: Test')
    grid on
    box on
    
%     Uslid_Test = LatDisp_Test - (DFlexure_Test + DShear_Test);
%     figure()
%     plot(Uslid_Test(1:18249),LatLoad_Test(1:18249))
%     xlabel('Lateral Shear Sliding Displacement (mm)')
%     ylabel('Lateral Load (kN)')
%     xlim([-8 8])
%     ylim([-1000 1000])
%     title('Global Response SW-T2-S3-4: Test')
%     grid on
%     box on

    % Se cargan los datos para la respuesta global del modelo
    NodeDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));
    Node1Reac = importdata(fullfile(datafolder,'REACTIONS_1.out'));
    Node2Reac = importdata(fullfile(datafolder,'REACTIONS_2.out'));
    Node3Reac = importdata(fullfile(datafolder,'REACTIONS_3.out'));
    % Se obtiene la carga lateral y el desplazamiento lateral del nodo de
    % control
    LatLoad = Node1Reac(:,2)+Node2Reac(:,2)+Node3Reac(:,2);    %[N]
    NodeLateralDisp = NodeDisp(:,2);                           %[mm]
    
    % Se grafica la respuesta global del modelo
    figure()
    plot(NodeLateralDisp,-LatLoad/1000,'DisplayName',model_name)
    xlabel('Lateral Displacement (mm)')
    ylabel('Lateral Load (kN)')
    title('Global Response SW-T2-S3-4: Model')
    legend('Location', 'NorthWest')
    grid on
    box on
    
    %% Flexural deformations component ------------------------------------
    % =====================================================================
    % FORMA 1
    % =====================================================================
%     % Inicialización de estructura para almacenamiento de variables
%     node_Rot = struct();
%     for i = 4:18
%         % Se importa la información
%         nombre = ['NodeRot_' num2str(i)];
%         file = ['NODE_DISP_' num2str(i) '.out'];
%         valor = importdata(fullfile(datafolder,file));
%         node_Rot.(nombre) = valor(:,4);
%     end
%     
%     % Se extren las rotaciones
%     NodesRot = fieldnames(node_Rot);
%     for i = 1:numel(NodesRot)
%         theta = node_Rot.(NodesRot{i});
%         Rotation(:,i) = theta;
%     end
%     
%     % Se debera hacer alguna manejo de datos con las rotaciones de los
%     % nodos por nivel?
%     nLevels = 5;
%     nSteps = size(Rotation, 1);
%     
%     
%     
%     %PENDIENTE
%     %LevelHeights = [150, 150, 150, 150, 150];
%     % Se integran las rotaciones en la altura del muro para cada paso
%     for i = 1:nSteps
%         for j = 1:nLevels
%             LevelRot(i,j) = Rotation(i,j*3-2);  % Si hago algun manejo aritmetico, no podre usar Rotation 
%         end
%         Uf(i) = 150*trapz(LevelRot(i,:));
%         %Uf_Pr(i) = trapz(LevelHeights, LevelRot(i,:));
%     end
%     
%     figure()
%     plot(-Uf,-LatLoad/1000)
%     xlabel('Lateral Flexural Displacement (mm)')
%     ylabel('Lateral Load (kN)')
%     %xlim([-8 8])
%     ylim([-1000 1000])
%     title('Global Response SW-T2-S3-4: Model')
%     grid on
%     box on
%     
%     Us = NodeLateralDisp-(-Uf');
%     figure()
%     plot(Us,-LatLoad/1000)
%     xlabel('Lateral Shear Displacement (mm)')
%     ylabel('Lateral Load (kN)')
%     %xlim([-8 8])
%     ylim([-1000 1000])
%     title('Global Response SW-T2-S3-4: Model')
%     grid on
%     box on
    
    %% ====================================================================
    % FORMA 2
    % =====================================================================
    % Identificacion de load steps
    figure()
    plot(NodeLateralDisp)
    grid on
    xlabel('Load Step')
    ylabel('Lateral Displacement (mm)')
    box on
    
    % Se cargan los datos requeridos
    Node16Disp = importdata(fullfile(datafolder,'NODE_DISP_16.out'));
    Node18Disp = importdata(fullfile(datafolder,'NODE_DISP_18.out'));

    % Se extraen los desplazamientos en y
    Node16_VertDisp = Node16Disp(:,3);                          %[mm]
    Node18_VertDisp = Node18Disp(:,3);                          %[mm]
    % Se extraen los desplazamientos en x
    Node16_HorDisp = Node16Disp(:,2);                           %[mm]
    Node18_HorDisp = Node18Disp(:,2);                           %[mm]
    
    nSteps = size(Node18_VertDisp,1);
    lw = 1500;                                                   %[mm]
    hw = 750;                                                    %[mm]
    alpha = 0.67;
    
    for i = 1:nSteps
        rot(i) = (Node16_VertDisp(i)-Node18_VertDisp(i))/lw;
    end
    
    Uf = alpha*rot*hw;
    figure()
    plot(Uf(1:1725),-LatLoad(1:1725)/1000)
    xlabel('Lateral Flexural Displacement (mm)')
    ylabel('Lateral Load (kN)')
    xlim([-8 8])
    ylim([-1000 1000])
    title('Global Response SW-T2-S3-4: Model')
    grid on
    box on
    
    
    
    %% Shear deformations component ---------------------------------------
    % =====================================================================
    % FORMA 1
    % =====================================================================
    % Shear deformations component: Ushear = Utotal - Uf
    Us_resta = NodeLateralDisp-Uf';
    figure()
    plot(Us_resta(1:1725),-LatLoad(1:1725)/1000)
    xlabel('Lateral Shear Displacement (mm)')
    ylabel('Lateral Load (kN)')
    xlim([-8 8])
    ylim([-1000 1000])
    title('Global Response SW-T2-S3-4: Model')
    grid on
    box on
    
    %% ====================================================================
    % FORMA 2
    % =====================================================================
    for i = 1: nSteps
        xf1(i) = lw + Node18_HorDisp(i);
        yf1(i) = hw + Node18_VertDisp(i);
        D1meas(i) = (xf1(i)^2 + yf1(i)^2)^0.5;
        
        xf2(i) = lw - Node16_HorDisp(i);
        yf2(i) = hw + Node16_VertDisp(i);
        D2meas(i) = (xf2(i)^2 + yf2(i)^2)^0.5;
        
        Us_Xcorrected(i) = ((D1meas(i)^2 - hw^2)^0.5 - (D2meas(i)^2 - hw^2)^0.5)/2 + (0.5*rot(i)*hw) - (alpha*rot(i)*hw);
    end
    
    figure()
    hold on
    plot(Us_Xcorrected(1:1725),-LatLoad(1:1725)/1000)
    plot(Us_resta(1:1725),-LatLoad(1:1725)/1000)
    xlabel('Lateral Shear Displacement (mm)')
    ylabel('Lateral Load (kN)')
    xlim([-8 8])
    ylim([-1000 1000])
    legend('Us corrected','Us resta')
    title('Global Response SW-T2-S3-4: Model')
    grid on
    box on
    
    %% Sliding deformations component -------------------------------------
%     Uslid = NodeLateralDisp - (Uf' + Us_Xcorrected');
%     
%     figure()
%     plot(Uslid(1:1725),-LatLoad(1:1725)/1000)
%     xlabel('Lateral Shear Sliding Displacement (mm)')
%     ylabel('Lateral Load (kN)')
%     xlim([-8 8])
%     ylim([-1000 1000])
%     title('Global Response SW-T2-S3-4: Model')
%     grid on
%     box on
    
    %% Comparacion Test vs Modelo ------------------------------------------
    figure()
    hold on
    plot(LatDisp_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
    plot(NodeLateralDisp,-LatLoad/1000,'--r','DisplayName', model_name)
    xlabel('Lateral Displacement (mm)')
    ylabel('Lateral Load (kN)')
    title('Global Response SW-T2-S3-4: Test vs Model')
    legend('Location', 'NorthWest')
    grid on
    box on
    hold off
    
    figure()
    hold on
    plot(DFlexure_Test(1:18249),LatLoad_Test(1:18249),'-k', 'DisplayName', 'Test')
    plot(Uf(1:1725),-LatLoad(1:1725)/1000,'--r','DisplayName', model_name)
    xlabel('Lateral Flexural Displacement (mm)')
    ylabel('Lateral Load (kN)')
    xlim([-8 8])
    ylim([-1000 1000])
    title('Global Response SW-T2-S3-4: Test vs Model')
    legend('Location', 'NorthWest')
    grid on
    box on
    hold off
    
%     figure()
%     hold on
%     plot(DShear_Test(1:18249),LatLoad_Test(1:18249),'-k', 'DisplayName', 'Test')
%     plot(Us_resta(1:1725),-LatLoad(1:1725)/1000,'--r','DisplayName', model_name)
%     xlabel('Lateral Shear Displacement (mm)')
%     ylabel('Lateral Load (kN)')
%     xlim([-8 8])
%     ylim([-1000 1000])
%     title('Global Response SW-T2-S3-4: Test vs Model')
%     legend('Location', 'NorthWest')
%     grid on
%     box on
%     hold off
    
    figure()
    hold on
    plot(DShear_Test(1:18249),LatLoad_Test(1:18249),'-k', 'DisplayName', 'Test')
    plot(Us_Xcorrected(1:1725),-LatLoad(1:1725)/1000,'--r','DisplayName', model_name)
    xlabel('Lateral Shear Displacement (mm)')
    ylabel('Lateral Load (kN)')
    xlim([-8 8])
    ylim([-1000 1000])
    title('Global Response SW-T2-S3-4: Test vs Model')
    legend('Location', 'NorthWest')
    grid on
    box on
    hold off
    
    %% Comparacion Cuantitativa Test vs Modelo ----------------------------
%     % Test ---------------------------------------------------------
%     avg_TotLatDisp_Test_0_02 = mean(LatDisp_Test(1:9091));
%     avg_TotLatDisp_Test_02_04 = mean(LatDisp_Test(9092:13190));
%     avg_TotLatDisp_Test_04_08 = mean(LatDisp_Test(13191:18249));
%     
%     avg_FlexDef_Test_0_02 = mean(DFlexure_Test(1:9091));
%     avg_FlexDef_Test_02_04 = mean(DFlexure_Test(9092:13190));
%     avg_FlexDef_Test_04_08 = mean(DFlexure_Test(13191:18249));
%     
%     avg_ShearDef_Test_0_02 = mean(DShear_Test(1:9091));
%     avg_ShearDef_Test_02_04 = mean(DShear_Test(9092:13190));
%     avg_ShearDef_Test_04_08 = mean(DShear_Test(13191:18249));
%     
%     LatDispSuma_Test = DFlexure_Test+DShear_Test;
%     avg_LatDispSuma_Test_0_02 = mean(LatDispSuma_Test(1:9091));
%     avg_LatDispSuma_Test_02_04 = mean(LatDispSuma_Test(9092:13190));
%     avg_LatDispSuma_Test_04_08 = mean(LatDispSuma_Test(13191:18249));
%     
%     % Se calculan los porcentajes del Test
%     avgDefContribFlexTest_0_02 = avg_FlexDef_Test_0_02/avg_TotLatDisp_Test_0_02*100
%     avgDefContribFlexTest_02_04 = avg_FlexDef_Test_02_04/avg_TotLatDisp_Test_02_04*100
%     avgDefContribFlexTest_04_08 = avg_FlexDef_Test_04_08/avg_TotLatDisp_Test_04_08*100
%     
%     avgDefContribShearTest_0_02 = avg_ShearDef_Test_0_02/avg_TotLatDisp_Test_0_02*100
%     avgDefContribShearTest_02_04 = avg_ShearDef_Test_02_04/avg_TotLatDisp_Test_02_04*100
%     avgDefContribShearTest_04_08 = avg_ShearDef_Test_04_08/avg_TotLatDisp_Test_04_08*100
%     
%     avgDefContribFlexShearTest_0_02 = avg_LatDispSuma_Test_0_02/avg_TotLatDisp_Test_0_02*100
%     avgDefContribFlexShearTest_02_04 = avg_LatDispSuma_Test_02_04/avg_TotLatDisp_Test_02_04*100
%     avgDefContribFlexShearTest_04_08 = avg_LatDispSuma_Test_04_08/avg_TotLatDisp_Test_04_08*100
%     
%     % Modelo -------------------------------------------------------
%     avg_TotLatDisp_Model_0_02 = mean(NodeLateralDisp(1+21:452));
%     avg_TotLatDisp_Model_02_04 = mean(NodeLateralDisp(453:878));
%     avg_TotLatDisp_Model_04_08 = mean(NodeLateralDisp(879:1725));
%     
%     avg_FlexDef_Model_0_02 = mean(Uf(1+21:452));
%     avg_FlexDef_Model_02_04 = mean(Uf(453:878));
%     avg_FlexDef_Model_04_08 = mean(Uf(879:1725));
%     
%     avg_ShearDef_Model_0_02 = mean(Us_Xcorrected(1+21:452));
%     avg_ShearDef_Model_02_04 = mean(Us_Xcorrected(453:878));
%     avg_ShearDef_Model_04_08 = mean(Us_Xcorrected(879:1725));
%     
%     LatDispSuma_Model = Uf+Us_Xcorrected;
%     avg_LatDispSuma_Model_0_02 = mean(LatDispSuma_Model(1+21:452));
%     avg_LatDispSuma_Model_02_04 = mean(LatDispSuma_Model(453:878));
%     avg_LatDispSuma_Model_04_08 = mean(LatDispSuma_Model(879:1725));
%     
%     % Se calculan los porcentajes del Test
%     avgDefContribFlexModel_0_02 = avg_FlexDef_Model_0_02/avg_TotLatDisp_Model_0_02*100
%     avgDefContribFlexModel_02_04 = avg_FlexDef_Model_02_04/avg_TotLatDisp_Model_02_04*100
%     avgDefContribFlexModel_04_08 = avg_FlexDef_Model_04_08/avg_TotLatDisp_Model_04_08*100
%     
%     avgDefContribShearModel_0_02 = avg_ShearDef_Model_0_02/avg_TotLatDisp_Model_0_02*100
%     avgDefContribShearModel_02_04 = avg_ShearDef_Model_02_04/avg_TotLatDisp_Model_02_04*100
%     avgDefContribShearModel_04_08 = avg_ShearDef_Model_04_08/avg_TotLatDisp_Model_04_08*100
%     
%     avgDefContribFlexShearModel_0_02 = avg_LatDispSuma_Model_0_02/avg_TotLatDisp_Model_0_02*100
%     avgDefContribFlexShearModel_02_04 = avg_LatDispSuma_Model_02_04/avg_TotLatDisp_Model_02_04*100
%     avgDefContribFlexShearModel_04_08 = avg_LatDispSuma_Model_04_08/avg_TotLatDisp_Model_04_08*100
%end