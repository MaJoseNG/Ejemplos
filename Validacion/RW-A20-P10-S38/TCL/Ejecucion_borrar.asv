clc;clear all;

%% ========================================================================
% MEFI
% =========================================================================
% Respuesta Global Pushover Cíclico ---------------------------------------
% Import data
datafolderMEFI = 'MEFI';

NodeDispMEFI = importdata(fullfile(datafolderMEFI,'NODE_DISP.out'));
Node1ReacMEFI = importdata(fullfile(datafolderMEFI,'REACTIONS_1.out'));
Node2ReacMEFI = importdata(fullfile(datafolderMEFI,'REACTIONS_2.out'));

LatLoadMEFI = Node1ReacMEFI(:,2)+Node2ReacMEFI(:,2);    %[N]
NodeLateralDispMEFI = NodeDispMEFI(:,2);                %[mm]

% Grafico 
figure()
plot(NodeLateralDispMEFI,-LatLoadMEFI/1000)
xlabel('Lateral Displacement (mm)')
ylabel('Lateral Load (kN)')
title('Ejemplo Pushover Cíclico MEFI')
%legend('Drift = 3.1%')
%ylim([-600 600])
grid on
grid minor

% % Respuesta Local Pushover Cíclico **************************************
% Panel resultant stress vs strain X-Y plane ------------------------------
% Import data
% deformaciones paneles externos elemento 1 
eps_panel_1MEFI = importdata(fullfile(datafolderMEFI,'MEFI_panel_1_strain.out'));     
eps_panel_8MEFI = importdata(fullfile(datafolderMEFI,'MEFI_panel_8_strain.out'));     
% tensiones paneles externos elemento 1
sig_panel_1MEFI = importdata(fullfile(datafolderMEFI,'MEFI_panel_1_stress.out'));      
sig_panel_8MEFI = importdata(fullfile(datafolderMEFI,'MEFI_panel_8_stress.out'));      %

% Se extraen las deformaciones en y
epsyy_panel_1MEFI = eps_panel_1MEFI(:,3);       
epsyy_panel_8MEFI = eps_panel_8MEFI(:,3);       
% Se extraen las tensiones en y
sigyy_panel_1MEFI = sig_panel_1MEFI(:,3);     
sigyy_panel_8MEFI = sig_panel_8MEFI(:,3);      

% Grafico tension-deformacion paneles 1
figure()
plot(epsyy_panel_1MEFI,sigyy_panel_1MEFI)
title('MEFI: 1st panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
%legend('drift = 3.1%')
grid on
grid minor

% Grafico tension-deformacion paneles 8
figure()
plot(epsyy_panel_8MEFI,sigyy_panel_8MEFI)
title('MEFI: 8th panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
%legend('drift = 3.1%')
grid on
grid minor

% Se extraen las deformaciones en x
epsxx_panel_1MEFI = eps_panel_1MEFI(:,2);       
epsxx_panel_8MEFI = eps_panel_8MEFI(:,2);       
% Se extraen las tensiones en y
sigxx_panel_1MEFI = sig_panel_1MEFI(:,2);     
sigxx_panel_8MEFI = sig_panel_8MEFI(:,2);      

% Grafico tension-deformacion paneles 1
figure()
plot(epsxx_panel_1MEFI,sigxx_panel_1MEFI)
title('MEFI: 1st panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_x')
ylabel('Stress, \sigma_x (MPa)')
%legend('drift = 3.1%')
grid on
grid minor

% Grafico tension-deformacion paneles 8
figure()
plot(epsxx_panel_8MEFI,sigxx_panel_8MEFI)
title('MEFI: 8th panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_x')
ylabel('Stress, \sigma_x (MPa)')
%legend('drift = 3.1%')
grid on
grid minor

% Se extraen las deformaciones en xy
epsxy_panel_1MEFI = eps_panel_1MEFI(:,4);       
epsxy_panel_8MEFI = eps_panel_8MEFI(:,4);       
% Se extraen las tensiones en y
sigxy_panel_1MEFI = sig_panel_1MEFI(:,4);     
sigxy_panel_8MEFI = sig_panel_8MEFI(:,4);      

% Grafico tension-deformacion paneles 1
figure()
plot(epsxy_panel_1MEFI,sigxy_panel_1MEFI)
title('MEFI: 1st panel resultant stress versus strain X-Y plane')
xlabel('Strain, \gamma_{xy}')
ylabel('Stress, \tau_{xy} (MPa)')
%legend('drift = 3.1%')
grid on
grid minor

% Grafico tension-deformacion paneles 8
figure()
plot(epsxy_panel_8MEFI,sigxy_panel_8MEFI)
title('MEFI: 8th panel resultant stress versus strain X-Y plane')
xlabel('Strain, \gamma_{xy}')
ylabel('Stress, \tau_{xy} (MPa)')
%legend('drift = 3.1%')
grid on
grid minor

% %  Concrete response: Strain-stress relationship along two inclined
% %  concrete struts --------------------------------------------------------
% % Import data
% epsSigC1_1MEFI = importdata(fullfile(datafolderMEFI,'MEFI_strain_stress_concrete1_1.out'));     % Panel 1 - strut 1
% epsSigC2_1MEFI = importdata(fullfile(datafolderMEFI,'MEFI_strain_stress_concrete2_1.out'));     % Panel 1 - strut 2
% epsSigC1_8MEFI = importdata(fullfile(datafolderMEFI,'MEFI_strain_stress_concrete1_8.out'));     % Panel 8 - strut 1
% epsSigC2_8MEFI = importdata(fullfile(datafolderMEFI,'MEFI_strain_stress_concrete2_8.out'));     % Panel 8 - strut 2
% 
% figure()
% plot(epsSigC1_1MEFI(:,2),epsSigC1_1MEFI(:,3))
% title('Predicted stress-strain behavior for concrete: Strut 1 - Panel 1')
% xlabel('Strain, \epsilon_1')
% ylabel('Stress, \sigma_1 (MPa)')
% legend('STRUT 1')
% grid on
% grid minor
% %xlim([-0.02 0.06])
% figure()
% plot(epsSigC2_1MEFI(:,2),epsSigC2_1MEFI(:,3))
% title('Predicted stress-strain behavior for concrete: Strut 2 - Panel 1')
% xlabel('Strain, \epsilon_2')
% ylabel('Stress, \sigma_2 (MPa)')
% legend('STRUT 2')
% grid on
% grid minor
% %xlim([-0.01 0.03])
% 
% figure()
% plot(epsSigC1_8MEFI(:,2),epsSigC1_8MEFI(:,3))
% title('Predicted stress-strain behavior for concrete: Strut 1 - Panel 8')
% xlabel('Strain, \epsilon_1')
% ylabel('Stress, \sigma_1 (MPa)')
% legend('STRUT 1')
% grid on
% grid minor
% %xlim([-0.02 0.06])
% figure()
% plot(epsSigC2_8MEFI(:,2),epsSigC2_8MEFI(:,3))
% title('Predicted stress-strain behavior for concrete: Strut 2 - Panel 8')
% xlabel('Strain, \epsilon_2')
% ylabel('Stress, \sigma_2 (MPa)')
% legend('STRUT 2')
% grid on
% grid minor
% %xlim([-0.01 0.03])
% 
% % Reinforcing steel response: Strain-stress relationship for horizontal and
% % vertical steel reinforcement --------------------------------------------
% % Import data
% epsSigSX_1MEFI = importdata(fullfile(datafolderMEFI,'MEFI_strain_stress_concrete1_1.out'));     
% epsSigSY_1MEFI = importdata(fullfile(datafolderMEFI,'MEFI_strain_stress_concrete2_1.out')); 
% epsSigSX_8MEFI = importdata(fullfile(datafolderMEFI,'MEFI_strain_stress_concrete1_8.out'));     
% epsSigSY_8MEFI = importdata(fullfile(datafolderMEFI,'MEFI_strain_stress_concrete2_8.out')); 
% 
% figure()
% plot(epsSigSX_1MEFI(:,2),epsSigSX_1MEFI(:,3))
% title('Predicted stress-strain behavior for steel: horizontal - Panel 1')
% xlabel('Strain, \epsilon_X')
% ylabel('Steel Stress, \sigma_{sX} (MPa)')
% legend('STEEL X')
% grid on
% grid minor
% %xlim([-0.01 0.06])
% %ylim([-100 100])
% 
% figure()
% plot(epsSigSY_1MEFI(:,2),epsSigSY_1MEFI(:,3))
% title('Predicted stress-strain behavior for steel: vertical - Panel 1')
% xlabel('Strain, \epsilon_Y')
% ylabel('Steel Stress, \sigma_{sY} (MPa)')
% legend('STEEL Y')
% grid on
% grid minor
% %xlim([-0.01 0.06])
% %ylim([-100 100])
% 
% figure()
% plot(epsSigSX_8MEFI(:,2),epsSigSX_8MEFI(:,3))
% title('Predicted stress-strain behavior for steel: horizontal - Panel 8')
% xlabel('Strain, \epsilon_X')
% ylabel('Steel Stress, \sigma_{sX} (MPa)')
% legend('STEEL X')
% grid on
% grid minor
% %xlim([-0.01 0.06])
% %ylim([-100 100])
% 
% figure()
% plot(epsSigSY_8MEFI(:,2),epsSigSY_8MEFI(:,3))
% title('Predicted stress-strain behavior for steel: vertical - Panel 8')
% xlabel('Strain, \epsilon_Y')
% ylabel('Steel Stress, \sigma_{sY} (MPa)')
% legend('STEEL Y')
% grid on
% grid minor
% %xlim([-0.01 0.06])
% %ylim([-100 100])


%% ========================================================================
% MEFISection - Concrete02
%%=========================================================================
% Respuesta Global Pushover cíclico
% Import data

datafolderMEFISection = 'MEFISection-Concrete02';

NodeDispMEFISection = importdata(fullfile(datafolderMEFISection,'NODE_DISP.out'));
Node1ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_1.out'));
Node2ReacMEFISection = importdata(fullfile(datafolderMEFISection,'REACTIONS_2.out'));

LatLoadMEFISection = Node1ReacMEFISection(:,2)+Node2ReacMEFISection(:,2);    %[N]
NodeLateralDispMEFISection = NodeDispMEFISection(:,2);            %[mm]

% Grafico 
figure()
plot(NodeLateralDispMEFISection,-LatLoadMEFISection/1000)
xlabel('Lateral Displacement (mm)')
ylabel('Lateral Load (kN)')
title('Ejemplo Pushover Cíclico MEFISection ')
legend('MEFISection - Concrete02')
%ylim([-600 600])
grid on
grid minor

%% MEFISection : Respuesta Local Pushover cíclico
%Deformaciones paneles externos elemento 1 
eps_panel_1MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_1_strain.out'));     
eps_panel_8MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_8_strain.out'));     
%Tensiones paneles externos elemento 1
sig_panel_1MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_1_stress.out'));      
sig_panel_8MEFISection = importdata(fullfile(datafolderMEFISection,'MEFISection_panel_8_stress.out'));     

% Se extraen las deformaciones en y
epsyy_panel_1MEFISection = eps_panel_1MEFISection(:,3);    
epsyy_panel_8MEFISection = eps_panel_8MEFISection(:,3);       
% Se extraen las tensiones en y
sigyy_panel_1MEFISection = sig_panel_1MEFISection(:,3);      
sigyy_panel_8MEFISection = sig_panel_8MEFISection(:,3);       

% Grafico tension-deformacion paneles 1
figure()
plot(epsyy_panel_1MEFISection,sigyy_panel_1MEFISection)
title('MEFISection: 1st panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('MEFISection - Concrete02')
%legend('drift = 3.1%')
grid on
grid minor

% Grafico tension-deformacion paneles 8
figure()
plot(epsyy_panel_8MEFISection,sigyy_panel_8MEFISection)
title('MEFISection: 8th panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('MEFISection - Concrete02')
%legend('drift = 3.1%')
grid on
grid minor

% Se extraen las deformaciones en x
epsxx_panel_1MEFISection = eps_panel_1MEFISection(:,2);    
epsxx_panel_8MEFISection = eps_panel_8MEFISection(:,2);       
% Se extraen las tensiones en x
sigxx_panel_1MEFISection = sig_panel_1MEFISection(:,2);      
sigxx_panel_8MEFISection = sig_panel_8MEFISection(:,2);       

% Grafico tension-deformacion paneles 1
figure()
plot(epsxx_panel_1MEFISection,sigxx_panel_1MEFISection)
title('MEFISection: 1st panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_x')
ylabel('Stress, \sigma_x (MPa)')
legend('MEFISection - Concrete02')
%legend('drift = 3.1%')
grid on
grid minor

% Grafico tension-deformacion paneles 8
figure()
plot(epsxx_panel_8MEFISection,sigxx_panel_8MEFISection)
title('MEFISection: 8th panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_x')
ylabel('Stress, \sigma_x (MPa)')
legend('MEFISection - Concrete02')
%legend('drift = 3.1%')
grid on
grid minor

% Se extraen las deformaciones en xy
epsxy_panel_1MEFISection = eps_panel_1MEFISection(:,4);    
epsxy_panel_8MEFISection = eps_panel_8MEFISection(:,4);       
% Se extraen las tensiones en xy
sigxy_panel_1MEFISection = sig_panel_1MEFISection(:,4);      
sigxy_panel_8MEFISection = sig_panel_8MEFISection(:,4);       

% Grafico tension-deformacion paneles 1
figure()
plot(epsxy_panel_1MEFISection,sigxy_panel_1MEFISection)
title('MEFISection: 1st panel resultant stress versus strain X-Y plane')
xlabel('Strain, \gamma_{xy}')
ylabel('Stress, \tau_{xy} (MPa)')
legend('MEFISection - Concrete02')
%legend('drift = 3.1%')
grid on
grid minor

% Grafico tension-deformacion paneles 8
figure()
plot(epsxy_panel_8MEFISection,sigxy_panel_8MEFISection)
title('MEFISection: 8th panel resultant stress versus strain X-Y plane')
xlabel('Strain, \gamma_{xy}')
ylabel('Stress, \tau_{xy} (MPa)')
legend('MEFISection - Concrete02')
%legend('drift = 3.1%')
grid on
grid minor

%% ========================================================================
% MEFISection - Concrete06
%%=========================================================================
% Respuesta Global Pushover cíclico
% Import data

datafolderMEFISection06 = 'MEFISection-Concrete06';

NodeDispMEFISection06 = importdata(fullfile(datafolderMEFISection06,'NODE_DISP.out'));
Node1ReacMEFISection06 = importdata(fullfile(datafolderMEFISection06,'REACTIONS_1.out'));
Node2ReacMEFISection06 = importdata(fullfile(datafolderMEFISection06,'REACTIONS_2.out'));

LatLoadMEFISection06 = Node1ReacMEFISection06(:,2)+Node2ReacMEFISection06(:,2);    %[N]
NodeLateralDispMEFISection06 = NodeDispMEFISection06(:,2);            %[mm]

% Grafico 
figure()
plot(NodeLateralDispMEFISection06,-LatLoadMEFISection06/1000)
xlabel('Lateral Displacement (mm)')
ylabel('Lateral Load (kN)')
title('Ejemplo Pushover Cíclico MEFISection ')
legend('MEFISection - Concrete06')
%ylim([-600 600])
grid on
grid minor

%% MEFISection : Respuesta Local Pushover cíclico
%Deformaciones paneles externos elemento 1 
eps_panel_1MEFISection06 = importdata(fullfile(datafolderMEFISection06,'MEFISection_panel_1_strain.out'));     
eps_panel_8MEFISection06 = importdata(fullfile(datafolderMEFISection06,'MEFISection_panel_8_strain.out'));     
%Tensiones paneles externos elemento 1
sig_panel_1MEFISection06 = importdata(fullfile(datafolderMEFISection06,'MEFISection_panel_1_stress.out'));      
sig_panel_8MEFISection06 = importdata(fullfile(datafolderMEFISection06,'MEFISection_panel_8_stress.out'));     

% Se extraen las deformaciones en y
epsyy_panel_1MEFISection06 = eps_panel_1MEFISection06(:,3);    
epsyy_panel_8MEFISection06 = eps_panel_8MEFISection06(:,3);       
% Se extraen las tensiones en y
sigyy_panel_1MEFISection06 = sig_panel_1MEFISection06(:,3);      
sigyy_panel_8MEFISection06 = sig_panel_8MEFISection06(:,3);       

% Grafico tension-deformacion paneles 1
figure()
plot(epsyy_panel_1MEFISection06,sigyy_panel_1MEFISection06)
title('MEFISection: 1st panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('MEFISection - Concrete06')
%legend('drift = 3.1%')
grid on
grid minor

% Grafico tension-deformacion paneles 8
figure()
plot(epsyy_panel_8MEFISection06,sigyy_panel_8MEFISection06)
title('MEFISection: 8th panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_y')
ylabel('Stress, \sigma_y (MPa)')
legend('MEFISection - Concrete06')
%legend('drift = 3.1%')
grid on
grid minor

% Se extraen las deformaciones en x
epsxx_panel_1MEFISection06 = eps_panel_1MEFISection06(:,2);    
epsxx_panel_8MEFISection06 = eps_panel_8MEFISection06(:,2);       
% Se extraen las tensiones en x
sigxx_panel_1MEFISection06 = sig_panel_1MEFISection06(:,2);      
sigxx_panel_8MEFISection06 = sig_panel_8MEFISection06(:,2);       

% Grafico tension-deformacion paneles 1
figure()
plot(epsxx_panel_1MEFISection06,sigxx_panel_1MEFISection06)
title('MEFISection: 1st panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_x')
ylabel('Stress, \sigma_x (MPa)')
legend('MEFISection - Concrete06')
%legend('drift = 3.1%')
grid on
grid minor

% Grafico tension-deformacion paneles 8
figure()
plot(epsxx_panel_8MEFISection06,sigxx_panel_8MEFISection06)
title('MEFISection: 8th panel resultant stress versus strain X-Y plane')
xlabel('Strain, \epsilon_x')
ylabel('Stress, \sigma_x (MPa)')
legend('MEFISection - Concrete06')
%legend('drift = 3.1%')
grid on
grid minor

% Se extraen las deformaciones en xy
epsxy_panel_1MEFISection06 = eps_panel_1MEFISection06(:,4);    
epsxy_panel_8MEFISection06 = eps_panel_8MEFISection06(:,4);       
% Se extraen las tensiones en xy
sigxy_panel_1MEFISection06 = sig_panel_1MEFISection06(:,4);      
sigxy_panel_8MEFISection06 = sig_panel_8MEFISection06(:,4);       

% Grafico tension-deformacion paneles 1
figure()
plot(epsxy_panel_1MEFISection06,sigxy_panel_1MEFISection06)
title('MEFISection: 1st panel resultant stress versus strain X-Y plane')
xlabel('Strain, \gamma_{xy}')
ylabel('Stress, \tau_{xy} (MPa)')
legend('MEFISection - Concrete06')
%legend('drift = 3.1%')
grid on
grid minor

% Grafico tension-deformacion paneles 8
figure()
plot(epsxy_panel_8MEFISection06,sigxy_panel_8MEFISection06)
title('MEFISection: 8th panel resultant stress versus strain X-Y plane')
xlabel('Strain, \gamma_{xy}')
ylabel('Stress, \tau_{xy} (MPa)')
legend('MEFISection - Concrete06')
%legend('drift = 3.1%')
grid on
grid minor

%% ========================================================================
% GRAFICOS COMPARATIVOS
%%=========================================================================
%% Graficos comparativos MEFI vs MEFISection

% RESPUESTA GLOBAL  
figure()
hold on
plot(NodeLateralDispMEFI,-LatLoadMEFI/1000,'--')
plot(NodeLateralDispMEFISection,-LatLoadMEFISection/1000)
plot(NodeLateralDispMEFISection06,-LatLoadMEFISection06/1000)
xlabel('Lateral Displacement (mm)')
ylabel('Lateral Load (kN)')
%title('Ejemplo Pushover Monotonico MEFI Original TCL')
title('Global Response Cyclic Pushover')
legend('MEFI','MEFISection-Concrete02','MEFISection-Concrete06')
%ylim([-600 600])
grid on
grid minor
hold off

% % RESPUESTA LOCAL: Componente yy  
% figure()
% hold on
% plot(epsyy_panel_1MEFI,sigyy_panel_1MEFI*152.4,'--')
% plot(epsyy_panel_1MEFISection,sigyy_panel_1MEFISection)
% title('1st panel resultant stress versus strain X-Y plane')
% xlabel('Strain, \epsilon_y')
% ylabel('Stress, \sigma_y (MPa)')
% legend('MEFI', 'MEFISection')
% grid on
% grid minor
% hold off
% 
% figure()
% hold on
% plot(epsyy_panel_8MEFI,sigyy_panel_8MEFI*152.4,'--')
% plot(epsyy_panel_8MEFISection,sigyy_panel_8MEFISection)
% title('8th panel resultant stress versus strain X-Y plane')
% xlabel('Strain, \epsilon_y')
% ylabel('Stress, \sigma_y (MPa)')
% legend('MEFI', 'MEFISection')
% grid on
% grid minor
% hold off
% 
% % RESPUESTA LOCAL: Componente xx 
% figure()
% hold on
% plot(epsxx_panel_1MEFI,sigxx_panel_1MEFI*152.4,'--')
% plot(epsxx_panel_1MEFISection,sigxx_panel_1MEFISection)
% title('1st panel resultant stress versus strain X-Y plane')
% xlabel('Strain, \epsilon_x')
% ylabel('Stress, \sigma_x (MPa)')
% legend('MEFI', 'MEFISection')
% grid on
% grid minor
% hold off
% 
% figure()
% hold on
% plot(epsxx_panel_8MEFI,sigxx_panel_8MEFI*152.4,'--')
% plot(epsxx_panel_8MEFISection,sigxx_panel_8MEFISection)
% title('8th panel resultant stress versus strain X-Y plane')
% xlabel('Strain, \epsilon_x')
% ylabel('Stress, \sigma_x (MPa)')
% legend('MEFI', 'MEFISection')
% grid on
% grid minor
% hold off
% 
% % RESPUESTA LOCAL: Componente xy 
% figure()
% hold on
% plot(epsxy_panel_1MEFI,sigxy_panel_1MEFI*152.4,'--')
% plot(epsxy_panel_1MEFISection,sigxy_panel_1MEFISection)
% title('1st panel resultant stress versus strain X-Y plane')
% xlabel('Strain, \gamma_{xy}')
% ylabel('Stress, \tau_{xy} (MPa)')
% legend('MEFI', 'MEFISection')
% grid on
% grid minor
% hold off
% 
% figure()
% hold on
% plot(epsxy_panel_8MEFI,sigxy_panel_8MEFI*152.4,'--')
% plot(epsxy_panel_8MEFISection,sigxy_panel_8MEFISection)
% title('8th panel resultant stress versus strain X-Y plane')
% xlabel('Strain, \gamma_{xy}')
% ylabel('Stress, \tau_{xy} (MPa)')
% legend('MEFI', 'MEFISection')
% grid on
% grid minor
% hold off