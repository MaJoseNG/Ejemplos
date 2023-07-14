import opensees as ops
import numpy as np
import time
import matplotlib.pyplot as plt

import functions.ModelFunctions as mf
import functions.RecordersFunctions as rf
import functions.AnalysisFunctions as af
import functions.PlotFunctions as pf


# # =================== Run MEFISection with Concrete02 =========================================
# # Remove existing model
# ops.wipe()
#
# # Turn on timer
# startTime = time.time()
#
# # Build Model
# mf.Nodes()
# mf.UniaxialMat_Steel02()
# mf.UniaxialMat_Concrete02()
# mf.materialsRCLayerMembraneSection()
# mf.areaElements_MEFISection()
#
# rf.getRecorders('MEFISection_Concrete02', 'MEFISection_Concrete02')
#
# print('########## Model generated successfully ##########')
#
# # Run gravity analysis
# af.gravityLoadAnalysis()
# print('########## Gravity load applied successfully ##########')
#
# # Run displacement controlled analysis
# af.displacementControlledAnalysis()
#
# finishTime = time.time()
# timeSeconds = finishTime - startTime
# #timeMinutes = timeSeconds/60
# #timeHours = timeSeconds/3600
# #timeMinutes = timeMinutes-timeHours*60
# #timeSeconds = timeSeconds-timeMinutes*60-timeHours*3600
#
# print('TOTAL TIME TAKEN: {} segundos'.format(timeSeconds))

# # =================== Run MEFISection with Concrete06 =========================================
# # Remove existing model
# ops.wipe()
#
# # Turn on timer
# startTime = time.time()
#
# # Build Model
# mf.Nodes()
# mf.UniaxialMat_Steel02()
# mf.UniaxialMat_Concrete06()
# mf.materialsRCLayerMembraneSection()
# mf.areaElements_MEFISection()
#
# rf.getRecorders('MEFISection_Concrete06', 'MEFISection_Concrete06')
#
# print('########## Model generated successfully ##########')
#
# # Run gravity analysis
# af.gravityLoadAnalysis()
# print('########## Gravity load applied successfully ##########')
#
# # Run displacement controlled analysis
# af.displacementControlledAnalysis()
#
# finishTime = time.time()
# timeSeconds = finishTime - startTime
#
# print('TOTAL TIME TAKEN: {} segundos'.format(timeSeconds))

# =================== Run MEFI with FSAM-Concrete02 =========================================
# Remove existing model
ops.wipe()

# Turn on timer
startTime = time.time()

# Build Model
mf.Nodes()
#mf.NodesFSAM()
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

# Plot Analysis
# GLOBAL RESPONSE
LatLoadMEFISection02, NodeLateralDispMEFISection02 = pf.plotGlobalResponse('MEFISection_Concrete02', 'MEFISection_Concrete02')
LatLoadMEFISection06, NodeLateralDispMEFISection06 = pf.plotGlobalResponse('MEFISection_Concrete06', 'MEFISection_Concrete06')
LatLoadMEFI02, NodeLateralDispMEFI02 = pf.plotGlobalResponse('MEFI_Concrete02', 'MEFI_Concrete02')

# LOCAL RESPONSE
#epsyy_panel_1MEFISection, sigyy_panel_1MEFISection = pf.plotLocalResponse('MEFISection', 'MEFISection')

# =============================================================================

# Comparacion de curvas: Respuesta Global

fig, ax = plt.subplots()
# plt.plot(NodeLateralDisp, -LatLoad, label=OutputDirName , linewidth=1)
ax.plot(NodeLateralDispMEFISection02, -LatLoadMEFISection02, label='Concrete02' , linewidth=1, linestyle='--')
ax.plot(NodeLateralDispMEFISection06, -LatLoadMEFISection06, label='Concrete06' , linewidth=1)

plt.ylim(-1e5, 1e5)
plt.xlim(-2, 2)

plt.legend()
plt.title('Ejemplo SW-T2-S3-4 Pushover Cíclico MEFISection')
plt.xlabel('Desplazamiento (cm)')
plt.ylabel('Reaccion Horizontal (kgf)')
plt.grid(True)

# Mostrar el gráfico
plt.show()


fig, ax = plt.subplots()
# plt.plot(NodeLateralDisp, -LatLoad, label=OutputDirName , linewidth=1)
ax.plot(NodeLateralDispMEFI02, -LatLoadMEFI02, label='MEFI - Concrete02' , linewidth=1, linestyle='--')
ax.plot(NodeLateralDispMEFISection06, -LatLoadMEFISection06, label='MEFISection - Concrete06' , linewidth=1)

plt.ylim(-1e5, 1e5)
plt.xlim(-2, 2)

plt.legend()
plt.title('Ejemplo SW-T2-S3-4 Pushover Cíclico MEFI vs MEFISection')
plt.xlabel('Desplazamiento (cm)')
plt.ylabel('Reaccion Horizontal (kgf)')
plt.grid(True)

# Mostrar el gráfico
plt.show()













