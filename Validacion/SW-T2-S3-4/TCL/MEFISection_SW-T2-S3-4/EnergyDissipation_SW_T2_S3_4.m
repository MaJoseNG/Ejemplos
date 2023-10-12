%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BORRAR 
datafolder = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_recordersHeightvsHorStrain_v3';
directoryTest = 'C:\repos\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt';          % PC Civil
%directoryTest = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt'; %Note
model_name = 'RCLMS01C02S02';
%% ========================================================================
% Energia disipada: Modelo
% =========================================================================
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
Ecum_drift = cumsum(Edrift);

drift = [0.05 0.1 0.15 0.2 0.3 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.4]; %[%]

figure()
hold on
plot(drift,Edrift,'-o')
plot(drift,Ecum_drift,'-o')
legend('Energía disipada por deriva','Energía disipada acumulada')
title(['Energía disipada SW-T2-S3-4: Modelo ', model_name])
xlabel('Deriva [%]')
ylabel('Energía Disipada [kNmm]')
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
legend('Energía disipada por deriva','Energía disipada acumulada')
title('Energía disipada SW-T2-S3-4: Test')
xlabel('Deriva [%]')
ylabel('Energía Disipada [kNmm]')
box on
grid on

% Comparacion Energia disipada Model vs Test ------------------------------
figure()
hold on
plot(drift,Edrift,'--or','HandleVisibility','off')
plot(drift,Ecum_drift,'--ok','HandleVisibility','off')
plot(drift,Edrift_Test,'-or','DisplayName','Energia disipada por deriva')
plot(drift,Ecum_drift_Test,'-ok','DisplayName','Energía disipada acumulada')
xticks([0 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.4]);
legend('Location', 'NorthWest')
title(['Energía disipada SW-T2-S3-4: Modelo ', model_name])
xlabel('Deriva [%]')
ylabel('Energía Disipada [kNmm]')
box on
grid on

%% Area total ciclo histeretico: Modelo
%desplazamiento = LatDisp_Test;
desplazamiento = NodeLateralDisp;
%carga = LatLoad_Test;
carga = LatLoad;

% Encontrar los índices donde cambia la dirección (carga positiva a carga negativa)
indices_cambio = find(diff(sign(carga)) ~= 0);

% Inicializar un vector para almacenar las áreas por ciclo
%areas_por_ciclo = zeros(1, numel(indices_cambio)-1);

% Crear un gráfico para visualizar los ciclos histeréticos
figure();
plot(desplazamiento, carga, 'b');
hold on;
grid on;

% Inicializar variables para el área total
area_total = 0;

% Recorrer los ciclos y calcular áreas
for i = 1:numel(indices_cambio)-1
    inicio = indices_cambio(i);
    fin = indices_cambio(i+1);
    
    % Calcular el área del ciclo actual
    area_ciclo = trapz(desplazamiento(inicio:fin), carga(inicio:fin));
    
    % Almacenar el área en el vector
    %areas_por_ciclo(i) = area_ciclo;
    
    % Dibujar un sombreado para el ciclo actual
    fill(desplazamiento(inicio:fin), carga(inicio:fin), 'r', 'FaceAlpha', 0.3);
    
    % Sumar el área al área total
    area_total = area_total + area_ciclo;
end

% % Mostrar el vector de áreas por ciclo
% disp('Áreas por ciclo:');
% disp(areas_por_ciclo);

% Configurar etiquetas y título
xlabel('Desplazamiento Lateral [mm]');
ylabel('Carga Lateral [kN]');
title('Energía disipada SW-T2-S3-4: Modelo')

% Mostrar el área total en el gráfico
%subplot(2, 1, 2);
%text(0.5, 0.5, sprintf('Área Total: %.2f', area_total), 'FontSize', 14);
text(5, -600, sprintf('E_{D} = %.2f [kNmm]', area_total), 'FontSize', 11);
%axis off;

% Ajustar el gráfico
hold off;

%% Area total ciclo histeretico: Modelo
desplazamiento = LatDisp_Test;
carga = LatLoad_Test;

% Encontrar los índices donde cambia la dirección (carga positiva a carga negativa)
indices_cambio = find(diff(sign(carga)) ~= 0);

% Inicializar un vector para almacenar las áreas por ciclo
%areas_por_ciclo = zeros(1, numel(indices_cambio)-1);

% Crear un gráfico para visualizar los ciclos histeréticos
figure();
plot(desplazamiento, carga, 'b');
hold on;
grid on;

% Inicializar variables para el área total
area_total = 0;

% Recorrer los ciclos y calcular áreas
for i = 1:numel(indices_cambio)-1
    inicio = indices_cambio(i);
    fin = indices_cambio(i+1);
    
    % Calcular el área del ciclo actual
    area_ciclo = trapz(desplazamiento(inicio:fin), carga(inicio:fin));
    
    % Almacenar el área en el vector
    %areas_por_ciclo(i) = area_ciclo;
    
    % Dibujar un sombreado para el ciclo actual
    fill(desplazamiento(inicio:fin), carga(inicio:fin), 'r', 'FaceAlpha', 0.3);
    
    % Sumar el área al área total
    area_total = area_total + area_ciclo;
end

% % Mostrar el vector de áreas por ciclo
% disp('Áreas por ciclo:');
% disp(areas_por_ciclo);

% Configurar etiquetas y título
xlabel('Desplazamiento Lateral [mm]');
ylabel('Carga Lateral [kN]');
title('Energía disipada SW-T2-S3-4: Test')

% Mostrar el área total en el gráfico
%subplot(2, 1, 2);
%text(0.5, 0.5, sprintf('Área Total: %.2f', area_total), 'FontSize', 14);
text(5, -600, sprintf('E_{D} = %.2f [kNmm]', area_total), 'FontSize', 11);
%axis off;

% Ajustar el gráfico
hold off;