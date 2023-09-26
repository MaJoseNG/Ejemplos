%% ========================================================================
% Global Response
% =========================================================================
directoryTest = 'C:\repos\Ejemplos\Validacion\RW-A20-P10-S38\Test\RW-A20-P10-S38_Test.txt';
datafolder = 'MEFISection-Concrete02';

[LatLoad_Test, LatDisp_Test, DFlexure_Test, DShear_Test, LatLoad, NodeLateralDisp] = plotGlobalResponse_RW_A20_P10_S38(datafolder, directoryTest);
LatDisp_Test_Teorico = DFlexure_Test + DShear_Test;

% Se verifica si Lat Displacement = Flexural Displacement + Shear
% Displacement
figure()
hold on
plot(LatDisp_Test, LatLoad_Test)
plot(LatDisp_Test_Teorico, LatLoad_Test)


%% ========================================================================
% Local Response
% =========================================================================
LocalResponse_RW_A20_P10_S38(datafolder)