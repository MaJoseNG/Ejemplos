% Se cargan los datos para la respuesta global del modelo
datafolder = 'RCLMS01C06S02-Push';
datafolderLP = 'RCLMS01C06S02-PushLp';

NodeDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));
Node1Reac = importdata(fullfile(datafolder,'REACTIONS_1.out'));
Node2Reac = importdata(fullfile(datafolder,'REACTIONS_2.out'));
% Se obtiene la carga lateral y el desplazamiento lateral del nodo de
% control
LatLoad = Node1Reac(:,2)+Node2Reac(:,2);    %[N]
NodeLateralDisp = NodeDisp(:,2);            %[mm]


NodeDispLP = importdata(fullfile(datafolderLP,'NODE_DISP.out'));
Node1ReacLP = importdata(fullfile(datafolderLP,'REACTIONS_1.out'));
Node2ReacLP = importdata(fullfile(datafolderLP,'REACTIONS_2.out'));
% Se obtiene la carga lateral y el desplazamiento lateral del nodo de
% control
LatLoadLP = Node1ReacLP(:,2)+Node2ReacLP(:,2);    %[N]
NodeLateralDispLP = NodeDispLP(:,2);            %[mm]



% Se grafica la respuesta global del modelo
figure()
hold on
plot(NodeLateralDisp,-LatLoad/1000,'DisplayName',datafolder)
plot(NodeLateralDispLP,-LatLoadLP/1000,'DisplayName',datafolderLP)
xlabel('Desplazamiento Lateral (mm)')
ylabel('Carga Lateral (kN)')
title('Respuesta Global RW-A20-P10-S38: Model')
legend('Location', 'NorthWest')
%xlim([-100 100])
%ylim([-600 600])
grid on
box on
hold off