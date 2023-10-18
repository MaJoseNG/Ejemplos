# NODE Recorders:
# ----------------------------------------------------------------

recorder Node -file $dataDir/REACTIONS_1.out -time -node 1 -dof 1 2 3 reaction
recorder Node -file $dataDir/REACTIONS_2.out -time -node 2 -dof 1 2 3 reaction
recorder Node -file $dataDir/REACTIONS_3.out -time -node 3 -dof 1 2 3 reaction
recorder Node -file $dataDir/NODE_DISP.out -time -node 16 -dof 1 2 3 disp

# For local response
#recorder Node -file $dataDir/NODE_DISPx_4.out -time -node 4 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_5.out -time -node 5 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_6.out -time -node 6 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_7.out -time -node 7 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_8.out -time -node 8 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_9.out -time -node 9 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_10.out -time -node 10 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_11.out -time -node 11 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_12.out -time -node 12 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_13.out -time -node 13 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_14.out -time -node 14 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_15.out -time -node 15 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_16.out -time -node 16 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_17.out -time -node 17 -dof 1 disp
#recorder Node -file $dataDir/NODE_DISPx_18.out -time -node 18 -dof 1 disp

for {set i 4} {$i <= 18} {incr i} {
    recorder Node -file $dataDir/NODE_DISPx_$i.out -time -node $i -dof 1 disp
    recorder Node -file $dataDir/NODE_DISP_$i.out -time -node $i -dof 1 2 3 disp
}

# AREA ELEMENT Recorders:
# ----------------------------------------------------------------

#MEFISection
recorder Element -file $dataDir/MEFISection_panel_1_strain.out -time -ele 1 RCPanel 1 panel_strain
recorder Element -file $dataDir/MEFISection_panel_1_stress.out -time -ele 1 RCPanel 1 panel_stress
recorder Element -file $dataDir/MEFISection_panel_4_strain.out -time -ele 2 RCPanel 4 panel_strain
recorder Element -file $dataDir/MEFISection_panel_4_stress.out -time -ele 2 RCPanel 4 panel_stress

# For local response
#recorder Element -file $dataDir/MEFISection_panel_1_ele_1_strain.out -time -ele 1 RCPanel 1 panel_strain
#recorder Element -file $dataDir/MEFISection_panel_2_ele_1_strain.out -time -ele 1 RCPanel 2 panel_strain
#recorder Element -file $dataDir/MEFISection_panel_3_ele_1_strain.out -time -ele 1 RCPanel 3 panel_strain
#recorder Element -file $dataDir/MEFISection_panel_4_ele_1_strain.out -time -ele 1 RCPanel 4 panel_strain
#recorder Element -file $dataDir/MEFISection_panel_1_ele_2_strain.out -time -ele 2 RCPanel 1 panel_strain
#recorder Element -file $dataDir/MEFISection_panel_2_ele_2_strain.out -time -ele 2 RCPanel 2 panel_strain
#recorder Element -file $dataDir/MEFISection_panel_3_ele_2_strain.out -time -ele 2 RCPanel 3 panel_strain
#recorder Element -file $dataDir/MEFISection_panel_4_ele_2_strain.out -time -ele 2 RCPanel 4 panel_strain

for {set i 1} {$i <= 10} {incr i} {
    for {set j 1} {$j <= 4} {incr j} {
        recorder Element -file $dataDir/MEFISection_panel_strain$i$j.out -time -ele $i RCPanel $j panel_strain
    }
}

recorder Element -file $dataDir/MEFISection_panel_4_ele_5_strain.out -time -ele 5 RCPanel 4 panel_strain












