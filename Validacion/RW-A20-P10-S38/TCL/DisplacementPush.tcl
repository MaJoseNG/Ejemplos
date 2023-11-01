# ----------------------------------------------------
# Displacement Controlled Analysis
# ----------------------------------------------------

# Set the loads to be constant & reset the time in the domain
loadConst -time 0.0

source LATERAL_Load_Pattern.tcl

# ------------------------------
set Tol 1.e-4;                          # Convergence Test: tolerance
#set Tol 1.e-3;                          # Convergence Test: tolerance
set maxNumIter 1000;                    # Convergence Test: maximum number of iterations that will be performed before "failure to converge" is returned
#set maxNumIter 500;                    # Convergence Test: maximum number of iterations that will be performed before "failure to converge" is returned
set printFlag 0;                        # Convergence Test: flag used to print information on convergence (optional)        # 1: print information on each step; 
set TestType NormDispIncr;              # Convergence-test type
set algorithmType KrylovNewton;         # Algorithm type
#set algorithmType Newton;               # Algorithm type

constraints Transformation; 
numberer RCM
system BandGeneral
test $TestType $Tol $maxNumIter $printFlag
algorithm $algorithmType;       
analysis Static

logFile "$dataDir.log"
#################################################
## Define procedure for convergence control (recursive bisection)
#proc analyzeStep {DispInc {epsilon 1e-4}} {
#    # Perform analysis step
#    integrator DisplacementControl  $IDctrlNode $IDctrlDOF [expr $DispInc]
#    set ok [analyze 1]
#    # Handle non-convergence
#    if {$ok != 0} {
#        # Base case
#        if {$DispInc < 2*$epsilon} {
#            return $ok
#        }
#        # Bisect analysis step and recurse
#        set DispInc [expr {$DispInc/2.0}]
#        integrator DisplacementControl  $IDctrlNode $IDctrlDOF [expr $DispInc]
#        set ok [analyzeStep $DispInc $epsilon]
#        if {$ok == 0} {
#            set ok [analyzeStep $DispInc $epsilon]
#        }
#    }
#    return $ok
#}
#################################################


set fmt1 "%s Cyclic analysis: CtrlNode %.3i, dof %.1i, Disp=%.4f %s";   # format for screen/file output of DONE/PROBLEM analysis

foreach Dmax $iDmax cycles $Ncycles {

    set iDstep [GeneratePeaks $Dmax $Dincr $CycleType $Fact];   # this proc is defined above

    for {set i 1} {$i <= $cycles} {incr i 1} {
        
        set zeroD 0
        set D0 0.0 
        foreach Dstep $iDstep {
            set D1 $Dstep
            set Dincr [expr $D1 - $D0]
            integrator DisplacementControl  $IDctrlNode $IDctrlDOF $Dincr
            analysis Static
            # ----------------------------------------------first analyze command------------------------
            set ok [analyze 1]
            # ----------------------------------------------if convergence failure-------------------------
            if {$ok != 0} {
                # if analysis fails, we try some other stuff
                # performance is slower inside this loop    global maxNumIterStatic;# max no. of iterations performed before "failure to converge" is ret'd
                ####### FORMA N°1 #######################
                #if {$ok != 0} {
                #    puts "Trying 2 times smaller timestep .. "
                #    integrator DisplacementControl  $IDctrlNode $IDctrlDOF [expr $Dincr/2]
                #    set ok [analyze 1]
                #}
                #if {$ok != 0} {
                #    puts "Trying 4 times smaller timestep .. "
                #    integrator DisplacementControl  $IDctrlNode $IDctrlDOF [expr $Dincr/4]
                #    set ok [analyze 1]
                #}
                #if {$ok != 0} {
                #    puts "Trying 20 times smaller timestep .. "
                #    integrator DisplacementControl  $IDctrlNode $IDctrlDOF [expr $Dincr/20]
                #    set ok [analyze 1]
                #}
                #if {$ok != 0} {
                #    puts "Trying 160 times smaller timestep .. "
                #    integrator DisplacementControl  $IDctrlNode $IDctrlDOF [expr $Dincr/160]
                #    set ok [analyze 1]
                #}
                #if {$ok != 0} {
                #    puts "Trying 1000 times smaller timestep .. "
                #    integrator DisplacementControl  $IDctrlNode $IDctrlDOF [expr $Dincr/1000]
                #    set ok [analyze 1]
                #}
                #if {$ok != 0} {
                #    puts "Trying 10 times greater tolerance .. "
                #    test $TestType [expr $Tol*10] $maxNumIter 0
                #    set ok [analyze 1]
                #}
                #if {$ok != 0} {
                #    puts "Trying 100 times greater tolerance .. "
                #    test $TestType [expr $Tol*100] $maxNumIter 0
                #    set ok [analyze 1]
                #}
                ###### FORMA N°2 #######################
                #if {$ok != 0} {
                #    puts "Trying Newton with Current Tangent .."
                #    test NormDispIncr $Tol 1000 0
                #    algorithm Newton
                #    set ok [analyze 1]
                #    test $TestType $Tol $maxNumIter 0
                #    algorithm $algorithmType
                #}
                #if {$ok != 0} {
                #    puts "Trying Newton with Initial Tangent .."
                #    test NormDispIncr 0.01 2000 0
                #    algorithm Newton -initial
                #    set reSolution [expr $reSolution + 1]
                #    set ok [analyze 1]
                #    test $TestType $Tol $maxNumIter 0
                #    algorithm $algorithmType 
                #}
                #if {$ok != 0} {
                #    puts "Trying Modified Newton .."
                #    test NormDispIncr 0.01 2000 0
                #    algorithm ModifiedNewton
                #    set ok [analyze 1]
                #    test $TestType $Tol $maxNumIter 0
                #    algorithm $algorithmType 
                #}
                #if {$ok != 0} {
                #    puts "Trying Broyden .."
                #    algorithm Broyden 500
                #    set ok [analyze 1 ]
                #    algorithm $algorithmType
                #}
                ######### FORMA N°3 #####################################
                #if {$ok != 0} {
                #    set Dincr_1 [expr $Dincr/20]
                #    set D0_1 $D0
                #    set D1_1 $D1
                #    while {$D0_1 < $D1_1} {
                #        integrator DisplacementControl  $IDctrlNode $IDctrlDOF $Dincr_1
                #        set ok [analyze 1]
                #        if {$ok == 0} {
                #            set D0_1 [expr $D0_1 + $Dincr_1]
                #            puts "D0_1 = $D0_1"
                #        } else {
                #            break
                #        }
                #    }
                #}
                #if {$ok != 0} {
                #    puts "Trying Newton with Current Tangent .."
                #    test NormDispIncr $Tol 1000 0
                #    algorithm Newton
                #    set ok [analyze 1]
                #    test $TestType $Tol $maxNumIter 0
                #    algorithm $algorithmType
                #}
                #if {$ok != 0} {
                #    puts "Trying Newton with Initial Tangent .."
                #    test NormDispIncr 0.01 2000 0
                #    algorithm Newton -initial
                #    set reSolution [expr $reSolution + 1]
                #    set ok [analyze 1]
                #    test $TestType $Tol $maxNumIter 0
                #    algorithm $algorithmType 
                #}
                #if {$ok != 0} {
                #    puts "Trying Modified Newton .."
                #    test NormDispIncr 0.01 2000 0
                #    algorithm ModifiedNewton
                #    set ok [analyze 1]
                #    test $TestType $Tol $maxNumIter 0
                #    algorithm $algorithmType 
                #}
                #if {$ok != 0} {
                #    puts "Trying Broyden .."
                #    algorithm Broyden 500
                #    set ok [analyze 1 ]
                #    algorithm $algorithmType
                #}
                ######### FIN FORMA N°3 ################################
                ######### FORMA N°4 ####################################
                if {$ok != 0} {
                    puts "Trying Krylonv with 10 times greater tolerance ..  "
                    test $TestType [expr $Tol*10] $maxNumIter 0
                    set ok [analyze 1]
                }
                if {$ok != 0} {
                    puts "Trying Krylov with 100 times greater tolerance .."
                    test $TestType [expr $Tol*100] $maxNumIter 0
                    set ok [analyze 1]
                }
                
                if {$ok != 0} {
                    puts "Trying Newton with Current Tangent .."
                    test NormDispIncr $Tol 1000 0
                    algorithm Newton
                    set ok [analyze 1]
                    test $TestType $Tol $maxNumIter 0
                    algorithm $algorithmType
                }
                if {$ok != 0} {
                    puts "Trying Newton with Initial Tangent .."
                    test NormDispIncr 1.e-3 1000 0
                    algorithm Newton -initial
                    set reSolution [expr $reSolution + 1]
                    set ok [analyze 1]
                    test $TestType $Tol $maxNumIter 0
                    algorithm $algorithmType 
                }
                #if {$ok != 0} {
                #    puts "Trying Krylov .."
                #    test NormDispIncr 1.e-4 1000 0
                #    algorithm KrylovNewton
                #    set ok [analyze 1]
                #    test $TestType $Tol $maxNumIter 0
                #    algorithm $algorithmType 
                #}
                #if {$ok != 0} {
                #    puts "Trying Krylov with 10 times greater tolerance.."
                #    test NormDispIncr 1.e-3 1000 0
                #    algorithm KrylovNewton
                #    set ok [analyze 1]
                #    test $TestType $Tol $maxNumIter 0
                #    algorithm $algorithmType 
                #}
                #if {$ok != 0} {
                #    puts "Trying Krylov with 100 times greater tolerance.."
                #    test NormDispIncr 1.e-2 1000 0
                #    algorithm KrylovNewton
                #    set ok [analyze 1]
                #    test $TestType $Tol $maxNumIter 0
                #    algorithm $algorithmType 
                #}
                #if {$ok != 0} {
                #    puts "Trying Broyden .."
                #    algorithm Broyden 500
                #    set ok [analyze 1 ]
                #    algorithm $algorithmType
                #}
                ######### FIN FORMA N°4 ################################
                if {$ok != 0} {
                    set putout [format $fmt1 "PROBLEM" $IDctrlNode $IDctrlDOF [nodeDisp $IDctrlNode $IDctrlDOF] $LunitTXT]
                    puts $putout
                    return -1
                }; # end if
            }; # end if
            # -----------------------------------------------------------------------------------------------------
            set D0 $D1;         # move to next step

            # print load step on the screen
            puts "Load Step: [expr $load_step]"
            set load_step [expr $load_step+1]

        }; # end Dstep

    };  # end i
        
};  # end of iDmaxCycl


# -----------------------------------------------------------------------------------------------------
if {$ok != 0 } {
    puts [format $fmt1 "PROBLEM" $IDctrlNode $IDctrlDOF [nodeDisp $IDctrlNode $IDctrlDOF] $LunitTXT]
} else {
    puts [format $fmt1 "DONE"  $IDctrlNode $IDctrlDOF [nodeDisp $IDctrlNode $IDctrlDOF] $LunitTXT]
}