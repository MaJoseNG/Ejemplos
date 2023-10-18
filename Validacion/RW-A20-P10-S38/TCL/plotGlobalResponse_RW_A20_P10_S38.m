function [LatLoad_Test, LatDisp_Test, DFlexure_Test, DShear_Test, LatLoad, NodeLateralDisp] = plotGlobalResponse_RW_A20_P10_S38(datafolder, directoryTest)
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %BORRAR
    %directoryTest = 'C:\repos\Ejemplos\Validacion\RW-A20-P10-S38\Test\RW-A20-P10-S38_Test.txt';     % PC Civil
    %directoryTest = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\RW-A20-P10-S38\Test\RW-A20-P10-S38_Test.txt';     % Note
    %datafolder = 'MEFISection-Concrete02';
    %datafolder = 'RCLMS02C02S02';
    % We define the name of the directory to store the figures in
    dir_name = 'Figuras modelos';
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
    xlabel('Desplazamiento Lateral (mm)')
    ylabel('Carga Lateral (kN)')
    title('Respuesta Global RW-A20-P10-S38: Test')
    xlim([-100 100])
    ylim([-600 600])
    grid on
    box on
    
    figure()
    plot(DShear_Test,LatLoad_Test)
    xlabel('Desplazamiento Lateral por Corte (mm)')
    ylabel('Carga Lateral (kN)')
    xlim([-100 100])
    ylim([-600 600])
    title('Respuesta Global RW-A20-P10-S38: Test')
    grid on
    box on

    figure()
    plot(DFlexure_Test,LatLoad_Test)
    xlabel('Desplazamiento Lateral por Flexión (mm)')
    ylabel('Carga Lateral (kN)')
    xlim([-100 100])
    ylim([-600 600])
    title('Respuesta Global RW-A20-P10-S38: Test')
    grid on
    box on
    
    LatDispSuma_Test = DFlexure_Test + DShear_Test;
    figure()
    hold on
    plot(LatDisp_Test,LatLoad_Test)
    plot(LatDispSuma_Test,LatLoad_Test)
    xlabel('Desplazamiento Lateral (mm)')
    ylabel('Carga Lateral (kN)')
    title('Respuesta Global RW-A20-P10-S38: Test')
    legend('Desplazamiento lateral total','Desplazamiento lateral por corte+flexión')
    xlim([-100 100])
    ylim([-600 600])
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
    xlabel('Desplazamiento Lateral (mm)')
    ylabel('Carga Lateral (kN)')
    title('Respuesta Global RW-A20-P10-S38: Model')
    legend('Location', 'NorthWest')
    xlim([-100 100])
    ylim([-600 600])
    grid on
    box on
    
    % Comparacion Test vs Modelo
    figure()
    hold on
    plot(LatDisp_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
    plot(NodeLateralDisp,-LatLoad/1000,'--r','DisplayName', datafolder)
    xlim([-100 100])
    ylim([-600 600])
    xlabel('Desplazamiento Lateral (mm)')
    ylabel('Carga Lateral (kN)')
    title('Respuesta Global RW-A20-P10-S38: Test vs Modelo')
    legend('Location', 'NorthWest')
    grid on
    box on
    hold off
    % We define the name for the results figure to be saved
    figureName = [datafolder '-LatLoadvsLatDisp_ModelvsTest'];
    % We save the figure
    print(fullfile(dir_name,figureName),'-dpng')
    
%     %% Flexural deformations component ------------------------------------
%     % ====================================================================
%     %FORMA 1
%     %=====================================================================
%     %Se cargan los datos requeridos
%     Node5Disp = importdata(fullfile(datafolder,'NODE_DISP_5.out'));
%     Node6Disp = importdata(fullfile(datafolder,'NODE_DISP_6.out'));
%     Node7Disp = importdata(fullfile(datafolder,'NODE_DISP_7.out'));
%     Node8Disp = importdata(fullfile(datafolder,'NODE_DISP_8.out'));
%     Node9Disp = importdata(fullfile(datafolder,'NODE_DISP_9.out'));
%     Node10Disp = importdata(fullfile(datafolder,'NODE_DISP_10.out'));
%     Node11Disp = importdata(fullfile(datafolder,'NODE_DISP_11.out'));
%     Node12Disp = importdata(fullfile(datafolder,'NODE_DISP_12.out'));
%     Node13Disp = importdata(fullfile(datafolder,'NODE_DISP_13.out'));
%     Node14Disp = importdata(fullfile(datafolder,'NODE_DISP_14.out'));
%     Node17Disp = importdata(fullfile(datafolder,'NODE_DISP_17.out'));
%     Node18Disp = importdata(fullfile(datafolder,'NODE_DISP_18.out'));
%     
%     %Se extraen los desplazamientos en y
%     Node5_VertDisp = Node5Disp(:,3);                            %[mm]
%     Node6_VertDisp = Node6Disp(:,3);                            %[mm]
%     Node7_VertDisp = Node7Disp(:,3);                            %[mm]
%     Node8_VertDisp = Node8Disp(:,3);                            %[mm]
%     Node9_VertDisp = Node9Disp(:,3);                            %[mm]
%     Node10_VertDisp = Node10Disp(:,3);                          %[mm]
%     Node11_VertDisp = Node11Disp(:,3);                          %[mm]
%     Node12_VertDisp = Node12Disp(:,3);                          %[mm]
%     Node13_VertDisp = Node13Disp(:,3);                          %[mm]
%     Node14_VertDisp = Node14Disp(:,3);                          %[mm]
%     Node17_VertDisp = Node17Disp(:,3);                          %[mm]
%     Node18_VertDisp = Node18Disp(:,3);                          %[mm]
%     
%     NodeVertDisp = [Node5_VertDisp,Node6_VertDisp,Node7_VertDisp,...
%         Node8_VertDisp,Node9_VertDisp,Node10_VertDisp,Node11_VertDisp,Node12_VertDisp,Node13_VertDisp,...
%         Node14_VertDisp,Node17_VertDisp,Node18_VertDisp];
%     
%     %Se extraen los desplazamientos en x
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
%     
%     nSteps = size(Node18_VertDisp,1);
%     lw = 1220;                                                   %[mm]
%     hLevel = [631.37, 315.69, 315.69, 315.69, 315.69, 544.29];                                                 %[mm]
%     nLevels = length(hLevel);
%     %alpha = [2/3, 25/48, 19/36, 13/24, 2/3];
%     %alpha = [0.5 0.5 0.5 0.5 0.5 0.5];
%     %nAlpha = length(alpha);
%     
%     for i = 1:nSteps
%         for j = 1:nLevels
%             rot(i,j) = (NodeVertDisp(i,j*2-1)-NodeVertDisp(i,j*2))/lw;
%             Uf(i,j) = rot(i,j)*hLevel(j);
%         end
%     end
% 
%     Uf_totalFORMA2 = sum(Uf,2);
%     
%     figure()
%     plot(Uf_totalFORMA2,-LatLoad/1000,'--r','DisplayName',datafolder)
%     xlabel('Lateral Flexural Displacement (mm)')
%     ylabel('Lateral Load (kN)')
%     %xlim([-8 8])
%     %ylim([-1000 1000])
%     title('Global Response RW-A20-P10-S38: Model')
%     grid on
%     box on
%     hold off
    
%     % ====================================================================
%     FORMA 2
%     =====================================================================
%     alpha = 0.67;
%     hw = 2438.4;
%     for i = 1:nSteps
%         rot(i) = (Node17_VertDisp(i)-Node18_VertDisp(i))/lw;
%     end
%     
%     Uf = alpha*rot*hw;
%     figure()
%     plot(Uf,-LatLoad/1000)
%     xlabel('Lateral Flexural Displacement (mm)')
%     ylabel('Lateral Load (kN)')
%     xlim([-8 8])
%     ylim([-1000 1000])
%     title('Global Response SW-T2-S3-4: Model')
%     grid on
%     box on
%     
%     % ====================================================================
%     FORMA 3
%     =====================================================================
%     Inicialización de estructura para almacenamiento de variables
%     node_Disp = struct();
%     for i = 3:18
%         Se importa la informacion
%         nombre = ['NodeDisplacement_' num2str(i)];
%         file = ['NODE_DISP_' num2str(i) '.out'];
%         valor = importdata(fullfile(datafolder,file));
%         node_Disp.(nombre) = valor;
%     end
%     
%     Se extraen los desplazamientos en y
%     NodesDisp = fieldnames(node_Disp);
%     for i = 1:numel(NodesDisp)
%         D = node_Disp.(NodesDisp{i});
%         VertDisp(:,i) = D(:,3);
%     end
%     
%     nSteps = size(VertDisp,1);
%     nLevels = size(VertDisp,2)/2;
%     lw = 1220;
%   
%     theta = zeros(nSteps,1);
%     x = [315.69,315.69,315.69,315.69,315.69,315.69,315.69,228.6];
%     h1 = sum(x);
%     
%     for i = 1:nSteps
%         for j = 1:nLevels
%               theta(i) = theta(i) + (VertDisp(i,j*2-1)-VertDisp(i,j*2))/lw;
%               phi(i,j) = (VertDisp(i,j*2-1)-VertDisp(i,j*2))/(x(j)*lw);
%         end
%     end
%     
%     num = zeros(nSteps,1);
%     den = zeros(nSteps,1);
%   
%     for i = 1:nSteps
%         for j = 1:nLevels
%             num(i) = num(i) + phi(i,j)*(j-1/2);
%             den(i) = den(i) + phi(i,j)*nLevels;
%         end
%     end
%     
%     alpha = num./den;
%     
%     Uf = alpha.*theta*h;
% 
%     Node1Reac = importdata(fullfile(datafolder,'REACTIONS_1.out'));
%     Node2Reac = importdata(fullfile(datafolder,'REACTIONS_2.out'));
%     Se obtiene la carga lateral y el desplazamiento lateral del nodo de
%     control
%     LatLoad = Node1Reac(:,2)+Node2Reac(:,2);    %[N]
%     
%     figure()
%     plot(Uf,-LatLoad/1000)
%     
%     % ====================================================================
%     FORMA 4
%     =====================================================================
%     Inicialización de estructura para almacenamiento de variables
%     node_Disp = struct();
%     for i = 3:18
%         Se importa la informacion
%         nombre = ['NodeDisplacement_' num2str(i)];
%         file = ['NODE_DISP_' num2str(i) '.out'];
%         valor = importdata(fullfile(datafolder,file));
%         node_Disp.(nombre) = valor;
%     end
%     
%     Se extraen los desplazamientos en y
%     NodesDisp = fieldnames(node_Disp);
%     for i = 1:numel(NodesDisp)
%         D = node_Disp.(NodesDisp{i});
%         VertDisp(:,i) = D(:,3);
%     end
%     
%     nSteps = size(VertDisp,1);
%     nLevels = size(VertDisp,2)/2;
%     lw = 1220;
%   
%     x = [315.69,315.69,315.69,315.69,315.69,315.69,315.69,228.6];
%     h1 = sum(x);
%     
%     for i = 1:nSteps
%         for j = 1:nLevels
%               theta(i,j) = (VertDisp(i,j*2-1)-VertDisp(i,j*2))/lw;
%               phi(i,j) = (VertDisp(i,j*2-1)-VertDisp(i,j*2))/(x(j)*lw);
%         end
%     end
%     
%     theta = sum(theta,2);
%     for j = 1:nLevels
%         num(:,j) = phi(:,j)*((9-j)-1/2);
%     end
%     
%     num = sum(num,2);
%     den = sum(phi,2)*nLevels;
%     alpha = num./den;
% 
%     Uf = alpha.*theta*h1;
%      for i = 1:nSteps
%         for j = 1:nLevels
%             Uf(i,j) = alpha(i)*theta(i,j)*x(j);
%         end
%      end   
% 
%      Uf_final = sum(Uf,2);
%     
%     Node1Reac = importdata(fullfile(datafolder,'REACTIONS_1.out'));
%     Node2Reac = importdata(fullfile(datafolder,'REACTIONS_2.out'));
%     Se obtiene la carga lateral y el desplazamiento lateral del nodo de
%     control
%     LatLoad = Node1Reac(:,2)+Node2Reac(:,2);    %[N]
%     
%     figure()
%     plot(Uf_final,-LatLoad/1000)
    %% ====================================================================
    % FORMA 5
    % =====================================================================
    % Inicialización de estructura para almacenamiento de variables
    node_Disp = struct();
    for i = 3:18
        % Se importa la informacion
        nombre = ['NodeDisplacement_' num2str(i)];
        file = ['NODE_DISP_' num2str(i) '.out'];
        valor = importdata(fullfile(datafolder,file));
        node_Disp.(nombre) = valor;
    end
    
    % Se extraen los desplazamientos en y
    NodesDisp = fieldnames(node_Disp);
    for i = 1:numel(NodesDisp)
        D = node_Disp.(NodesDisp{i});
        VertDisp(:,i) = D(:,3);
    end
    
    nSteps = size(VertDisp,1);
    nLevels = size(VertDisp,2)/2;
    lw = 1220;
  
    x = [315.69,315.69,315.69,315.69,315.69,315.69,315.69,228.6];
    h1 = sum(x);
    
    for i = 1:nSteps
        for j = 1:nLevels
              theta(i,j) = (VertDisp(i,j*2-1)-VertDisp(i,j*2))/lw;
        end
    end
    
    
    for j = 1:nLevels
        UfPiso(:,j) = theta(:,j).*x(j);
    end
    
    Uf_total = sum(UfPiso,2);
    
    figure()
    plot(Uf_total,-LatLoad/1000,'DisplayName',datafolder)
    xlabel('Lateral Flexural Displacement (mm)')
    ylabel('Lateral Load (kN)')
    legend('Location', 'NorthWest')
    xlim([-100 100])
    ylim([-600 600])
    title('Global Response RW-A20-P10-S38: Model')
    grid on
    box on
    
    %% Shear deformations component ---------------------------------------
    % =====================================================================
    % FORMA 1
    % =====================================================================
    % Shear deformations component: Ushear = Utotal - Uf
    Us_resta = NodeLateralDisp-Uf_total;
    figure()
    plot(Us_resta,-LatLoad/1000,'DisplayName',datafolder)
    xlabel('Lateral Shear Displacement (mm)')
    ylabel('Lateral Load (kN)')
    legend('Location', 'NorthWest')
    xlim([-100 100])
    ylim([-600 600])
    title('Global Response RW-A20-P10-S38: Model')
    grid on
    box on
    
    %% Comparacion Test vs Modelo -----------------------------------------
    figure()
    hold on
    plot(DShear_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
    plot(Us_resta,-LatLoad/1000,'--r','DisplayName', datafolder)
    xlabel('Desplazamiento Lateral por Corte (mm)')
    ylabel('Carga Lateral (kN)')
    xlim([-100 100])
    ylim([-600 600])
    title('Respuesta Global RW-A20-P10-S38: Test vs Modelo')
    legend('Location', 'NorthWest')
    grid on
    box on
    hold off
    % We define the name for the results figure to be saved
    figureName = [datafolder '-LatLoadvsLatShearDisp_ModelvsTest'];
    % We save the figure
    print(fullfile(dir_name,figureName),'-dpng')
    
    figure()
    hold on
    plot(DFlexure_Test,LatLoad_Test,'-k','DisplayName','Test')
    plot(Uf_total,-LatLoad/1000,'--r','DisplayName',datafolder)
    xlabel('Desplazamiento Lateral por Flexión (mm)')
    ylabel('Carga Lateral (kN)')
    xlim([-100 100])
    ylim([-600 600])
    title('Respuesta Global RW-A20-P10-S38: Test vs Modelo')
    legend('Location', 'NorthWest')
    grid on
    box on
    hold off
    % We define the name for the results figure to be saved
    figureName = [datafolder '-LatLoadvsLatFlexuralDisp_ModelvsTest'];
    % We save the figure
    print(fullfile(dir_name,figureName),'-dpng')
    
end