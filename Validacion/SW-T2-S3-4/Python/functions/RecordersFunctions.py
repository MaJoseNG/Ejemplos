import opensees as ops


def getRecorders(OutputDirName, AnalysisName):
    
    baseName = 'outputs/' + OutputDirName + '/' + AnalysisName
    
    # NODE Recorders ---------------------------------------------------------------------------------------------------------------
    ops.recorder('Node', '-file', baseName + '_REACTIONS_1.out', '-time', '-node', 1, '-dof', 1, 2, 3, 'reaction')
    ops.recorder('Node', '-file', baseName + '_REACTIONS_2.out', '-time', '-node', 2, '-dof', 1, 2, 3, 'reaction')
    ops.recorder('Node', '-file', baseName + '_REACTIONS_3.out', '-time', '-node', 3, '-dof', 1, 2, 3, 'reaction')
    ops.recorder('Node', '-file', baseName + '_NODE_DISP.out', '-time', '-node', 19, '-dof', 1, 2, 3, 'disp')
    # ELEMENT Recorders ------------------------------------------------------------------------------------------------------------
    ops.recorder('Element', '-file', baseName + '_panel_1_strain.out', '-time', '-ele', 1, 'RCPanel', 1, 'panel_strain')
    ops.recorder('Element', '-file', baseName + '_panel_1_stress.out', '-time', '-ele', 1, 'RCPanel', 1, 'panel_stress')
    #ops.recorder('Element', '-file', baseName + '_panel_8_strain.out', '-time', '-ele', 1, 'RCPanel', 8, 'panel_strain')
    #ops.recorder('Element', '-file', baseName + '_panel_8_stress.out', '-time', '-ele', 1, 'RCPanel', 8, 'panel_stress')
    
    
    
    
    