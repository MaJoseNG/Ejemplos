%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BORRAR 
datafolder = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_recordersHeightvsHorStrain_v3';
%directoryTest = 'C:\repos\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt';          % PC Civil
directoryTest = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt'; %Note
model_name = 'RCLMS01C02S02';
%% ========================================================================
% Energia disipada: Modelo
% =========================================================================
% NodeCtrlDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));        % Control node
% NodeCtrlDispX = NodeCtrlDisp(:,2);  
% 
% % Desplazamientos objetivos
% PosDisp = [0.375 0.75 1.125 1.5 2.25 3 4.5 6 7.5 9 10.5 12 13.5 15 18];
% NegDisp = -PosDisp;
% 
% % Se identifican los indices donde se alcanzan los 3 peaks para cada
% % desplazamiento objetivo
% for i = 1:length(PosDisp)
%     LoadStepsMatrixPosCycle(i,:) = find(NodeCtrlDispX == PosDisp(i),3);
%     LoadStepsMatrixNegCycle(i,:) = find(NodeCtrlDispX == NegDisp(i),3);
% end
    
% Se cargan los datos para la respuesta global del modelo
NodeDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));
Node1Reac = importdata(fullfile(datafolder,'REACTIONS_1.out'));
Node2Reac = importdata(fullfile(datafolder,'REACTIONS_2.out'));
Node3Reac = importdata(fullfile(datafolder,'REACTIONS_3.out'));
% Se obtiene la carga lateral y el desplazamiento lateral del nodo de
% control
LatLoad = -(Node1Reac(:,2)+Node2Reac(:,2)+Node3Reac(:,2))/1000;    %[kN]
NodeLateralDisp = NodeDisp(:,2);                           %[mm] 
%figure()
%plot(NodeLateralDisp,LatLoad)

LoadStepsDrifts = [1 83 146 329 452 635 878 1241 1724 2327 3050 3893 4856 5939 7142 8585];
n = length(LoadStepsDrifts);

for i = 1:n-1

    Edrift(i) = trapz(NodeLateralDisp(LoadStepsDrifts(i):LoadStepsDrifts(i+1)),LatLoad(LoadStepsDrifts(i):LoadStepsDrifts(i+1)));
    
end
%Edrift = [0 Edrift]; 
Ecum_drift2 = cumsum(Edrift);

drift = [0.05 0.1 0.15 0.2 0.3 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.4]; %[%]

figure()
hold on
plot(drift,Edrift,'-o')
plot(drift,Ecum_drift2,'-o')
legend('Energ�a disipada por deriva','Energ�a disipada acumulada')
title(['Energ�a disipada: Modelo ', model_name])
xlabel('Deriva [%]')
ylabel('Energ�a Disipada [kNmm]')
box on
grid on
%% ========================================================================
% Energia disipada: Test
% =========================================================================
% Se cargan los datos del test
Test = load(directoryTest);
% Se extraen los datos
LatLoad_Test = Test(:, 1);
LatDisp_Test = Test(:, 2);

LoadStepsDrifts_Test = [2257 3863 5667 7421 9091 10847 13190 15915 18249 20816 23524 25768 27955 29735 31407 33198];
n_Test = length(LoadStepsDrifts_Test);

for i = 1:n_Test-1

    Edrift_Test(i) = trapz(LatDisp_Test(LoadStepsDrifts_Test(i):LoadStepsDrifts_Test(i+1)),LatLoad_Test(LoadStepsDrifts_Test(i):LoadStepsDrifts_Test(i+1)));
    
end

Ecum_drift_Test = cumsum(Edrift_Test);

figure()
hold on
plot(drift,Edrift_Test,'-o')
plot(drift,Ecum_drift_Test,'-o')
legend('Energ�a disipada por deriva','Energ�a disipada acumulada')
title('Energ�a disipada: Test')
xlabel('Deriva [%]')
ylabel('Energ�a Disipada [kNmm]')
box on
grid on

% Comparacion Energia disipada Model vs Test ------------------------------
figure()
hold on
plot(drift,Edrift,'--or')
plot(drift,Ecum_drift2,'--ok')
plot(drift,Edrift_Test,'-or','DisplayName','Energia disipada por deriva')
plot(drift,Ecum_drift_Test,'-ok','DisplayName','Energ�a disipada acumulada')
legend('Location', 'NorthWest')
title(['Energ�a disipada: Modelo ', model_name])
xlabel('Deriva [%]')
ylabel('Energ�a Disipada [kNmm]')
box on
grid on


