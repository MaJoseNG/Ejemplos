clc;clear all;

datafolder_RCLMS01C02S02 = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO';
datafolder_RCLMS01C06S02 = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc06_Steel02_NUEVO_n=2.5_k=0.75_original';

[LatLoad_RCLMS01C02S02,NodeLateralDisp_RCLMS01C02S02] = plotGlobalResponse(datafolder_RCLMS01C02S02);
[LatLoad_RCLMS01C06S02,NodeLateralDisp_RCLMS01C06S02] = plotGlobalResponse(datafolder_RCLMS01C06S02);

%% ========================================================================
% Test
% =========================================================================
Test = load('C:\repos\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt');

LatLoad_Test = Test(:, 1);
LatDisp_Test = Test(:, 2);
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
%xlim([-8 8])
%ylim([-1000 1000])

figure()
plot(DFlexure_Test,LatLoad_Test)
xlabel('Lateral Flexural Displacement (mm)')
ylabel('Lateral Load (kN)')
xlim([-8 8])
ylim([-1000 1000])





%%
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




%% ========================================================================
% MEFISection
% =========================================================================
% Respuesta Global Pushover Ciclico ---------------------------------------
% Import data
%datafolderMEFISection = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO';
datafolderMEFISection = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc06_Steel02_NUEVO';

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

