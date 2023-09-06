set CycleType Full;
set Fact [expr 750.0/100]

set iDmax {0.05 0.1 0.15 0.2 0.3 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0 2.4}
foreach Dmax $iDmax {
    source LibGeneratePeaks_copia.tcl
    source dataCOPIA/tmpDstepsCOPIA.tcl
    puts $iDstep
}
