function EnergyDissipation_RW_A20_P10_S38(datafolder,directoryTest)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BORRAR
%directoryTest = 'C:\repos\Ejemplos\Validacion\RW-A20-P10-S38\Test\RW-A20-P10-S38_Test.txt';     % PC Civil
%directoryTest = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\RW-A20-P10-S38\Test\RW-A20-P10-S38_Test.txt';     % Note
%datafolder = 'MEFISection-Concrete02';
%datafolder = 'RCLMS02C02S02';
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We define the name of the directory to store the figures in
dir_name = 'Figuras modelos';
%% ========================================================================
% Energia disipada: Modelo
% =========================================================================
% Se cargan los datos para la respuesta global del modelo
NodeDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));
Node1Reac = importdata(fullfile(datafolder,'REACTIONS_1.out'));
Node2Reac = importdata(fullfile(datafolder,'REACTIONS_2.out'));
% Se obtiene la carga lateral y el desplazamiento lateral del nodo de
% control
LatLoad = -(Node1Reac(:,2)+Node2Reac(:,2))/1000;    %[N]
NodeLateralDisp = NodeDisp(:,2);            %[mm]
figure()
plot(NodeLateralDisp)
ylabel('Lateral Displacement [mm]')
xlabel('Load Step')

%LoadStepsDrifts = [1 435 993 1815 2913 4527 6717 8961 11980];      % dos ciclos para el ultimo drift
LoadStepsDrifts = [1 435 993 1815 2913 4527 6717 8961 10450];       % un ciclo para el ultimo drift
n = length(LoadStepsDrifts);

for i = 1:n-1

    Edrift(i) = trapz(NodeLateralDisp(LoadStepsDrifts(i):LoadStepsDrifts(i+1)),LatLoad(LoadStepsDrifts(i):LoadStepsDrifts(i+1)));
    
end
%Edrift = [0 Edrift]; 
Ecum_drift = cumsum(Edrift);

drift = [0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1]; %[%]

figure()
hold on
plot(drift,Edrift,'-o')
plot(drift,Ecum_drift,'-o')
legend('Energía disipada por deriva','Energía disipada acumulada')
title(['Energía disipada RW-A20-P10-S38: Modelo ', datafolder])
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

figure()
plot(LatDisp_Test)
ylabel('Desplazamiento Lateral (mm)')
xlabel('Número de Mediciones')
grid on
box on
% We define the name for the results figure to be saved
figureName = 'Wall-RWA20P10S38_LoadingProtocol-Test';
% We save the figure
print(fullfile(dir_name,figureName),'-dpng')

LoadStepsDrifts_Test = [4100 5629 6462 7456 8155 9136 9890 10903 11610];
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
title('Energía disipada RW-A20-P10-S38: Test')
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
%xticks([0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1]);
legend('Location', 'NorthWest')
title(['RW-A20-P10-S38: Modelo ', datafolder])
xlabel('Deriva (%)')
ylabel('Energía Disipada (kNmm)')
box on
grid on
% We define the name for the results figure to be saved
figureName = [datafolder '-EnergiaDisipadavsDeriva_ModelvsTest'];
% We save the figure
print(fullfile(dir_name,figureName),'-dpng')

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
xlabel('Desplazamiento Lateral (mm)');
ylabel('Carga Lateral (kN)');
title(['Energía disipada RW-A20-P10-S38: Modelo ', datafolder])
xlim([-100 100])
ylim([-600 600])
% Mostrar el área total en el gráfico
%subplot(2, 1, 2);
%text(0.5, 0.5, sprintf('Área Total: %.2f', area_total), 'FontSize', 14);
text(20, -300, sprintf('E_{D} = %.2f [kNmm]', area_total), 'FontSize', 11);
%axis off;

% Ajustar el gráfico
hold off;
% We define the name for the results figure to be saved
figureName = [datafolder '-EnergiaDisipadaTotal_Model'];
% We save the figure
print(fullfile(dir_name,figureName),'-dpng')
%% Area total ciclo histeretico: Test
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
xlabel('Desplazamiento Lateral (mm)');
ylabel('Carga Lateral (kN)');
title('Energía disipada RW-A20-P10-S38: Test')
xlim([-100 100])
ylim([-600 600])
% Mostrar el área total en el gráfico
%subplot(2, 1, 2);
%text(0.5, 0.5, sprintf('Área Total: %.2f', area_total), 'FontSize', 14);
text(20, -300, sprintf('E_{D} = %.2f [kNmm]', area_total), 'FontSize', 11);
%axis off;

% Ajustar el gráfico
hold off;
% We define the name for the results figure to be saved
figureName = 'Wall-RWA20P10S38_EnergiaDisipadaTotal-Test';
% We save the figure
print(fullfile(dir_name,figureName),'-dpng')
end