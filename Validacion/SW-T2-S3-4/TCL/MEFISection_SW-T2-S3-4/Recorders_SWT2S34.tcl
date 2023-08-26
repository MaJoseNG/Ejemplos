# NODE Recorders:
# ----------------------------------------------------------------

recorder Node -file $dataDir/REACTIONS_1.out -time -node 1 -dof 1 2 3 reaction
recorder Node -file $dataDir/REACTIONS_2.out -time -node 2 -dof 1 2 3 reaction
recorder Node -file $dataDir/REACTIONS_3.out -time -node 3 -dof 1 2 3 reaction
recorder Node -file $dataDir/NODE_DISP.out -time -node 16 -dof 1 2 3 disp

# AREA ELEMENT Recorders:
# ----------------------------------------------------------------

#MEFISection
recorder Element -file $dataDir/MEFISection_panel_1_strain.out -time -ele 1 RCPanel 1 panel_strain
recorder Element -file $dataDir/MEFISection_panel_1_stress.out -time -ele 1 RCPanel 1 panel_stress
recorder Element -file $dataDir/MEFISection_panel_4_strain.out -time -ele 2 RCPanel 4 panel_strain
recorder Element -file $dataDir/MEFISection_panel_4_stress.out -time -ele 2 RCPanel 4 panel_stress

recorder Element -file $dataDir/MEFISection_panel_4_ele_1_strain.out -time -ele 1 RCPanel 4 panel_strain
recorder Element -file $dataDir/MEFISection_panel_4_ele_5_strain.out -time -ele 5 RCPanel 4 panel_strain