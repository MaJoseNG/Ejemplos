

set CycleType Full;
set Fact [expr 750.0/100]



#foreach Dmax {0.375 0.75 1.125 1.5 2.25 3 4.5 6 7.5 9 10.5 12 13.5 15 18} {
foreach Dmax {0.05 0.1 0.15 0.2 0.3 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0 2.4} {
    
    file mkdir dataCOPIA
    set outFileID [open dataCOPIA/tmpDstepsCOPIA.tcl w]
    
    set Dmax [expr $Dmax*$Fact]

    puts "\n--------------------- Dmax = $Dmax ------------------------------"
    set Dincr 0.15
    set Disp 0.
    
    puts $outFileID "set iDstep {"; puts $outFileID $Disp;
    
    #Dmax
    
    
    
    set resto [expr fmod($Dmax, $Dincr)]
    puts "El resto de la division $Dmax entre $Dincr es: $resto"
    #set resto [format "%.*f" 4 $resto]
    #puts "El resto de la division es: $resto"
    set n 0

    while {$resto > 1e-4} {
        #set Dincr [expr $Dincr/2]
        set Dincr $resto
        set resto [expr fmod($Dmax, $Dincr)]
        #puts "El resto de la division $Dmax entre $Dincr es: $resto"
        set n [expr $n+1]
    };   

    puts "n = $n"
    puts "Incremento de desplazamiento : Dincr = $Dincr"
    puts "El resto de la division $Dmax entre $Dincr es: $resto"
    
    set NstepsPeak [expr int(abs($Dmax/$Dincr))]
    puts "Nro de pasos: $NstepsPeak \n"
    
    if {$Dmax < 0} {
        set dx [expr -$Dincr]
    } else {
        set dx $Dincr
    }
    
    set nSteps 0
    
    for {set i 1} {$i <= $NstepsPeak} {incr i 1} {
        set Disp [expr $Disp + $dx]
        puts $outFileID $Disp
        set nSteps [expr $nSteps + 1]
        puts "Para el paso $nSteps: Disp = $Disp"
    }
    if {$CycleType != "Push"} {
        for {set i 1} {$i <= $NstepsPeak} {incr i 1} {
            set Disp [expr $Disp - $dx]
            puts $outFileID $Disp
            set nSteps [expr $nSteps + 1]
            puts "Para el paso $nSteps: Disp = $Disp"
        }
        if {$CycleType != "Half"} {
            #sdfdf
            for {set i 1} {$i <= $NstepsPeak} {incr i 1} {
                set Disp [expr $Disp - $dx]
                puts $outFileID $Disp
                set nSteps [expr $nSteps + 1]
                puts "Para el paso $nSteps: Disp = $Disp"
            }
            for {set i 1} {$i <= $NstepsPeak} {incr i 1} {
                set Disp [expr $Disp + $dx]
                puts $outFileID $Disp
                set nSteps [expr $nSteps + 1]
                puts "Para el paso $nSteps: Disp = $Disp"
            }    
        }
    }
    puts $outFileID " } "
    close $outFileID
###}