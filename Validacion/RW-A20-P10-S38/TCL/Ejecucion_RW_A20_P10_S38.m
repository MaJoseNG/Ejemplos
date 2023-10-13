%% ========================================================================
% Global Response
% =========================================================================
%directoryTest = 'C:\repos\Ejemplos\Validacion\RW-A20-P10-S38\Test\RW-A20-P10-S38_Test.txt';                           % PC Civil
directoryTest = 'C:\Users\maryj\Documents\GitHub\Ejemplos\Validacion\RW-A20-P10-S38\Test\RW-A20-P10-S38_Test.txt';     % Note

datafolder_RCLMS02C02S02 = 'RCLMS02C02S02';    
datafolder_RCLMS01C02S02 = 'RCLMS01C02S02';
%%
[~, ~, ~, ~, ~, ~] = plotGlobalResponse_RW_A20_P10_S38(datafolder_RCLMS02C02S02, directoryTest);
[~, ~, ~, ~, ~, ~] = plotGlobalResponse_RW_A20_P10_S38(datafolder_RCLMS01C02S02, directoryTest);


%% ========================================================================
% Local Response
% =========================================================================
LocalResponse_RW_A20_P10_S38(datafolder_RCLMS02C02S02)
LocalResponse_RW_A20_P10_S38(datafolder_RCLMS01C02S02)

%% ========================================================================
% Energy dissipation
% =========================================================================
EnergyDissipation_RW_A20_P10_S38(datafolder_RCLMS02C02S02,directoryTest)
EnergyDissipation_RW_A20_P10_S38(datafolder_RCLMS02C02S02,directoryTest)

%% Damage Factor: beta_d
beta_d1 =@(x) 1/(1+0.1*x^0.5);        % pre-cracking
beta_d2 =@(x) 1/(1+0.175*x^0.6);      % post-cracking
beta_d3 =@(x) 1/(1+0.175*x^0.5);      
figure()
fplot(beta_d1, [0 2.0])
hold on
fplot(beta_d2, [0 2.0])
fplot(beta_d3, [0 2.0],'--')
xlabel('\epsilon_{rec}/\epsilon_{p}')
ylabel('\beta_{d}')
legend('\alpha_{1} = 0.1 \alpha_{2} = 0.5' ,'\alpha_{1} = 0.175 \alpha_{2} = 0.6','\alpha_{1} = 0.175 \alpha_{2} = 0.5')
grid on
box on
%ylim([0 1.0])