import opensees as ops
import numpy as np
import time
import matplotlib.pyplot as plt

import functions.ModelFunctions as mf
import functions.RecordersFunctions as rf
import functions.AnalysisFunctions as af
import functions.PlotFunctions as pf

# ======================================================================
# Define variables
# ======================================================================
runMEFI = False
runMEFISectionWithFSAM_RCSection = False

runMEFSectionWithConcrete02 = False
runMEFISectionWithConcrete06 = False

runPlotAnalysis = True

# ======================================================================
# MEFI
# ======================================================================
if runMEFI == True:
    # Remove existing model
    ops.wipe()

    # Turn on timer
    startTime = time.time()

    # Build Model
    mf.Nodes()
    mf.UniaxialMat_Steel02()
    mf.UniaxialMat_Concrete02()
    mf.materialsFSAM()
    mf.areaElements_MEFI()
    rf.getRecorders('MEFI', 'MEFI')
    print('########## Model generated successfully ##########')

    # Run gravity analysis
    af.gravityLoadAnalysis()
    print('########## Gravity load applied successfully ##########')

    # Run displacement controlled analysis
    af.displacementControlledAnalysis()

    finishTime = time.time()
    timeSeconds = finishTime - startTime
    print('TOTAL TIME TAKEN: {} segundos'.format(timeSeconds))

# ======================================================================
# MEFISection with FSAM and RCSection
# ======================================================================
if runMEFISectionWithFSAM_RCSection == True:
    # Remove existing model
    ops.wipe()

    # Turn on timer
    startTime = time.time()

    # Build Model
    mf.Nodes()
    mf.UniaxialMat_Steel02()
    mf.UniaxialMat_Concrete02()
    mf.materialsFSAM()
    mf.RCSection_FSAM()
    mf.areaElements_MEFISection()
    rf.getRecorders('MEFISection-RCSection_FSAM', 'MEFISection-RCSection_FSAM')
    print('########## Model generated successfully ##########')

    # Run gravity analysis
    af.gravityLoadAnalysis()
    print('########## Gravity load applied successfully ##########')

    # Run displacement controlled analysis
    af.displacementControlledAnalysis()

    finishTime = time.time()
    timeSeconds = finishTime - startTime
    print('TOTAL TIME TAKEN: {} segundos'.format(timeSeconds))
# =============================================================================
# MEFISection with Concrete02
# =============================================================================

if runMEFSectionWithConcrete02 == True:
    # Remove existing model
    ops.wipe()

    # Turn on timer
    startTime = time.time()

    # Build Model
    mf.Nodes()
    mf.UniaxialMat_Steel02()
    mf.UniaxialMat_Concrete02()
    mf.materialsRCLayerMembraneSection()
    mf.areaElements_MEFISection()
    rf.getRecorders('MEFISection-Concrete02', 'MEFISection-Concrete02')
    print('########## Model generated successfully ##########')

    # Run gravity analysis
    af.gravityLoadAnalysis()
    print('########## Gravity load applied successfully ##########')

    # Run displacement controlled analysis
    af.displacementControlledAnalysis()

    finishTime = time.time()
    timeSeconds = finishTime - startTime
    print('TOTAL TIME TAKEN: {} segundos'.format(timeSeconds))

# =============================================================================
# MEFISection with Concrete06
# =============================================================================
if runMEFISectionWithConcrete06 == True:
    # Remove existing model
    ops.wipe()

    # Turn on timer
    startTime = time.time()

    # Build Model
    mf.Nodes()
    mf.UniaxialMat_Steel02()
    mf.UniaxialMat_Concrete06()
    mf.materialsRCLayerMembraneSection()
    mf.areaElements_MEFISection()
    rf.getRecorders('MEFISection-Concrete06', 'MEFISection-Concrete06')
    print('########## Model generated successfully ##########')

    # Run gravity analysis
    af.gravityLoadAnalysis()
    print('########## Gravity load applied successfully ##########')

    # Run displacement controlled analysis
    af.displacementControlledAnalysis()

    finishTime = time.time()
    timeSeconds = finishTime - startTime
    print('TOTAL TIME TAKEN: {} segundos'.format(timeSeconds))

# =============================================================================
# Plot Analysis
# =============================================================================
if runPlotAnalysis == True:
    # Global Response
    LatLoadMEFI, NodeLateralDispMEFI = pf.plotGlobalResponse('MEFI', 'MEFI')
    LatLoadMEFISection_RCSectionFSAM, NodeLateralDispMEFISection_RCSectionFSAM = pf.plotGlobalResponse('MEFISection-RCSection_FSAM', 'MEFISection-RCSection_FSAM')
    LatLoadMEFISection_Concrete02, NodeLateralDispMEFISection_Concrete02 = pf.plotGlobalResponse('MEFISection-Concrete02', 'MEFISection-Concrete02')
    LatLoadMEFISection_Concrete06, NodeLateralDispMEFISection_Concrete06 = pf.plotGlobalResponse('MEFISection-Concrete06', 'MEFISection-Concrete06')

    # Local Response
    # epsyy_panel_1MEFI, epsyy_panel_8MEFI, sigyy_panel_1MEFI, sigyy_panel_8MEFI = pf.plotLocalResponse('MEFI', 'MEFI')
    # epsyy_panel_1MEFISection, epsyy_panel_8MEFISection, sigyy_panel_1MEFISection, sigyy_panel_8MEFISection = pf.plotLocalResponse('MEFISection', 'MEFISection')
#
    # Comparacion de curvas: Respuesta Global
    fig, ax = plt.subplots()
    plt.plot(NodeLateralDispMEFI, -LatLoadMEFI/1000, label='MEFI' , linewidth=1, linestyle='--')
    plt.plot(NodeLateralDispMEFISection_RCSectionFSAM, -LatLoadMEFISection_RCSectionFSAM/1000, label='MEFISection-RCSection_FSAM', linewidth=1, linestyle='--')
    #plt.plot(NodeLateralDispMEFISection_Concrete02, -LatLoadMEFISection_Concrete02/1000, label='MEFISection-Concrete02' , linewidth=1)
    #plt.plot(NodeLateralDispMEFISection_Concrete06, -LatLoadMEFISection_Concrete06/1000, label='MEFISection-Concrete06', linewidth=1)

    plt.ylim(-500, 500)

    plt.legend()
    plt.title('Global Response Cyclic Pushover')
    plt.xlabel('Lateral Displacement (mm)')
    plt.ylabel('Lateral Load (kN)')
    plt.grid(True)

    # Mostrar el gráfico
    plt.show()

    # # Comparacion de curvas: Respuesta Local
    # fig, ax = plt.subplots()
    # plt.plot(epsyy_panel_1MEFI, sigyy_panel_1MEFI*152.4, label='MEFI' , linewidth=1, linestyle='--')
    # plt.plot(epsyy_panel_1MEFISection, sigyy_panel_1MEFISection, label='MEFISection' , linewidth=1)
    #
    # plt.legend()
    # plt.title('1st panel resultant stress versus strain X-Y plane')
    # plt.xlabel('Strain, $\epsilon_y$')
    # plt.ylabel('Stress, $\sigma_y$ (MPa)')
    # plt.grid(True)
    #
    # # Mostrar el gráfico
    # plt.show()
    #
    #
    # fig, ax = plt.subplots()
    # plt.plot(epsyy_panel_8MEFI, sigyy_panel_8MEFI*152.4, label='MEFI' , linewidth=1, linestyle='--')
    # plt.plot(epsyy_panel_8MEFISection, sigyy_panel_8MEFISection, label='MEFISection' , linewidth=1)
    #
    # plt.legend()
    # plt.title('8th panel resultant stress versus strain X-Y plane')
    # plt.xlabel('Strain, $\epsilon_y$')
    # plt.ylabel('Stress, $\sigma_y$ (MPa)')
    # plt.grid(True)
    #
    # # Mostrar el gráfico
    # plt.show()

    # COMPARACION: TEST VS MODELOS
    Test = np.loadtxt('C:/repos/Ejemplos/Validacion/RW-A20-P10-S38/Test/RW-A20-P10-S38_Test.txt')
    LatDisp_Test = Test[:, 1]       # mm
    LatLoad_Test = Test[:, 0]       # kN

    fig, ax = plt.subplots()
    plt.plot(LatDisp_Test, LatLoad_Test, label='Test', linewidth=1)
    plt.plot(NodeLateralDispMEFI, -LatLoadMEFI / 1000, label='MEFI', linewidth=1, linestyle='--')
    plt.ylim(-500, 500)
    plt.legend()
    plt.title('Global Response RW-A20-P10-S38')
    plt.xlabel('Lateral Displacement (mm)')
    plt.ylabel('Lateral Load (kN)')
    plt.grid(True)
    # Mostrar el gráfico
    plt.show()

    fig, ax = plt.subplots()
    plt.plot(LatDisp_Test, LatLoad_Test, label='Test', linewidth=1)
    plt.plot(NodeLateralDispMEFI, -LatLoadMEFI / 1000, label='MEFISection-RCSection_FSAM', linewidth=1, linestyle='--')
    plt.ylim(-500, 500)
    plt.legend()
    plt.title('Global Response RW-A20-P10-S38')
    plt.xlabel('Lateral Displacement (mm)')
    plt.ylabel('Lateral Load (kN)')
    plt.grid(True)
    # Mostrar el gráfico
    plt.show()

    fig, ax = plt.subplots()
    plt.plot(LatDisp_Test, LatLoad_Test, label='Test', linewidth=1)
    plt.plot(NodeLateralDispMEFISection_Concrete02, -LatLoadMEFISection_Concrete02 / 1000, label='MEFISection-Concrete02', linewidth=1, linestyle='--')
    plt.ylim(-500, 500)
    plt.legend()
    plt.title('Global Response RW-A20-P10-S38')
    plt.xlabel('Lateral Displacement (mm)')
    plt.ylabel('Lateral Load (kN)')
    plt.grid(True)
    # Mostrar el gráfico
    plt.show()

    fig, ax = plt.subplots()
    plt.plot(LatDisp_Test, LatLoad_Test, label='Test', linewidth=1)
    plt.plot(NodeLateralDispMEFISection_Concrete06, -LatLoadMEFISection_Concrete06 / 1000,
             label='MEFISection-Concrete06', linewidth=1, linestyle='--')
    plt.ylim(-500, 500)
    plt.legend()
    plt.title('Global Response RW-A20-P10-S38')
    plt.xlabel('Lateral Displacement (mm)')
    plt.ylabel('Lateral Load (kN)')
    plt.grid(True)
    # Mostrar el gráfico
    plt.show()












