# NODE Recorders:
# ----------------------------------------------------------------

recorder Node -file $dataDir/REACTIONS_1.out -time -node 1 -dof 1 2 3 reaction
recorder Node -file $dataDir/REACTIONS_2.out -time -node 2 -dof 1 2 3 reaction
recorder Node -file $dataDir/REACTIONS_3.out -time -node 3 -dof 1 2 3 reaction
recorder Node -file $dataDir/NODE_DISP.out -time -node 19 -dof 1 2 3 disp

# AREA ELEMENT Recorders:
# ----------------------------------------------------------------

#MEFISection
recorder Element -file $dataDir/MEFISection_panel_1_strain.out -time -ele 1 RCPanel 1 panel_strain
recorder Element -file $dataDir/MEFISection_panel_1_stress.out -time -ele 1 RCPanel 1 panel_stress
#recorder Element -file $dataDir/MEFISection_panel_8_strain.out -time -ele 1 RCPanel 8 panel_strain
#recorder Element -file $dataDir/MEFISection_panel_8_stress.out -time -ele 1 RCPanel 8 panel_stress