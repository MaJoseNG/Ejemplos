function [LatLoad_Test, LatDisp_Test, DFlexure_Test, DShear_Test, LatLoad, NodeLateralDisp] = plotGlobalResponse_RW_A20_P10_S38(datafolder, directoryTest)
    
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
    %xlim([-8 8])
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
end