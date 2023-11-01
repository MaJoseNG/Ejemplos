# ----------------------------------------------------
# Displacement Controlled Analysis
# Created by: Carlos Lopez O. (carlos.lopez.o@ug.uchile.cl)
# Last Modification: 21/06/2022
# Adapted by: Maria Jose Nunez G.
#             07/2023
# ----------------------------------------------------

# Turn on timer
set startTime [clock clicks -milliseconds]

# Run gravity analysis and generate the model
source Model.tcl;
source Run_Gravity.tcl;
puts "Model generated and gravity load applied successfully"

loadConst -time 0.0
set load_step 1;
set reSolution 0;

# Set Control Node and DOF
set IDctrlNode 17;
set IDctrlDOF 1;

# vector of displacement-cycle peaks in terms of wall drift ratio (TOTAL displacements)
#set iDmax "0.1 0.3 0.5 0.7 1 1.5 2.2 3.1";  
set iDmax "0.28 0.38 0.56 0.75 1.1 1.5 2.3 3.1";
#set iDmax "3.1";
set Dincr 0.2;
#set Dincr 0.25;
#set Ncycles 1;                  # specify the number of cycles at each peak
set Ncycles "3 3 3 3 3 3 2 1";    # en caso de que se tengan diferente numero de ciclos por cada drift
#set Ncycles "1 1 1 1 1 1 1 1";    # en caso de que se tengan diferente numero de ciclos por cada drift
set CycleType Full;            # type of cyclic analysis: Full / Push / Half 
#set CycleType Push;            # type of cyclic analysis: Full / Push / Half 
set Fact [expr 2438.4*$mm/100]; # scale drift ratio by storey height for displacement cycles

source LibGeneratePeaks.tcl
source DisplacementPush.tcl

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