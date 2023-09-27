%clc;clear all;
%% ========================================================================
% Global Response
% =========================================================================
directoryTest = 'C:\repos\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt';          % PC Civil
%directoryTest = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\SW-T2-S3-4\Test\SW-T2-S3-4_Test.txt'; %Note

datafolder_RCLMS01C02S02 = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc02_Steel02_NUEVO_recordersHeightvsHorStrain_v2';
%datafolder_RCLMS01C06S02 = 'MEFISection_SW-T2-S3-4_RCLMS01_Conc06_Steel02_NUEVO_n=2.5_k=0.75_original';

modelname = 'RCLMS01C02S02';

[~, ~, ~, ~, LatLoad_RCLMS01C02S02,NodeLateralDisp_RCLMS01C02S02] = plotGlobalResponse_SW_T2_S3_4(datafolder_RCLMS01C02S02, directoryTest, modelname);
%[LatLoad_RCLMS01C06S02,NodeLateralDisp_RCLMS01C06S02] = plotGlobalResponse(datafolder_RCLMS01C06S02);

%% ========================================================================
% Local Response
% =========================================================================
LocalResponse_SW_T2_S3_4(datafolder_RCLMS01C02S02)


% %% Calculo de deformaciones principales y evaluacion del factor de daño
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
