%clc;clear all;
%% ========================================================================
% Global Response
% =========================================================================
%directoryTest = 'C:\repos\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt';          % PC Civil
directoryTest = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt'; %Note

%datafolder_RCLMS01C02S02 = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_recordersHeightvsHorStrain_v2';
%datafolder_RCLMS01C06S02 = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc06_Steel02_NUEVO_n=2.5_k=0.75_original';

datafolder_RCLMS01C02S02 = 'RCLMS01C02S02-3';
datafolder_RCLMS01C06S02 = 'RCLMS01C06S02-3';
datafolder_RCLMS02C02S02 = 'RCLMS02C02S02-3_Push2.4';

modelname_RCLMS01C02S02 = 'RCLMS01C02S02';
modelname_RCLMS01C06S02 = 'RCLMS01C06S02';
modelname_RCLMS02C02S02 = 'RCLMS02C02S02';
%%
[~, ~, ~, ~, ~, ~] = plotGlobalResponse_SW_T2_S3_4(datafolder_RCLMS01C02S02, directoryTest, modelname_RCLMS01C02S02);
[~, ~, ~, ~, ~, ~] = plotGlobalResponse_SW_T2_S3_4(datafolder_RCLMS01C06S02, directoryTest, modelname_RCLMS01C06S02);

%% ========================================================================
% Respuesta Monotonica para FSAM
% =========================================================================
Test = load(directoryTest);
% Se extraen los datos del test
LatLoad_Test = Test(:, 1);
LatDisp_Test = Test(:, 2);

% Se cargan los datos para la respuesta global del modelo
NodeDisp = importdata(fullfile(datafolder_RCLMS02C02S02,'NODE_DISP.out'));
Node1Reac = importdata(fullfile(datafolder_RCLMS02C02S02,'REACTIONS_1.out'));
Node2Reac = importdata(fullfile(datafolder_RCLMS02C02S02,'REACTIONS_2.out'));
Node3Reac = importdata(fullfile(datafolder_RCLMS02C02S02,'REACTIONS_3.out'));
% Se obtiene la carga lateral y el desplazamiento lateral del nodo de
% control
LatLoad = Node1Reac(:,2)+Node2Reac(:,2)+Node3Reac(:,2);    %[N]
NodeLateralDisp = NodeDisp(:,2);                           %[mm]

figure()
hold on
plot(LatDisp_Test,LatLoad_Test,'-k', 'DisplayName', 'Test')
plot(NodeLateralDisp,-LatLoad/1000,'--r','DisplayName', modelname_RCLMS02C02S02)
xlabel('Desplazamiento Lateral (mm)')
ylabel('Carga Lateral (kN)')
title('Respuesta Global SW-T2-S3-4: Test vs Modelo')
xlim([-20 20])
ylim([-1000 1000])
legend('Location', 'NorthWest')
grid on
box on
hold off
% We define the name for the results figure to be saved
figureName = [modelname_RCLMS02C02S02 '-LatLoadvsLatDisp_ModelvsTest'];
% We save the figure
print(fullfile('Figuras modelos',figureName),'-dpng')
%% ========================================================================
% Local Response
% =========================================================================
LocalResponse_SW_T2_S3_4(datafolder_RCLMS01C02S02, modelname_RCLMS01C02S02)
LocalResponse_SW_T2_S3_4(datafolder_RCLMS01C06S02, modelname_RCLMS01C06S02)

%% ========================================================================
% Energy dissipation
% =========================================================================
EnergyDissipation_SW_T2_S3_4(datafolder_RCLMS01C02S02,directoryTest, modelname_RCLMS01C02S02)
EnergyDissipation_SW_T2_S3_4(datafolder_RCLMS01C06S02,directoryTest, modelname_RCLMS01C06S02)

%% Calculo de deformaciones principales y evaluacion del factor de da�o
% % Import data
% %datafolderMEFISection = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO';
% 
% NodeDispMEFISection = importdata(fullfile(datafolder_RCLMS01C02S02,'NODE_DISP.out'));
% NodeLateralDispMEFISection = NodeDispMEFISection(:,2);                %[mm]
% 
% figure()
% plot(NodeLateralDispMEFISection)
% grid on
% grid minor
% xlabel('Load Step')
% ylabel('Lateral Displacement (mm)')
% 
% % eps_E1P4 = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_4_ele_1_strain.out'));
% % eps_E1P4 = eps_E1P4(:,2:end); 
% % %%
% % for i = 1:length(eps_E1P4)
% %     [thetaPD(1,i),strainsPD(:,i)] = calculateStrainPrincipalDirection01(eps_E1P4(i,:));
% % end
% 
% eps_E1P1 = importdata(fullfile(datafolder_RCLMS01C02S02,'MEFISection_panel_1_strain.out'));
% eps_E1P4 = importdata(fullfile(datafolder_RCLMS01C02S02,'MEFISection_panel_4_ele_1_strain.out'));
% eps_E5P4 = importdata(fullfile(datafolder_RCLMS01C02S02,'MEFISection_panel_4_ele_5_strain.out'));
% 
% eps_E1P1 = eps_E1P1(:,2:end); 
% eps_E1P4 = eps_E1P4(:,2:end); 
% eps_E5P4 = eps_E5P4(:,2:end); 
% for i = 1:length(eps_E5P4)
%     [thetaPD_E1P1(1,i),strainsPD_E1P1(:,i)] = calculateStrainPrincipalDirection01(eps_E1P1(i,:));
%     [thetaPD_E1P4(1,i),strainsPD_E1P4(:,i)] = calculateStrainPrincipalDirection01(eps_E1P4(i,:));
%     [thetaPD_E5P4(1,i),strainsPD_E5P4(:,i)] = calculateStrainPrincipalDirection01(eps_E5P4(i,:));
% end
% 
% 
% alpha1 = 0.15;
% alpha2 = 0.5;
% ec0 = -0.002;
% 
% e_rec_E1P1 = strainsPD_E1P1(1,840)-strainsPD_E1P1(2,1020);
% e_rec_E1P4 = strainsPD_E1P4(1,840)-strainsPD_E1P4(2,1020);
% e_rec_E5P4 = strainsPD_E5P4(1,840)-strainsPD_E5P4(2,1020);
% 
% beta_E1P1 = 1/(1+alpha1*abs(e_rec_E1P1/ec0)^alpha2);
% beta_E1P4 = 1/(1+alpha1*abs(e_rec_E1P4/ec0)^alpha2);
% beta_E5P4 = 1/(1+alpha1*abs(e_rec_E5P4/ec0)^alpha2);
% 
% beta_E1P1
% beta_E1P4
% beta_E5P4
% 
