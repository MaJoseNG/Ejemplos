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
DFlexure_Test = Test(:, 3);
DShear_Test = Test(:, 4);

figure()
plot(LatDisp_Test,LatLoad_Test)
xlabel('Lateral Displacement (mm)')
ylabel('Lateral Load (kN)')

figure()
plot(DShear_Test,LatLoad_Test)
xlabel('Lateral Shear Displacement (mm)')
ylabel('Lateral Load (kN)')
xlim([-8 8])
ylim([-1000 1000])

figure()
plot(DFlexure_Test,LatLoad_Test)
xlabel('Lateral Flexural Displacement (mm)')
ylabel('Lateral Load (kN)')
xlim([-8 8])
ylim([-1000 1000])

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
load('S34_testD.mat');

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
datafolderMEFISection = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO';

NodeDispMEFISection = importdata(fullfile(datafolderMEFISection,'NODE_DISP.out'));
Node1ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_1.out'));
Node2ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_2.out'));
Node3ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_3.out'));

LatLoadMEFISection = Node1ReacMEFISection(:,2)+Node2ReacMEFISection(:,2)+Node3ReacMEFISection(:,2);    %[N]
NodeLateralDispMEFISection = NodeDispMEFISection(:,2);                %[mm]
% hw = 750;       %[mm]
% drift = NodeLateralDispMEFISection/hw*100;      %[%]
% 
% t = tiledlayout(1,1);
% ax1 = axes(t);
% hold on
% plot(ax1,[0, 0], [-1000, 1000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');      % Línea vertical (eje X)
% plot(ax1, [-20, 20], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');          % Línea horizontal (eje Y)
% plot(ax1, LatDisp_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
% plot(ax1, NodeLateralDispMEFISection,-LatLoadMEFISection/1000,'--r','DisplayName', 'MEFISection - Concrete02')

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
datafolderMEFISection_Mono = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_ecu_003';
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

%% Calculo de deformaciones principales y evaluacion del factor de daño
% Import data
datafolderMEFISection = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO';

NodeDispMEFISection = importdata(fullfile(datafolderMEFISection,'NODE_DISP.out'));
NodeLateralDispMEFISection = NodeDispMEFISection(:,2);                %[mm]

figure()
plot(NodeLateralDispMEFISection)
grid on
grid minor
xlabel('Load Step')
ylabel('Lateral Displacement (mm)')

% eps_E1P4 = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_4_ele_1_strain.out'));
% eps_E1P4 = eps_E1P4(:,2:end); 
% %%
% for i = 1:length(eps_E1P4)
%     [thetaPD(1,i),strainsPD(:,i)] = calculateStrainPrincipalDirection01(eps_E1P4(i,:));
% end

eps_E1P1 = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_1_strain.out'));
eps_E1P4 = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_4_ele_1_strain.out'));
eps_E5P4 = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_4_ele_5_strain.out'));

eps_E1P1 = eps_E1P1(:,2:end); 
eps_E1P4 = eps_E1P4(:,2:end); 
eps_E5P4 = eps_E5P4(:,2:end); 
for i = 1:length(eps_E5P4)
    [thetaPD_E1P1(1,i),strainsPD_E1P1(:,i)] = calculateStrainPrincipalDirection01(eps_E1P1(i,:));
    [thetaPD_E1P4(1,i),strainsPD_E1P4(:,i)] = calculateStrainPrincipalDirection01(eps_E1P4(i,:));
    [thetaPD_E5P4(1,i),strainsPD_E5P4(:,i)] = calculateStrainPrincipalDirection01(eps_E5P4(i,:));
end


alpha1 = 0.15;
alpha2 = 0.5;
ec0 = -0.002;

e_rec_E1P1 = strainsPD_E1P1(1,840)-strainsPD_E1P1(2,1020);
e_rec_E1P4 = strainsPD_E1P4(1,840)-strainsPD_E1P4(2,1020);
e_rec_E5P4 = strainsPD_E5P4(1,840)-strainsPD_E5P4(2,1020);

beta_E1P1 = 1/(1+alpha1*abs(e_rec_E1P1/ec0)^alpha2);
beta_E1P4 = 1/(1+alpha1*abs(e_rec_E1P4/ec0)^alpha2);
beta_E5P4 = 1/(1+alpha1*abs(e_rec_E5P4/ec0)^alpha2);

beta_E1P1
beta_E1P4
beta_E5P4

%% ========================================================================
% MEFISection
% =========================================================================
% Respuesta Global Pushover Ciclico ---------------------------------------
% Import data
datafolder_1ciclo_075Fc = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_2ciclos_sin_reduccionFc_recorderArreglado';
%datafolder_2ciclo_Fc = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_2ciclos_sin_reduccionFc';
datafolder_2ciclo_Fc = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_3ciclos_alpha1=0.175_alpha2=0.5_Dincr=0.15';
datafolderMono = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_3ciclos_alpha1=0.175_alpha2=0.51_Dincr=0.15';
%datafolderMono = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_Mono_drift24_075Fc';

NodeDispMEFISection_1_075Fc = importdata(fullfile(datafolder_1ciclo_075Fc,'NODE_DISP.out'));
Node1ReacMEFISection_1_075Fc = importdata(fullfile(datafolder_1ciclo_075Fc,'REACTIONS_1.out'));
Node2ReacMEFISection_1_075Fc = importdata(fullfile(datafolder_1ciclo_075Fc,'REACTIONS_2.out'));
Node3ReacMEFISection_1_075Fc = importdata(fullfile(datafolder_1ciclo_075Fc,'REACTIONS_3.out'));

NodeDispMEFISection_2_Fc = importdata(fullfile(datafolder_2ciclo_Fc,'NODE_DISP.out'));
Node1ReacMEFISection_2_Fc = importdata(fullfile(datafolder_2ciclo_Fc,'REACTIONS_1.out'));
Node2ReacMEFISection_2_Fc = importdata(fullfile(datafolder_2ciclo_Fc,'REACTIONS_2.out'));
Node3ReacMEFISection_2_Fc = importdata(fullfile(datafolder_2ciclo_Fc,'REACTIONS_3.out'));

NodeDispMEFISection_Mono = importdata(fullfile(datafolderMono,'NODE_DISP.out'));
Node1ReacMEFISection_Mono = importdata(fullfile(datafolderMono,'REACTIONS_1.out'));
Node2ReacMEFISection_Mono = importdata(fullfile(datafolderMono,'REACTIONS_2.out'));
Node3ReacMEFISection_Mono = importdata(fullfile(datafolderMono,'REACTIONS_3.out'));

LatLoadMEFISection_1_075Fc = Node1ReacMEFISection_1_075Fc(:,2)+Node2ReacMEFISection_1_075Fc(:,2)+Node3ReacMEFISection_1_075Fc(:,2);    %[N]
NodeLateralDispMEFISection_1_075Fc = NodeDispMEFISection_1_075Fc(:,2);                %[mm]

LatLoadMEFISection_2_Fc = Node1ReacMEFISection_2_Fc(:,2)+Node2ReacMEFISection_2_Fc(:,2)+Node3ReacMEFISection_2_Fc(:,2);    %[N]
NodeLateralDispMEFISection_2_Fc = NodeDispMEFISection_2_Fc(:,2);                %[mm]

LatLoadMEFISection_Mono = Node1ReacMEFISection_Mono(:,2)+Node2ReacMEFISection_Mono(:,2)+Node3ReacMEFISection_Mono(:,2);    %[N]
NodeLateralDispMEFISection_Mono = NodeDispMEFISection_Mono(:,2);                %[mm]

% hw = 750;       %[mm]
% drift = NodeLateralDispMEFISection/hw*100;      %[%]
% 
% t = tiledlayout(1,1);
% ax1 = axes(t);
% hold on
% plot(ax1,[0, 0], [-1000, 1000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');      % Línea vertical (eje X)
% plot(ax1, [-20, 20], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');          % Línea horizontal (eje Y)
% plot(ax1, LatDisp_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
% plot(ax1, NodeLateralDispMEFISection,-LatLoadMEFISection/1000,'--r','DisplayName', 'MEFISection - Concrete02')

% Grafico respuesta global vs Test
figure()
hold on
plot([0, 0], [-1000, 1000], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');      % Línea vertical (eje X)
plot([-20, 20], [0, 0], 'color', [0.6 0.6 0.6], 'HandleVisibility','off');          % Línea horizontal (eje Y)
%plot(LatDisp_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
plot(NodeLateralDispMEFISection_1_075Fc,-LatLoadMEFISection_1_075Fc/1000,'-r','DisplayName', '\alpha_{1}=0.15 \alpha_{2}=0.5')
plot(NodeLateralDispMEFISection_2_Fc,-LatLoadMEFISection_2_Fc/1000,'--b','DisplayName', '\alpha_{1}=0.175 \alpha_{2}=0.5')
% plot(NodeLateralDispMEFISection_Mono,-LatLoadMEFISection_Mono/1000,'--k','DisplayName', '\alpha_{1}=0.175 \alpha_{2}=0.51')
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

% ax = gca; % Obtener el objeto de ejes actual
% ax.FontSize = 14; % Tamaño de la letra de los números de los ejes: 10