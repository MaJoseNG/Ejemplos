clc;clear all;

%% ========================================================================
% MEFISection
% =========================================================================
% Respuesta Global Pushover Ciclico ---------------------------------------
% Import data
datafolderMEFISection = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc06_Steel02';

NodeDispMEFISection = importdata(fullfile(datafolderMEFISection,'NODE_DISP.out'));
Node1ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_1.out'));
Node2ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_2.out'));
Node3ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_3.out'));

LatLoadMEFISection = Node1ReacMEFISection(:,2)+Node2ReacMEFISection(:,2)+Node3ReacMEFISection(:,2);    %[N]
NodeLateralDispMEFISection = NodeDispMEFISection(:,2);                %[mm]

% ========================================================================
% Test
% =========================================================================
Test = load('C:\repos\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt');
LatDisp_Test = Test(:, 2);
LatLoad_Test = Test(:, 1);

% Grafico respuesta global vs Test
figure()
hold on
plot([0, 0], [-1000, 1000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');      % Línea vertical (eje X)
plot([-20, 20], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');          % Línea horizontal (eje Y)
plot(LatDisp_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
plot(NodeLateralDispMEFISection,-LatLoadMEFISection/1000,'--r','DisplayName', 'MEFISection - Concrete06')
%line([0, 0], ylim, 'Color', 'k', 'LineWidth', 1.5); % Eje vertical en negro
%line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 1.5); % Eje horizontal en negro
xlabel('Lateral Displacement (mm)')
ylabel('Lateral Load (kN)')
title('Global Response SW-T2-S3-4')
legend('Location', 'NorthWest')
ylim([-1000, 1000])
xlim([-20 20])
grid on
grid minor
hold off

%%
% Grafico respuesta local
% deformaciones 1er panel elemento 1 y 4to panel elemento 2
eps_panel_1_ele_1_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_1_strain.out'));     
eps_panel_4_ele_2_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_4_strain.out'));     
% tensiones paneles externos elemento 1
sig_panel_1_ele_1_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_1_stress.out'));      
sig_panel_4_ele_2_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_4_stress.out'));      

% Se extraen las deformaciones en y
epsyy_panel_1_ele_1_MEFISection = eps_panel_1_ele_1_MEFISection(:,3);       
epsyy_panel_4_ele_2_MEFISection = eps_panel_4_ele_2_MEFISection(:,3);       
% Se extraen las tensiones en y
sigyy_panel_1_ele_1_MEFISection = sig_panel_1_ele_1_MEFISection(:,3);     
sigyy_panel_4_ele_2_MEFISection = sig_panel_4_ele_2_MEFISection(:,3);      

% Grafico tension-deformacion paneles 1 elemento 1
figure()
hold on
plot([0, 0], [-4000, 4000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea vertical (eje X)
plot([-0.005, 0.03], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea horizontal (eje Y)
plot(epsyy_panel_1_ele_1_MEFISection,sigyy_panel_1_ele_1_MEFISection, '-b', 'DisplayName', 'MEFISection - Concrete06')
title('E1P1: Resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('Location', 'NorthWest')
grid on
grid minor
hold off
% Grafico tension-deformacion paneles 4 elemento 2
figure()
hold on
plot([0, 0], [-4000, 4000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea vertical (eje X)
plot([-0.005, 0.03], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea horizontal (eje Y)
plot(epsyy_panel_4_ele_2_MEFISection,sigyy_panel_4_ele_2_MEFISection, '-b', 'DisplayName', 'MEFISection - Concrete06')
title('E2P4: Resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('Location', 'NorthWest')
grid on
grid minor
hold off

%% Respuesta Local Pushover Monotonico ************************************
% Panel resultant stress vs strain X-Y plane ------------------------------
% Import data
datafolderMEFISection_Mono = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc06_Steel02_Monotonico_1_89';
% deformaciones 1er panel elemento 1 y 4to panel elemento 2
eps_panel_1_ele_1_MEFISection = importdata(fullfile(datafolderMEFISection_Mono,'MEFISection_panel_1_strain.out'));     
eps_panel_4_ele_2_MEFISection = importdata(fullfile(datafolderMEFISection_Mono,'MEFISection_panel_4_strain.out'));     
% tensiones paneles externos elemento 1
sig_panel_1_ele_1_MEFISection = importdata(fullfile(datafolderMEFISection_Mono,'MEFISection_panel_1_stress.out'));      
sig_panel_4_ele_2_MEFISection = importdata(fullfile(datafolderMEFISection_Mono,'MEFISection_panel_4_stress.out'));      

% Se extraen las deformaciones en y
epsyy_panel_1_ele_1_MEFISection = eps_panel_1_ele_1_MEFISection(:,3);       
epsyy_panel_4_ele_2_MEFISection = eps_panel_4_ele_2_MEFISection(:,3);       
% Se extraen las tensiones en y
sigyy_panel_1_ele_1_MEFISection = sig_panel_1_ele_1_MEFISection(:,3);     
sigyy_panel_4_ele_2_MEFISection = sig_panel_4_ele_2_MEFISection(:,3);      

% Grafico tension-deformacion paneles 1 elemento 1
figure()
hold on
plot([0, 0], [0, 4000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea vertical (eje X)
plot([0 0.03], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea horizontal (eje Y)
plot(epsyy_panel_1_ele_1_MEFISection,sigyy_panel_1_ele_1_MEFISection, '-b', 'DisplayName', 'MEFISection - Concrete06')
title('E1P1: Resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('Location','NorthWest')
ylim([0, 4000])
xlim([0 0.03])
grid on
grid minor
hold off
% Grafico tension-deformacion paneles 4 elemento 2
figure()
hold on
plot([0, 0], [-4000 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea vertical (eje X)
plot([-0.005 0], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea horizontal (eje Y)
plot(epsyy_panel_4_ele_2_MEFISection,sigyy_panel_4_ele_2_MEFISection, '-b','DisplayName','MEFISection - Concrete06')
title('E2P4: Resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('Location','NorthWest')
ylim([-4000 0])
xlim([-0.005 0])
grid on
grid minor
hold off

%% ========================================================================
% MEFISection
% =========================================================================
% Respuesta Global Pushover Ciclico ---------------------------------------
% Import data
datafolderMEFISection = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_ecu_0041';

NodeDispMEFISection = importdata(fullfile(datafolderMEFISection,'NODE_DISP.out'));
Node1ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_1.out'));
Node2ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_2.out'));
Node3ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_3.out'));

LatLoadMEFISection = Node1ReacMEFISection(:,2)+Node2ReacMEFISection(:,2)+Node3ReacMEFISection(:,2);    %[N]
NodeLateralDispMEFISection = NodeDispMEFISection(:,2);                %[mm]

% Grafico respuesta global vs Test
figure()
hold on
plot([0, 0], [-1000, 1000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');      % Línea vertical (eje X)
plot([-20, 20], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');          % Línea horizontal (eje Y)
plot(LatDisp_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
plot(NodeLateralDispMEFISection,-LatLoadMEFISection/1000,'--r','DisplayName', 'MEFISection - Concrete02')
%line([0, 0], ylim, 'Color', 'k', 'LineWidth', 1.5); % Eje vertical en negro
%line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 1.5); % Eje horizontal en negro
xlabel('Lateral Displacement (mm)')
ylabel('Lateral Load (kN)')
title('Global Response SW-T2-S3-4')
legend('Location', 'NorthWest')
ylim([-1000, 1000])
xlim([-20 20])
grid on
grid minor
hold off

%%
% Grafico respuesta local
% deformaciones 1er panel elemento 1 y 4to panel elemento 2
eps_panel_1_ele_1_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_1_strain.out'));     
eps_panel_4_ele_2_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_4_strain.out'));     
% tensiones paneles externos elemento 1
sig_panel_1_ele_1_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_1_stress.out'));      
sig_panel_4_ele_2_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_4_stress.out'));      

% Se extraen las deformaciones en y
epsyy_panel_1_ele_1_MEFISection = eps_panel_1_ele_1_MEFISection(:,3);       
epsyy_panel_4_ele_2_MEFISection = eps_panel_4_ele_2_MEFISection(:,3);       
% Se extraen las tensiones en y
sigyy_panel_1_ele_1_MEFISection = sig_panel_1_ele_1_MEFISection(:,3);     
sigyy_panel_4_ele_2_MEFISection = sig_panel_4_ele_2_MEFISection(:,3);      

% Grafico tension-deformacion paneles 1 elemento 1
figure()
hold on
plot([0, 0], [-5000, 5000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea vertical (eje X)
plot([-0.01, 0.06], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea horizontal (eje Y)
plot(epsyy_panel_1_ele_1_MEFISection,sigyy_panel_1_ele_1_MEFISection, '-b', 'DisplayName', 'MEFISection - Concrete02')
title('E1P1: Resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('Location', 'NorthWest')
grid on
grid minor
ylim([-5000, 5000])
hold off
% Grafico tension-deformacion paneles 4 elemento 2
figure()
hold on
plot([0, 0], [-5000, 5000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea vertical (eje X)
plot([-0.01, 0.06], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea horizontal (eje Y)
plot(epsyy_panel_4_ele_2_MEFISection,sigyy_panel_4_ele_2_MEFISection, '-b', 'DisplayName', 'MEFISection - Concrete02')
title('E2P4: Resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('Location', 'NorthWest')
grid on
grid minor
ylim([-5000, 5000])
hold off

%% Respuesta Local Pushover Monotonico ************************************
% Panel resultant stress vs strain X-Y plane ------------------------------
% Import data
datafolderMEFISection_Mono = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_Monotonico_1_89_ecu_0041';
% deformaciones 1er panel elemento 1 y 4to panel elemento 2
eps_panel_1_ele_1_MEFISection = importdata(fullfile(datafolderMEFISection_Mono,'MEFISection_panel_1_strain.out'));     
eps_panel_4_ele_2_MEFISection = importdata(fullfile(datafolderMEFISection_Mono,'MEFISection_panel_4_strain.out'));     
% tensiones paneles externos elemento 1
sig_panel_1_ele_1_MEFISection = importdata(fullfile(datafolderMEFISection_Mono,'MEFISection_panel_1_stress.out'));      
sig_panel_4_ele_2_MEFISection = importdata(fullfile(datafolderMEFISection_Mono,'MEFISection_panel_4_stress.out'));      

% Se extraen las deformaciones en y
epsyy_panel_1_ele_1_MEFISection = eps_panel_1_ele_1_MEFISection(:,3);       
epsyy_panel_4_ele_2_MEFISection = eps_panel_4_ele_2_MEFISection(:,3);       
% Se extraen las tensiones en y
sigyy_panel_1_ele_1_MEFISection = sig_panel_1_ele_1_MEFISection(:,3);     
sigyy_panel_4_ele_2_MEFISection = sig_panel_4_ele_2_MEFISection(:,3);      

% Grafico tension-deformacion paneles 1 elemento 1
figure()
hold on
plot([0, 0], [0, 5000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea vertical (eje X)
plot([0  0.06], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea horizontal (eje Y)
plot(epsyy_panel_1_ele_1_MEFISection,sigyy_panel_1_ele_1_MEFISection, '-b', 'DisplayName', 'MEFISection - Concrete02')
title('E1P1: Resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('Location','NorthWest')
ylim([0, 5000])
xlim([0 0.06])
grid on
grid minor
hold off
% Grafico tension-deformacion paneles 4 elemento 2
figure()
hold on
plot([0, 0], [-5000 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea vertical (eje X)
plot([-0.01 0], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea horizontal (eje Y)
plot(epsyy_panel_4_ele_2_MEFISection,sigyy_panel_4_ele_2_MEFISection, '-b','DisplayName','MEFISection - Concrete02')
title('E2P4: Resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('Location','NorthWest')
ylim([-5000 0])
xlim([-0.01 0])
grid on
grid minor
hold off

%% ========================================================================
% MEFISection
% =========================================================================
% Respuesta Global Pushover Ciclico ---------------------------------------
% Import data
datafolderMEFISection = 'MEFISection_SW-T2-S3-4_RCLMS02_Conc02_Steel02';

NodeDispMEFISection = importdata(fullfile(datafolderMEFISection,'NODE_DISP.out'));
Node1ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_1.out'));
Node2ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_2.out'));
Node3ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_3.out'));

LatLoadMEFISection = Node1ReacMEFISection(:,2)+Node2ReacMEFISection(:,2)+Node3ReacMEFISection(:,2);    %[N]
NodeLateralDispMEFISection = NodeDispMEFISection(:,2);                %[mm]

% Grafico respuesta global vs Test
figure()
hold on
plot([0, 0], [-1000, 1000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');      % Línea vertical (eje X)
plot([-20, 20], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');          % Línea horizontal (eje Y)
plot(LatDisp_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
plot(NodeLateralDispMEFISection,-LatLoadMEFISection/1000,'--r','DisplayName', 'MEFISection - FSAM')
%line([0, 0], ylim, 'Color', 'k', 'LineWidth', 1.5); % Eje vertical en negro
%line(xlim, [0, 0], 'Color', 'k', 'LineWidth', 1.5); % Eje horizontal en negro
xlabel('Lateral Displacement (mm)')
ylabel('Lateral Load (kN)')
title('Global Response SW-T2-S3-4')
legend('Location', 'NorthWest')
ylim([-1000, 1000])
xlim([-20 20])
grid on
grid minor
hold off

%%
% Grafico respuesta local
% deformaciones 1er panel elemento 1 y 4to panel elemento 2
eps_panel_1_ele_1_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_1_strain.out'));     
eps_panel_4_ele_2_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_4_strain.out'));     
% tensiones paneles externos elemento 1
sig_panel_1_ele_1_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_1_stress.out'));      
sig_panel_4_ele_2_MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_4_stress.out'));      

% Se extraen las deformaciones en y
epsyy_panel_1_ele_1_MEFISection = eps_panel_1_ele_1_MEFISection(:,3);       
epsyy_panel_4_ele_2_MEFISection = eps_panel_4_ele_2_MEFISection(:,3);       
% Se extraen las tensiones en y
sigyy_panel_1_ele_1_MEFISection = sig_panel_1_ele_1_MEFISection(:,3);     
sigyy_panel_4_ele_2_MEFISection = sig_panel_4_ele_2_MEFISection(:,3);      

% Grafico tension-deformacion paneles 1 elemento 1
figure()
hold on
plot([0, 0], [-5000, 5000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea vertical (eje X)
plot([-0.01, 0.06], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea horizontal (eje Y)
plot(epsyy_panel_1_ele_1_MEFISection,sigyy_panel_1_ele_1_MEFISection, '-b', 'DisplayName', 'MEFISection - FSAM')
title('E1P1: Resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('Location', 'NorthWest')
grid on
grid minor
ylim([-5000, 5000])
hold off
% Grafico tension-deformacion paneles 4 elemento 2
figure()
hold on
plot([0, 0], [-5000, 5000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea vertical (eje X)
plot([-0.01, 0.06], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off'); % Línea horizontal (eje Y)
plot(epsyy_panel_4_ele_2_MEFISection,sigyy_panel_4_ele_2_MEFISection, '-b', 'DisplayName', 'MEFISection - FSAM')
title('E2P4: Resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('Location', 'NorthWest')
grid on
grid minor
ylim([-5000, 5000])
hold off

