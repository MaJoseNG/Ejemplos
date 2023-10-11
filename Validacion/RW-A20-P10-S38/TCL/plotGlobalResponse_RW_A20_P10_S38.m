%function [LatLoad_Test, LatDisp_Test, DFlexure_Test, DShear_Test, LatLoad, NodeLateralDisp] = plotGlobalResponse_RW_A20_P10_S38(datafolder, directoryTest)
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %BORRAR
    directoryTest = 'C:\repos\Ejemplos\Validacion\RW-A20-P10-S38\Test\RW-A20-P10-S38_Test.txt';     % PC Civil
    %directoryTest = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\RW-A20-P10-S38\Test\RW-A20-P10-S38_Test.txt';     % Note
    datafolder = 'MEFISection-Concrete02';
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Se cargan los datos del test
    Test = load(directoryTest);
    % Se extraen los datos
    LatLoad_Test = Test(:, 1);
    LatDisp_Test = Test(:, 2);
    DFlexure_Test = Test(:, 3);
    DShear_Test = Test(:, 4);

    figure()
    plot(LatDisp_Test,LatLoad_Test)
    xlabel('Lateral Displacement (mm)')
    ylabel('Lateral Load (kN)')
    title('Global Response RW-A20-P10-S38: Test')
    grid on
    box on
    
    figure()
    plot(DShear_Test,LatLoad_Test)
    xlabel('Lateral Shear Displacement (mm)')
    ylabel('Lateral Load (kN)')
    xlim([-80 80])
    %ylim([-1000 1000])
    title('Global Response RW-A20-P10-S38: Test')
    grid on
    box on

    figure()
    plot(DFlexure_Test,LatLoad_Test)
    xlabel('Lateral Flexural Displacement (mm)')
    ylabel('Lateral Load (kN)')
    %xlim([-8 8])
    %ylim([-1000 1000])
    title('Global Response RW-A20-P10-S38: Test')
    grid on
    box on
    
    LatDispSuma_Test = DFlexure_Test + DShear_Test;
    figure()
    hold on
    plot(LatDisp_Test,LatLoad_Test)
    plot(LatDispSuma_Test,LatLoad_Test)
    xlabel('Lateral Displacement (mm)')
    ylabel('Lateral Load (kN)')
    title('Global Response RW-A20-P10-S38: Test')
    legend('Total lateral displacement','Lateral flexural+shear displacement')
    grid on
    box on
    hold off

    % Se cargan los datos para la respuesta global del modelo
    NodeDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));
    Node1Reac = importdata(fullfile(datafolder,'REACTIONS_1.out'));
    Node2Reac = importdata(fullfile(datafolder,'REACTIONS_2.out'));
    % Se obtiene la carga lateral y el desplazamiento lateral del nodo de
    % control
    LatLoad = Node1Reac(:,2)+Node2Reac(:,2);    %[N]
    NodeLateralDisp = NodeDisp(:,2);            %[mm]
    
    % Se grafica la respuesta global del modelo
    figure()
    plot(NodeLateralDisp,-LatLoad/1000,'DisplayName',datafolder)
    xlabel('Lateral Displacement (mm)')
    ylabel('Lateral Load (kN)')
    title('Global Response RW-A20-P10-S38: Model')
    legend('Location', 'NorthWest')
    %ylim([-600 600])
    grid on
    box on
    
    % Comparacion Test vs Modelo
    figure()
    hold on
    plot(LatDisp_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
    plot(NodeLateralDisp,-LatLoad/1000,'--r','DisplayName', datafolder)
    xlabel('Lateral Displacement (mm)')
    ylabel('Lateral Load (kN)')
    title('Global Response RW-A20-P10-S38: Test vs Model')
    legend('Location', 'NorthWest')
    grid on
    box on
    hold off
    
    %% Flexural deformations component ------------------------------------
    %% ====================================================================
    % FORMA 1
    % =====================================================================
    % Identificacion de load steps
    figure()
    plot(NodeLateralDisp)
    grid on
    xlabel('Load Step')
    ylabel('Lateral Displacement (mm)')
    box on
    
    % Se cargan los datos requeridos
    Node5Disp = importdata(fullfile(datafolder,'NODE_DISP_5.out'));
    Node6Disp = importdata(fullfile(datafolder,'NODE_DISP_6.out'));
    Node7Disp = importdata(fullfile(datafolder,'NODE_DISP_7.out'));
    Node8Disp = importdata(fullfile(datafolder,'NODE_DISP_8.out'));
    Node11Disp = importdata(fullfile(datafolder,'NODE_DISP_11.out'));
    Node12Disp = importdata(fullfile(datafolder,'NODE_DISP_12.out'));
    Node13Disp = importdata(fullfile(datafolder,'NODE_DISP_13.out'));
    Node14Disp = importdata(fullfile(datafolder,'NODE_DISP_14.out'));
    Node17Disp = importdata(fullfile(datafolder,'NODE_DISP_17.out'));
    Node18Disp = importdata(fullfile(datafolder,'NODE_DISP_18.out'));
    
    % Se extraen los desplazamientos en y
    Node5_VertDisp = Node5Disp(:,3);                          %[mm]
    Node6_VertDisp = Node6Disp(:,3);                          %[mm]
    Node7_VertDisp = Node7Disp(:,3);                          %[mm]
    Node8_VertDisp = Node8Disp(:,3);                          %[mm]
    Node11_VertDisp = Node11Disp(:,3);                          %[mm]
    Node12_VertDisp = Node12Disp(:,3);                          %[mm]
    Node13_VertDisp = Node13Disp(:,3);                          %[mm]
    Node14_VertDisp = Node14Disp(:,3);                          %[mm]
    Node17_VertDisp = Node17Disp(:,3);                          %[mm]
    Node18_VertDisp = Node18Disp(:,3);                          %[mm]
    
    NodeVertDisp = [Node5_VertDisp,Node6_VertDisp,Node7_VertDisp,...
        Node8_VertDisp,Node11_VertDisp,Node12_VertDisp,Node13_VertDisp,...
        Node14_VertDisp,Node17_VertDisp,Node18_VertDisp];
    
    % Se extraen los desplazamientos en x
%     Node5_HorDisp = Node5Disp(:,2);                          %[mm]
%     Node6_HorDisp = Node6Disp(:,2);                          %[mm]
%     Node7_HorDisp = Node7Disp(:,2);                          %[mm]
%     Node8_HorDisp = Node8Disp(:,2);                          %[mm]
%     Node11_HorDisp = Node11Disp(:,2);                          %[mm]
%     Node12_HorDisp = Node12Disp(:,2);                          %[mm]
%     Node13_HorDisp = Node13Disp(:,2);                          %[mm]
%     Node14_HorDisp = Node14Disp(:,2);                          %[mm]
%     Node17_HorDisp = Node17Disp(:,2);                          %[mm]
%     Node18_HorDisp = Node18Disp(:,2);                          %[mm]
    
    nSteps = size(Node18_VertDisp,1);
    lw = 1220;                                                   %[mm]
    hLevel = [631.37, 315.69, 631.37 315.69, 544.29];                                                 %[mm]
    alpha = [2/3, 25/48, 19/36, 13/24, 2/3];
    nAlpha = length(alpha);
    
    for i = 1:nSteps
        for j = 1:nAlpha
            rot(i,j) = (NodeVertDisp(i,j*2-1)-NodeVertDisp(i,j*2))/lw;
        end
    end
    
    for j = 1:nAlpha
        Uf(:,j) = alpha(j)*rot(:,j)*hLevel(j);
    end
    
    Uf_total = sum(Uf,2);
    
    figure()
    plot(Uf_total,-LatLoad/1000,'--r','DisplayName',datafolder)
    xlabel('Lateral Flexural Displacement (mm)')
    ylabel('Lateral Load (kN)')
    %xlim([-8 8])
    %ylim([-1000 1000])
    title('Global Response RW-A20-P10-S38: Model')
    grid on
    box on
    hold off
    
    %% ====================================================================
    % FORMA 2
    % =====================================================================
    alpha = 0.67;
    hw = 2438.4;
    for i = 1:nSteps
        rot(i) = (Node17_VertDisp(i)-Node18_VertDisp(i))/lw;
    end
    
    Uf = alpha*rot*hw;
    figure()
    plot(Uf,-LatLoad/1000)
    xlabel('Lateral Flexural Displacement (mm)')
    ylabel('Lateral Load (kN)')
    %xlim([-8 8])
    %ylim([-1000 1000])
    title('Global Response SW-T2-S3-4: Model')
    grid on
    box on
    %% Shear deformations component ---------------------------------------
    % =====================================================================
    % FORMA 1
    % =====================================================================
    % Shear deformations component: Ushear = Utotal - Uf
    Us_resta = NodeLateralDisp-Uf_total;
    figure()
    plot(Us_resta,-LatLoad/1000)
    xlabel('Lateral Shear Displacement (mm)')
    ylabel('Lateral Load (kN)')
    xlim([-80 80])
    %ylim([-1000 1000])
    title('Global Response RW-A20-P10-S38: Model')
    grid on
    box on
    
    %% Comparacion Test vs Modelo -----------------------------------------
    figure()
    hold on
    plot(DShear_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
    plot(Us_resta,-LatLoad/1000,'--r','DisplayName', datafolder)
    xlabel('Lateral Shear Displacement (mm)')
    ylabel('Lateral Load (kN)')
    xlim([-80 80])
    %ylim([-1000 1000])
    title('Global Response RW-A20-P10-S38: Test vs Model')
    legend('Location', 'NorthWest')
    grid on
    box on
    hold off
    
    figure()
    hold on
    %plot(Uf_total,-LatLoad/1000,'--r','DisplayName',datafolder)
    plot(Uf,-LatLoad/1000,'--r','DisplayName',datafolder)
    plot(DFlexure_Test,LatLoad_Test,'-k','DisplayName','Test')
    xlabel('Lateral Flexural Displacement (mm)')
    ylabel('Lateral Load (kN)')
    %xlim([-8 8])
    %ylim([-1000 1000])
    title('Global Response RW-A20-P10-S38: Test vs Model')
    legend('Location', 'NorthWest')
    grid on
    box on
    hold off
    
%end