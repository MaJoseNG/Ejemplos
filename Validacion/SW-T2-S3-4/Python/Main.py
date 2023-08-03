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
runMEFSectionWithConcrete02 = False
runMEFISectionWithConcrete06 = False

runPlotAnalysis = True

# ======================================================================
# MEFI with FSAM-Concrete02
# ======================================================================
if runMEFI == True:
    # Remove existing model
    ops.wipe()

    # Turn on timer
    startTime = time.time()

    # Build Model
    #mf.Nodes()
    mf.NodesFSAM()
    mf.UniaxialMat_Steel02()
    mf.UniaxialMat_Concrete02()
    mf.materialsFSAM()
    mf.areaElements_MEFI()

    rf.getRecorders('MEFI_Concrete02', 'MEFI_Concrete02')

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

    rf.getRecorders('MEFISection_Concrete02', 'MEFISection_Concrete02')

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

    rf.getRecorders('MEFISection_Concrete06', 'MEFISection_Concrete06')

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
    # GLOBAL RESPONSE
    # LatLoadMEFISection02, NodeLateralDispMEFISection02 = pf.plotGlobalResponse('MEFISection_Concrete02',
    #                                                                            'MEFISection_Concrete02')
    # LatLoadMEFISection06, NodeLateralDispMEFISection06 = pf.plotGlobalResponse('MEFISection_Concrete06',
    #                                                                            'MEFISection_Concrete06')
    LatLoadMEFI02, NodeLateralDispMEFI02 = pf.plotGlobalResponse('MEFI_Concrete02', 'MEFI_Concrete02')

    # # COMPARACION: TEST VS MODELOS
    # fileName = 'C:/Users/maryj/Documents/GitHub/Ejemplos/Validacion/SW-T2-S3-4/Test/SW-T2-S3-4_Test.txt'
    # Test = np.loadtxt(fileName, delimiter='\t')
    # LatDisp_Test = Test[:, 1]/10
    # LatLoad_Test = Test[:, 0]*102
    #
    # fig, ax = plt.subplots()
    # plt.plot(LatDisp_Test,LatLoad_Test, label='Test', linewidth=1)
    # plt.plot(NodeLateralDispMEFI02, -LatLoadMEFI02, label='MEFI', linewidth=1, linestyle='--')
    # plt.ylim(-1e5, 1e5)
    # plt.xlim(-2, 2)
    # plt.legend()
    # plt.title('Global Response SW-T2-S3-4')
    # plt.xlabel('Lateral Displacement (cm)')
    # plt.ylabel('Lateral Load (kgf)')
    # plt.grid(True)
    # # Mostrar el gráfico
    # plt.show()
    #
    # fig, ax = plt.subplots()
    # plt.plot(LatDisp_Test, LatLoad_Test, label='Test', linewidth=1)
    # plt.plot(NodeLateralDispMEFISection02, -LatLoadMEFISection02, label='MEFISection-Concrete02', linewidth=1, linestyle='--')
    # plt.ylim(-1e5, 1e5)
    # plt.xlim(-2, 2)
    # plt.legend()
    # plt.title('Global Response SW-T2-S3-4')
    # plt.xlabel('Lateral Displacement (cm)')
    # plt.ylabel('Lateral Load (kgf)')
    # plt.grid(True)
    # # Mostrar el gráfico
    # plt.show()
    #
    # fig, ax = plt.subplots()
    # plt.plot(LatDisp_Test, LatLoad_Test, label='Test', linewidth=1)
    # plt.plot(NodeLateralDispMEFISection06, -LatLoadMEFISection06, label='MEFISection-Concrete06', linewidth=1, linestyle='--')
    # plt.ylim(-1e5, 1e5)
    # plt.xlim(-2, 2)
    # plt.legend()
    # plt.title('Global Response SW-T2-S3-4')
    # plt.xlabel('Lateral Displacement (cm)')
    # plt.ylabel('Lateral Load (kgf)')
    # plt.grid(True)
    # # Mostrar el gráfico
    # plt.show()

# =============================================================================

# # Plot Analysis

#
#
#
#
# # # LOCAL RESPONSE
# # #epsyy_panel_1MEFISection, sigyy_panel_1MEFISection = pf.plotLocalResponse('MEFISection', 'MEFISection')
# #
# # =============================================================================
#
# # Comparacion de curvas: Respuesta Global
#
# fig, ax = plt.subplots()
# # plt.plot(NodeLateralDisp, -LatLoad, label=OutputDirName , linewidth=1)
# ax.plot(NodeLateralDispMEFISection02, -LatLoadMEFISection02, label='Concrete02' , linewidth=1, linestyle='--')
# ax.plot(NodeLateralDispMEFISection06, -LatLoadMEFISection06, label='Concrete06' , linewidth=1)
#
# plt.ylim(-1e5, 1e5)
# plt.xlim(-2, 2)
#
# plt.legend()
# plt.title('Ejemplo SW-T2-S3-4 Pushover Cíclico MEFISection')
# plt.xlabel('Desplazamiento (cm)')
# plt.ylabel('Reaccion Horizontal (kgf)')
# plt.grid(True)
#
# # Mostrar el gráfico
# plt.show()
#
#
# fig, ax = plt.subplots()
# # plt.plot(NodeLateralDisp, -LatLoad, label=OutputDirName , linewidth=1)
# ax.plot(NodeLateralDispMEFI02, -LatLoadMEFI02, label='MEFI - Concrete02' , linewidth=1, linestyle='--')
# ax.plot(NodeLateralDispMEFISection06, -LatLoadMEFISection06, label='MEFISection - Concrete06' , linewidth=1)
#
# plt.ylim(-1e5, 1e5)
# plt.xlim(-2, 2)
#
# plt.legend()
# plt.title('Ejemplo SW-T2-S3-4 Pushover Cíclico MEFI vs MEFISection')
# plt.xlabel('Desplazamiento (cm)')
# plt.ylabel('Reaccion Horizontal (kgf)')
# plt.grid(True)
#
# # Mostrar el gráfico
# plt.show()

# ==========================================================
# # Grafico TEST
# fileName = 'SW-T2-S3-4_MedicionesExperimentales.txt'
# Test = np.loadtxt(fileName, delimiter='     ')
# LatDisp_Test = Test[:, 1]/10
# LatLoad_Test = Test[:, 0]*102
#
# fig, ax = plt.subplots()
# ax.plot(LatDisp_Test,LatLoad_Test)
# plt.ylim(-1e5, 1e5)
# plt.xlim(-2, 2)
#
# plt.legend()
# plt.title('Test SW-T2-S3-4')
# plt.xlabel('Desplazamiento (cm)')
# plt.ylabel('Carga Lateral (kgf)')
# plt.grid(True)
#
# # Mostrar el gráfico
# plt.show()







