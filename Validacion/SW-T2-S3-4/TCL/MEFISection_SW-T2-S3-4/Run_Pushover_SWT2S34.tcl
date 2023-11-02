# ----------------------------------------------------
# Example: Simulation of shear controlled wall cyclic behavior using MEFISection
# Specimen: SW-T2-S3-4 (Terzioglu etal.2018)
# Created by: Maria Jose Nunez G., MSc.(c) (maria.nunez.g@ug.uchile.cl)
# Date: 6/2023
# ----------------------------------------------------

# Turn on timer
set startTime [clock clicks -milliseconds]

# Run gravity analysis and generate the model
source Model_SWT2S34_RCLMS01_Conc02_Steel02.tcl;
#source Model_SWT2S34_RCLMS01_Conc06_Steel02.tcl;
#source Model_SWT2S34_RCLMS02_FSAM_Conc02_Steel02.tcl;
source SW_S34_StaticVerticalAnalysis.tcl;
puts "Model generated and gravity load applied successfully"

loadConst -time 0.0
set load_step 1;
set reSolution 0;

# Set Control Node and DOF
#set IDctrlNode 19;
set IDctrlNode 16;
set IDctrlDOF 1;

## vector of displacement-cycle peaks in terms of wall drift ratio (TOTAL displacements)
set iDmax "0.05 0.1 0.15 0.2 0.3 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0 2.4";
#set iDmax "2.4";
set Dincr 0.15;                 # Paso para Concrete02
#set Dincr 0.10;                 # Paso para FSAM
set Ncycles 3;                  # specify the number of cycles at each peak
#set Ncycles 1;                  # specify the number of cycles at each peak
set CycleType Full;             # type of cyclic analysis: Full / Push / Half 
#set CycleType Push;             # type of cyclic analysis: Full / Push / Half 
##set Fact [expr 950.0/100];      # scale drift ratio by storey height for displacement cycles
set Fact [expr 750.0/100];      # scale drift ratio by storey height for displacement cycles

#source LibGeneratePeaks.tcl
#==========================================================================================
# OPCION N°2
#set Dincr 0.2;
#set Ncycles 1;
#set iDmax "0.375 0.75 1.125 1.50 2.25 3.0 4.5 6.0 7.5 9.0 10.5 12.0 13.5 15.0 18.0";
#===============================================================================================
source SW_S34_StaticHorizontalAnalysis.tcl

# Print the state at control node
print node $IDctrlNode

set finishTime [clock clicks -milliseconds];
set timeSeconds [expr ($finishTime-$startTime)/1000];
set timeMinutes [expr ($timeSeconds/60)];
set timeHours [expr ($timeSeconds/3600)];
set timeMinutes [expr ($timeMinutes - $timeHours*60)];
set timeSeconds [expr ($timeSeconds - $timeMinutes*60 - $timeHours*3600)];
puts "
----------------------------------";
puts "
";
puts "TOTAL TIME TAKEN $timeHours:$timeMinutes:$timeSeconds";
puts "Initial stiffness used $reSolution times"
puts "
----------------------------------";