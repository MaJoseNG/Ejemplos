import matplotlib.pyplot as plt
import numpy as np

def plotGlobalResponse(OutputDirName, AnalysisName):
    
    baseName = 'outputs/' + OutputDirName + '/' + AnalysisName
    
    dispFileName = baseName + '_NODE_DISP.out'
    reaction1FileName = baseName + '_REACTIONS_1.out'
    reaction2FileName = baseName + '_REACTIONS_2.out'
    
    NodeDisp = np.loadtxt(dispFileName, delimiter= ' ')
    Node1Reac = np.loadtxt(reaction1FileName, delimiter= ' ')
    Node2Reac = np.loadtxt(reaction2FileName, delimiter= ' ')
    
    
    LatLoad = Node1Reac[:,1] + Node2Reac[:,1]
    NodeLateralDisp = NodeDisp[:,1]
    
    fig, ax = plt.subplots()
    plt.plot(NodeLateralDisp, -LatLoad/1000, label=OutputDirName , linewidth=1)
    
    plt.ylim(-500, 500)
    
    plt.legend()
    plt.title('Global Response Cyclic Pushover')
    plt.xlabel('Lateral Displacement (mm)')
    plt.ylabel('Lateral Load (kN)')
    plt.grid(True)
    
    # Mostrar el gráfico
    plt.show()
    
    #return NodeDisp, Node1Reac, Node2Reac
    return LatLoad, NodeLateralDisp

def plotLocalResponse(OutputDirName, AnalysisName):
    
    baseName = 'outputs/' + OutputDirName + '/' + AnalysisName
    
    panel_1_strain_FileName = baseName + '_panel_1_strain.out'
    panel_1_stress_FileName = baseName + '_panel_1_stress.out'
    panel_8_strain_FileName = baseName + '_panel_8_strain.out'
    panel_8_stress_FileName = baseName + '_panel_8_stress.out'
    
    eps_panel_1 = np.loadtxt(panel_1_strain_FileName, delimiter= ' ')    
    eps_panel_8 = np.loadtxt(panel_8_strain_FileName, delimiter= ' ')     
    sig_panel_1 = np.loadtxt(panel_1_stress_FileName, delimiter= ' ')     
    sig_panel_8 = np.loadtxt(panel_8_stress_FileName, delimiter= ' ')  
    
    # Se extraen las deformaciones en y
    epsyy_panel_1 = eps_panel_1[:,2]    
    epsyy_panel_8 = eps_panel_8[:,2]       
    # Se extraen las tensiones en y
    sigyy_panel_1 = sig_panel_1[:,2]      
    sigyy_panel_8 = sig_panel_8[:,2]  
    
    # Grafico tension-deformacion panel 1
    fig, ax = plt.subplots()
    plt.plot(epsyy_panel_1,sigyy_panel_1, label=OutputDirName , linewidth=1)
    
    plt.legend()
    plt.title('1st panel resultant stress versus strain X-Y plane')
    plt.xlabel('Strain, $\epsilon_y$')
    plt.ylabel('Stress, $\sigma_y$ (MPa)')
    plt.grid(True)
    
    # Mostrar el gráfico
    plt.show()
    
    # Grafico tension-deformacion panel 8
    fig, ax = plt.subplots()
    plt.plot(epsyy_panel_8,sigyy_panel_8, label=OutputDirName , linewidth=1)
    
    plt.legend()
    plt.title('8th panel resultant stress versus strain X-Y plane')
    plt.xlabel('Strain, $\epsilon_y$')
    plt.ylabel('Stress, $\sigma_y$ (MPa)')
    plt.grid(True)
    
    # Mostrar el gráfico
    plt.show()
    
    # Se extraen las deformaciones en x
    epsxx_panel_1 = eps_panel_1[:,1]    
    epsxx_panel_8 = eps_panel_8[:,1]       
    # Se extraen las tensiones en y
    sigxx_panel_1 = sig_panel_1[:,1]      
    sigxx_panel_8 = sig_panel_8[:,1]  
    
    # Grafico tension-deformacion panel 1
    fig, ax = plt.subplots()
    plt.plot(epsxx_panel_1,sigxx_panel_1, label=OutputDirName , linewidth=1)
    
    plt.legend()
    plt.title('1st panel resultant stress versus strain X-Y plane')
    plt.xlabel('Strain, $\epsilon_x$')
    plt.ylabel('Stress, $\sigma_x$ (MPa)')
    plt.grid(True)
    
    # Mostrar el gráfico
    plt.show()
    
    # Grafico tension-deformacion panel 8
    fig, ax = plt.subplots()
    plt.plot(epsxx_panel_8,sigxx_panel_8, label=OutputDirName , linewidth=1)
    
    plt.legend()
    plt.title('8th panel resultant stress versus strain X-Y plane')
    plt.xlabel('Strain, $\epsilon_x$')
    plt.ylabel('Stress, $\sigma_x$ (MPa)')
    plt.grid(True)
    
    # Mostrar el gráfico
    plt.show()
    
    # Se extraen las deformaciones en xy
    epsxy_panel_1 = eps_panel_1[:,3]    
    epsxy_panel_8 = eps_panel_8[:,3]       
    # Se extraen las tensiones en y
    sigxy_panel_1 = sig_panel_1[:,3]      
    sigxy_panel_8 = sig_panel_8[:,3]  
    
    # Grafico tension-deformacion panel 1
    fig, ax = plt.subplots()
    plt.plot(epsxy_panel_1,sigxy_panel_1, label=OutputDirName , linewidth=1)
    
    plt.legend()
    plt.title('1st panel resultant stress versus strain X-Y plane')
    plt.xlabel('Strain, $\epsilon_{xy}$')
    plt.ylabel('Stress, $\sigma_{xy}$ (MPa)')
    plt.grid(True)
    
    # Mostrar el gráfico
    plt.show()
    
    # Grafico tension-deformacion panel 8
    fig, ax = plt.subplots()
    plt.plot(epsxy_panel_8,sigxy_panel_8, label=OutputDirName , linewidth=1)
    
    plt.legend()
    plt.title('8th panel resultant stress versus strain X-Y plane')
    plt.xlabel('Strain, $\epsilon_{xy}$')
    plt.ylabel('Stress, $\sigma_{xy}$ (MPa)')
    plt.grid(True)
    
    # Mostrar el gráfico
    plt.show()
    
    return epsyy_panel_1, epsyy_panel_8, sigyy_panel_1, sigyy_panel_8
    
    
    
    
    
    
    
    
    