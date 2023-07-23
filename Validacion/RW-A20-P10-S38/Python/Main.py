import opensees as ops
import numpy as np
import time
import matplotlib.pyplot as plt

import functions.ModelFunctions as mf
import functions.RecordersFunctions as rf
import functions.AnalysisFunctions as af
import functions.PlotFunctions as pf


# # =================== RUN MEFI =========================================
# # Remove existing model
# ops.wipe()
#
# # Turn on timer
# startTime = time.time()
#
# # Build Model
# mf.Nodes()
# mf.materialsFSAM()
# mf.areaElements_MEFI()
#
# rf.getRecorders('MEFI', 'MEFI')
#
# print('########## Model generated successfully ##########')
#
# # Run gravity analysis
# af.gravityLoadAnalysis()
#
# print('########## Gravity load applied successfully ##########')
#
# # Run displacement controlled analysis
# af.displacementControlledAnalysis()
#
# finishTime = time.time()
# timeSeconds = finishTime - startTime
#
# print('TOTAL TIME TAKEN: {} segundos'.format(timeSeconds))
#
# # =============================================================================

# =================== RUN MEFISECTION =========================================
# Remove existing model
ops.wipe()

# Turn on timer
startTime = time.time()

# Build Model
mf.Nodes()
mf.materialsRCLayerMembraneSection()
mf.areaElements_MEFISection()

rf.getRecorders('MEFISection', 'MEFISection')

print('Model generated successfully')

# Run gravity analysis
af.gravityLoadAnalysis()

print('Gravity load applied successfully')

# Run displacement controlled analysis
af.displacementControlledAnalysis()

finishTime = time.time()
timeSeconds = finishTime - startTime
print('TOTAL TIME TAKEN: {} segundos'.format(timeSeconds))

# =============================================================================

# Plot Analysis
# GLOBAL RESPONSE

# LatLoadMEFI, NodeLateralDispMEFI = pf.plotGlobalResponse('MEFI', 'MEFI')
LatLoadMEFISection, NodeLateralDispMEFISection = pf.plotGlobalResponse('MEFISection', 'MEFISection')

# LOCAL RESPONSE
# epsyy_panel_1MEFI, epsyy_panel_8MEFI, sigyy_panel_1MEFI, sigyy_panel_8MEFI = pf.plotLocalResponse('MEFI', 'MEFI')
# epsyy_panel_1MEFISection, epsyy_panel_8MEFISection, sigyy_panel_1MEFISection, sigyy_panel_8MEFISection = pf.plotLocalResponse('MEFISection', 'MEFISection')
#
# # =============================================================================
#
# # Comparacion de curvas: Respuesta Global
# fig, ax = plt.subplots()
# plt.plot(NodeLateralDispMEFI, -LatLoadMEFI/1000, label='MEFI' , linewidth=1, linestyle='--')
# plt.plot(NodeLateralDispMEFISection, -LatLoadMEFISection/1000, label='MEFISection' , linewidth=1)
#
# plt.ylim(-500, 500)
#
# plt.legend()
# plt.title('Global Response Cyclic Pushover')
# plt.xlabel('Lateral Displacement (mm)')
# plt.ylabel('Lateral Load (kN)')
# plt.grid(True)
#
# # Mostrar el gráfico
# plt.show()
#
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
#
#


















