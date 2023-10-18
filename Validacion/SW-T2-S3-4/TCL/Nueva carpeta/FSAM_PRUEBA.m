datafolder = 'RCLMS02C02S02_NUEVA';
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
plot(NodeLateralDisp,-LatLoad/1000)
xlabel('Lateral Displacement (mm)')
ylabel('Lateral Load (kN)')
title('Global Response SW-T2-S3-4: Model')
legend('Location', 'NorthWest')
xlim([-20 20])
ylim([-1000 1000])
grid on
box on