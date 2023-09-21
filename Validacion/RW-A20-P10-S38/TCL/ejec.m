%% ========================================================================
% Test
% =========================================================================
Test = load('C:\repos\Ejemplos\Validacion\RW-A20-P10-S38\Test\RW-A20-P10-S38_Test.txt');

LatLoad_Test = Test(:, 1);
LatDisp_Test = Test(:, 2);
DFlexure_Test = Test(:, 3);
DShear_Test = Test(:, 4);

figure()
plot(LatDisp_Test/25.4,LatLoad_Test)
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
%xlim([-8 8])
%ylim([-1000 1000])