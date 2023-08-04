clc;clear all;

%% ========================================================================
% MEFI
% =========================================================================
% Respuesta Global Pushover Ciclico ---------------------------------------
% Import data
%datafolderMEFI = 'MEFISection_SW_T2_S3_4';
% datafolderMEFI = 'MEFI_SW_T2_S3_4';
% 
% NodeDispMEFI = importdata(fullfile(datafolderMEFI,'NODE_DISP.out'));
% Node1ReacMEFI = importdata(fullfile(datafolderMEFI,'REACTIONS_1.out'));
% Node2ReacMEFI = importdata(fullfile(datafolderMEFI,'REACTIONS_2.out'));
% Node3ReacMEFI = importdata(fullfile(datafolderMEFI,'REACTIONS_3.out'));
% 
% LatLoadMEFI = Node1ReacMEFI(:,2)+Node2ReacMEFI(:,2)+Node3ReacMEFI(:,2);    %[N]
% NodeLateralDispMEFI = NodeDispMEFI(:,2);                %[mm]
% 
% % Grafico 
% figure()
% plot(NodeLateralDispMEFI,-LatLoadMEFI)
% xlabel('Desplazamiento (cm)')
% ylabel('Reaccion Horizontal (kgf)')
% title('Ejemplo SW-T2-S3-4 Pushover Cíclico MEFI')
% %legend('Drift = 3.1%')
% ylim([-1e5 1e5])
% xlim([-2 2])
% grid on
% grid minor

% % Si las matrices no quedan del mismo tamaño
% % LatLoad = Node1Reac(1:length(Node2Reac),2)+Node2Reac(:,2);    %[N]
% % NodeLateralDisp = NodeDisp(:,2);            %[mm]
% % 
% % figure()
% % plot(NodeLateralDisp(1:length(LatLoad)),-LatLoad/1000)
% % xlabel('Lateral Displacement (mm)')
% % ylabel('Lateral Load (kN)')
% % grid on
% % grid minor
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

% Grafico 
figure()
plot(NodeLateralDispMEFISection,-LatLoadMEFISection)
xlabel('Desplazamiento (cm)')
ylabel('Reaccion Horizontal (kgf)')
title('Ejemplo SW-T2-S3-4 Pushover Cíclico MEFISection')
%legend('Drift = 3.1%')
%ylim([-1e5 1e5])
%xlim([-2 2])
grid on
grid minor

%% ========================================================================
% Comparacion: MEFI vs MEFISection
% =========================================================================
% figure()
% hold on
% plot(NodeLateralDispMEFI,-LatLoadMEFI,'--')
% plot(NodeLateralDispMEFISection,-LatLoadMEFISection)
% xlabel('Desplazamiento (cm)')
% ylabel('Reaccion Horizontal (kgf)')
% title('Ejemplo SW-T2-S3-4 Pushover Cíclico')
% legend('MEFI','MEFISection')
% ylim([-1e5 1e5])
% xlim([-2 2])
% grid on
% grid minor
