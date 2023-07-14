# ----------------------------------------------------
# Example: Simulation of shear controlled wall cyclic behavior using MEFISection
# Specimen: SW-T2-S3-4 (Terzioglu etal.2018)
# Created by: Maria Jose Nunez G., MSc.(c) (maria.nunez.g@ug.uchile.cl)
# Date: 6/2023
# ----------------------------------------------------

# Turn on timer
set startTime [clock clicks -milliseconds]

# Run gravity analysis and generate the model
source Model_SWT2S34.tcl;
source SW_S34_StaticVerticalAnalysis.tcl;
puts "Model generated and gravity load applied successfully"

loadConst -time 0.0
set load_step 1;
set reSolution 0;

# Set Control Node and DOF
set IDctrlNode 19;
set IDctrlDOF 1;

# vector of displacement-cycle peaks in terms of wall drift ratio (TOTAL displacements)
set iDmax "0.04 0.08 0.13 0.16 0.24 0.32 0.47 0.47 0.47 0.63 0.63 0.63 0.79 0.79 0.79 0.95 0.95 0.95 1.11 1.11 1.11 1.26 1.26 1.26 1.42 1.42 1.42 1.58 1.58 1.58 1.89 1.89 1.89"; 
set Dincr 0.01;
set Ncycles 1;                  # specify the number of cycles at each peak
set CycleType Full;            # type of cyclic analysis: Full / Push / Half 
#set CycleType Push;             # type of cyclic analysis: Full / Push / Half 
set Fact [expr 95.0/100]; # scale drift ratio by storey height for displacement cycles

source LibGeneratePeaks.tcl
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