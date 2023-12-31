# NODE Recorders:
# ----------------------------------------------------------------

recorder Node -file $dataDir/REACTIONS_1.out -time -node 1 -dof 1 2 3 reaction
recorder Node -file $dataDir/REACTIONS_2.out -time -node 2 -dof 1 2 3 reaction
recorder Node -file $dataDir/NODE_DISP.out -time -node 17 -dof 1 2 3 disp

# AREA ELEMENT Recorders:
# ----------------------------------------------------------------
# Creado por MJN
# MEFI
# Single RC panel (macro-fiber) responses
recorder Element -file $dataDir/MEFI_panel_1_strain.out -time -ele 1 RCPanel 1 panel_strain
recorder Element -file $dataDir/MEFI_panel_1_stress.out -time -ele 1 RCPanel 1 panel_stress
recorder Element -file $dataDir/MEFI_panel_8_strain.out -time -ele 1 RCPanel 8 panel_strain
recorder Element -file $dataDir/MEFI_panel_8_stress.out -time -ele 1 RCPanel 8 panel_stress
# Unaxial Steel Recorders for 1st and 8th panel
recorder Element -file $dataDir/MEFI_strain_stress_steel1_1.out -time -ele 1 RCPanel 1 strain_stress_steelX
recorder Element -file $dataDir/MEFI_strain_stress_steel2_1.out -time -ele 1 RCPanel 1 strain_stress_steelY
recorder Element -file $dataDir/MEFI_strain_stress_steel1_8.out -time -ele 1 RCPanel 8 strain_stress_steelX
recorder Element -file $dataDir/MEFI_strain_stress_steel2_8.out -time -ele 1 RCPanel 8 strain_stress_steelY
# Unaxial Concrete Recorders for 1st and 8th panel
recorder Element -file $dataDir/MEFI_strain_stress_concrete1_1.out -time -ele 1 RCPanel 1 strain_stress_concrete1
recorder Element -file $dataDir/MEFI_strain_stress_concrete2_1.out -time -ele 1 RCPanel 1 strain_stress_concrete2
recorder Element -file $dataDir/MEFI_strain_stress_concrete1_8.out -time -ele 1 RCPanel 8 strain_stress_concrete1
recorder Element -file $dataDir/MEFI_strain_stress_concrete2_8.out -time -ele 1 RCPanel 8 strain_stress_concrete2

#MEFISection
#recorder Element -file $dataDir/MEFISection_panel_1_strain.out -time -ele 1 RCPanel 1 panel_strain
#recorder Element -file $dataDir/MEFISection_panel_1_stress.out -time -ele 1 RCPanel 1 panel_stress
#recorder Element -file $dataDir/MEFISection_panel_8_strain.out -time -ele 1 RCPanel 8 panel_strain
#recorder Element -file $dataDir/MEFISection_panel_8_stress.out -time -ele 1 RCPanel 8 panel_stress