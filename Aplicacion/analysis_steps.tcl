
# Statistics monitor actor
set MonitorActorStatistics_once_flag 0
proc MonitorActorStatistics {} {
	global STKO_VAR_process_id
	global STKO_VAR_increment
	global STKO_VAR_time_increment
	global STKO_VAR_time
	global STKO_VAR_num_iter
	global STKO_VAR_error_norm
	global STKO_VAR_percentage
	global MonitorActorStatistics_once_flag
	# Statistics
	if {$STKO_VAR_process_id == 0} {
		if {$MonitorActorStatistics_once_flag == 0} {
			set MonitorActorStatistics_once_flag 1
			set STKO_monitor_statistics [open "./STKO_monitor_statistics.stats"  w+]
		} else {
			set STKO_monitor_statistics [open "./STKO_monitor_statistics.stats"  a+]
		}
		puts $STKO_monitor_statistics "$STKO_VAR_increment $STKO_VAR_time_increment $STKO_VAR_time $STKO_VAR_num_iter $STKO_VAR_error_norm $STKO_VAR_percentage"
		close $STKO_monitor_statistics
	}
}
lappend STKO_VAR_MonitorFunctions "MonitorActorStatistics"

# Timing monitor actor
set monitor_actor_time_0 [clock seconds]
proc MonitorActorTiming {} {
	global monitor_actor_time_0
	global STKO_VAR_process_id
	if {$STKO_VAR_process_id == 0} {
		set STKO_time [open "./STKO_time_monitor.tim" w+]
		set current_time [clock seconds]
		puts $STKO_time $monitor_actor_time_0
		puts $STKO_time $current_time
		close $STKO_time
	}
}
lappend STKO_VAR_MonitorFunctions "MonitorActorTiming"

# Constraints.sp fix
	fix 49 1 1 1
	fix 50 1 1 1
	fix 55 1 1 1

# Constraints.mp equalDOF
equalDOF 9 1   1
equalDOF 9 2   1
equalDOF 10 3   1
equalDOF 10 4   1
equalDOF 19 5   1
equalDOF 19 6   1
equalDOF 44 7   1
equalDOF 44 8   1
equalDOF 11 12   1
equalDOF 14 13   1
equalDOF 16 15   1
equalDOF 17 18   1
equalDOF 17 20   1
equalDOF 21 22   1
equalDOF 24 23   1
equalDOF 25 26   1
equalDOF 27 28   1
equalDOF 41 29   1
equalDOF 41 30   1
equalDOF 47 31   1
equalDOF 47 32   1
equalDOF 33 34   1
equalDOF 36 35   1
equalDOF 33 37   1
equalDOF 36 38   1
equalDOF 27 39   1
equalDOF 21 40   1
equalDOF 25 42   1
equalDOF 11 43   1
equalDOF 24 45   1
equalDOF 14 46   1
equalDOF 16 48   1
equalDOF 56 51   1
equalDOF 56 52   1
equalDOF 57 53   1
equalDOF 57 54   1

# Monitor Actor [2]
set nodes_X_2 {44}
set nodes_Y_2 {49 50 55}
set MonitorActor2_once_flag 0
proc MonitorActor2 {} {
	global MonitorActor2_once_flag
	global STKO_VAR_process_id
	global STKO_VAR_increment
	if {$MonitorActor2_once_flag == 0} {
		set MonitorActor2_once_flag 1
		set STKO_plot_00 [open "./Pushover.plt" w+]
		puts $STKO_plot_00 "Displacement (X) \[mm]	Reaction Force (X) \[N]"
	} else {
		set STKO_plot_00 [open "./Pushover.plt" a+]
	}
	reactions
	set monitor_value_X 0.0
	set monitor_value_X_set 0
	global nodes_X_2
	foreach node_id $nodes_X_2 {
		# get node value
		set node_value [nodeDisp $node_id 1]
		if {$monitor_value_X_set == 0} {
			set monitor_value_X $node_value
			set monitor_value_X_set 1
		} else {
			set monitor_value_X [expr max ($monitor_value_X , $node_value)]
		}
	}
	set monitor_value_X [expr 1.0 * $monitor_value_X + 0.0]
	set monitor_value_Y 0.0
	global nodes_Y_2
	foreach node_id $nodes_Y_2 {
		# get node value
		set node_value [nodeReaction $node_id 1]
		set monitor_value_Y [expr $monitor_value_Y + $node_value]
	}
	set monitor_value_Y [expr -1.0 * $monitor_value_Y + 0.0]
	puts $STKO_plot_00 "$monitor_value_X	$monitor_value_Y"
	close $STKO_plot_00
}
lappend STKO_VAR_MonitorFunctions "MonitorActor2"

# Patterns.addPattern loadPattern
pattern Plain 3 1 {

# Loads.Force NodeForce
	load 51 0.0 -39464.0 0.0
	load 56 0.0 -39464.0 0.0
	load 52 0.0 -78929.0 0.0
	load 53 0.0 -167269.0 0.0
	load 57 0.0 -167269.0 0.0
	load 54 0.0 -334539.0 0.0
	load 32 0.0 -239006.0 0.0
	load 47 0.0 -239006.0 0.0
	load 31 0.0 -478011.0 0.0
	load 2 0.0 -133995.0 0.0
	load 9 0.0 -133995.0 0.0
	load 1 0.0 -267989.0 0.0
	load 3 0.0 -118181.0 0.0
	load 10 0.0 -118181.0 0.0
	load 4 0.0 -236361.0 0.0
	load 27 0.0 -114623.0 0.0
	load 39 0.0 -114623.0 0.0
	load 28 0.0 -229246.0 0.0
	load 21 0.0 -116755.0 0.0
	load 40 0.0 -116755.0 0.0
	load 22 0.0 -233510.0 0.0
	load 24 0.0 -117028.0 0.0
	load 45 0.0 -117028.0 0.0
	load 23 0.0 -234055.0 0.0
	load 25 0.0 -109191.0 0.0
	load 42 0.0 -109191.0 0.0
	load 26 0.0 -218382.0 0.0
	load 11 0.0 -101048.0 0.0
	load 43 0.0 -101048.0 0.0
	load 12 0.0 -202096.0 0.0
	load 14 0.0 -98560.0 0.0
	load 46 0.0 -98560.0 0.0
	load 13 0.0 -197120.0 0.0
	load 16 0.0 -96682.0 0.0
	load 48 0.0 -96682.0 0.0
	load 15 0.0 -193364.0 0.0
	load 33 0.0 -95550.0 0.0
	load 37 0.0 -95550.0 0.0
	load 34 0.0 -191100.0 0.0
	load 36 0.0 -95534.0 0.0
	load 38 0.0 -95534.0 0.0
	load 35 0.0 -191067.0 0.0
	load 30 0.0 -95146.0 0.0
	load 41 0.0 -95146.0 0.0
	load 29 0.0 -190291.0 0.0
	load 17 0.0 -94550.0 0.0
	load 20 0.0 -94550.0 0.0
	load 18 0.0 -189100.0 0.0
	load 6 0.0 -98543.0 0.0
	load 19 0.0 -98543.0 0.0
	load 5 0.0 -197087.0 0.0
	load 7 0.0 -73764.0 0.0
	load 44 0.0 -73764.0 0.0
	load 8 0.0 -147529.0 0.0
}

# analyses command
domainChange
constraints Transformation
numberer RCM
system BandGeneral
test NormDispIncr 0.0001 100  
algorithm Newton
integrator LoadControl 0.0
analysis Static
# ======================================================================================
# NON-ADAPTIVE LOAD CONTROL ANALYSIS
# ======================================================================================

# ======================================================================================
# USER INPUT DATA 
# ======================================================================================

# duration and initial time step
set total_duration 1.0
set initial_num_incr 20

set STKO_VAR_time 0.0
set STKO_VAR_time_increment [expr $total_duration / $initial_num_incr]
set STKO_VAR_initial_time_increment $STKO_VAR_time_increment
integrator LoadControl $STKO_VAR_time_increment 
for {set STKO_VAR_increment 1} {$STKO_VAR_increment <= $initial_num_incr} {incr STKO_VAR_increment} {
	
	# before analyze
	STKO_CALL_OnBeforeAnalyze
	
	# perform this step
	set STKO_VAR_analyze_done [analyze 1 ]
	
	# update common variables
	if {$STKO_VAR_analyze_done == 0} {
		set STKO_VAR_num_iter [testIter]
		set STKO_VAR_time [expr $STKO_VAR_time + $STKO_VAR_time_increment]
		set STKO_VAR_percentage [expr $STKO_VAR_time/$total_duration]
		set norms [testNorms]
		if {$STKO_VAR_num_iter > 0} {set STKO_VAR_error_norm [lindex $norms [expr $STKO_VAR_num_iter-1]]} else {set STKO_VAR_error_norm 0.0}
	}
	
	# after analyze
	set STKO_VAR_afterAnalyze_done 0
	STKO_CALL_OnAfterAnalyze
	
	# check convergence
	if {$STKO_VAR_analyze_done == 0} {
		# print statistics
		if {$STKO_VAR_process_id == 0} {
			puts [format "Increment: %6d | Iterations: %4d | Norm: %8.3e | Progress: %7.3f %%" $STKO_VAR_increment $STKO_VAR_num_iter  $STKO_VAR_error_norm [expr $STKO_VAR_percentage*100.0]]
		}
	} else {
		# stop analysis
		error "ERROR: the analysis did not converge"
	}
	
}

# done
if {$STKO_VAR_process_id == 0} {
	puts "Target time has been reached. Current time = $STKO_VAR_time"
	puts "SUCCESS."
}

loadConst -time 0.0


# Patterns.addPattern loadPattern
pattern Plain 5 1 {

# Loads.Force NodeForce
	load 9 0.29596066622054984 0 0.0
	load 10 0.28230501856540147 0 0.0
	load 11 0.10373079893281435 0 0.0
	load 14 0.08754196795506365 0 0.0
	load 16 0.09247548687484043 0 0.0
	load 17 0.4575553460688869 0 0.0
	load 19 0.6701022200833501 0 0.0
	load 21 0.21559568607303814 0 0.0
	load 24 0.17394009797221555 0 0.0
	load 25 0.13461784402157073 0 0.0
	load 27 0.25364386414973306 0 0.0
	load 33 0.12511662201607388 0 0.0
	load 36 0.19221177024009817 0 0.0
	load 41 0.3006684589456542 0 0.0
	load 44 0.945699999999999 0 0.0
	load 47 0.28915345455309044 0 0.0
	load 56 0.17490413447697833 0 0.0
	load 57 0.2537587545353575 0 0.0
}

# analyses command
domainChange
constraints Transformation
numberer RCM
system BandGeneral
test NormDispIncr 0.0001 2000  
algorithm Newton
integrator DisplacementControl 44 1 0.1
analysis Static
# ======================================================================================
# ADAPTIVE CYCLIC DISPLACEMENT CONTROL
# ======================================================================================

# ======================================================================================
# USER INPUT DATA 
# ======================================================================================

# pseudo-time step (monothonic)
set time {0 1.0}

# absolute displacement at control node
set U {0 245.0 }

# control node and dof
set control_node 44
set control_dof 1
set control_node_pid 0; # only for parallel

# initial displacement increment
set trial_disp_incr 24.5

# parameters for adaptive time step
set max_factor 1.0
set min_factor 1e-06
set max_factor_increment 1.5
set min_factor_increment 1e-06
set max_iter 2000
set desired_iter 1000

# ======================================================================================
# CALCULATION 
# ======================================================================================

# choose the correct integrator
if {$STKO_VAR_is_parallel == 1} {
	set integrator_type ParallelDisplacementControl
} else {
	set integrator_type DisplacementControl
}

# nuber of cycles
set ncycles [expr [llength $time]-1]
# total duration
set total_duration [lindex $time $ncycles]
if {$STKO_VAR_process_id == 0} {
	puts "TOTAL DURATION: $total_duration"
}

# for each cycle...
set STKO_VAR_increment 1
for {set i 1} {$i <= $ncycles} {incr i} {
	set itime [lindex $time $i]
	set itime_old [lindex $time [expr $i-1]]
	set iU [lindex $U $i]
	set iU_old [lindex $U [expr $i-1]]
	
	# compute duration and relative displacement for this cycle
	set DT [expr $itime - $itime_old]
	set DU [expr $iU - $iU_old]
	
	# compute required time steps for this cycle
	# in order to achieve the desired trial disp increment
	set nsteps [expr max(1, int(ceil(abs($DU) / abs($trial_disp_incr))))]
	
	# compute the actual displacement increment
	set dU [expr $DU / $nsteps]
	set dU_tolerance [expr abs($dU) * 1.0e-8]
	# compute the monothonic time step for this cycle
	set dT [expr $DT / $nsteps]
	set STKO_VAR_initial_time_increment $dT
	
	if {$STKO_VAR_process_id == 0} {
		puts "======================================================================"
		puts "CYCLE $i : nsteps = $nsteps; dU = $dU; dT = $dT"
		puts "======================================================================"
	}

	# adaptive time stepping
	set factor 1.0
	set old_factor $factor
	set dU_cumulative 0.0
	set STKO_VAR_time $itime_old
	while 1 {
		
		# are we done with this cycle?
		if {[expr abs($dU_cumulative - $DU)] <= 1.0e-10} {
			if {$STKO_VAR_process_id == 0} {
				puts "Target displacement has been reached. Current DU = $dU_cumulative"
				puts "SUCCESS."
			}
			break
		}
		
		# adapt the current displacement increment
		set dU_adapt [expr $dU * $factor]
		if {[expr abs($dU_cumulative + $dU_adapt)] > [expr abs($DU) - $dU_tolerance]} {
			set dU_adapt [expr $DU - $dU_cumulative]
		}
		
		# compute the associated monothonic time increment
		set STKO_VAR_time_increment [expr $dT * $dU_adapt/$dU]
		
		# update integrator
		integrator $integrator_type $control_node $control_dof $dU_adapt
		
		# before analyze
		STKO_CALL_OnBeforeAnalyze
		
		# perform this step
		set STKO_VAR_analyze_done [analyze 1]
		
		# update common variables
		if {$STKO_VAR_analyze_done == 0} {
			set STKO_VAR_num_iter [testIter]
			set STKO_VAR_time [expr $STKO_VAR_time + $STKO_VAR_time_increment]
			set STKO_VAR_percentage [expr $STKO_VAR_time/$total_duration]
			set norms [testNorms]
			if {$STKO_VAR_num_iter > 0} {set STKO_VAR_error_norm [lindex $norms [expr $STKO_VAR_num_iter-1]]} else {set STKO_VAR_error_norm 0.0}
		}
		
		# after analyze
		set STKO_VAR_afterAnalyze_done 0
		STKO_CALL_OnAfterAnalyze
		
		# check convergence
		if {$STKO_VAR_analyze_done == 0} {
			
			# print statistics
			if {$STKO_VAR_process_id == 0} {
				puts [format "Increment: %6d | Iterations: %4d | Norm: %8.3e | Progress: %7.3f %%" $STKO_VAR_increment $STKO_VAR_num_iter  $STKO_VAR_error_norm [expr $STKO_VAR_percentage*100.0]]
			}
			
			# update adaptive factor
			set factor_increment [expr min($max_factor_increment, [expr double($desired_iter) / double($STKO_VAR_num_iter)])]
			
			# check STKO_VAR_afterAnalyze_done. Simulate a reduction similar to non-convergence
			if {$STKO_VAR_afterAnalyze_done != 0} {
				set factor_increment [expr max($min_factor_increment, [expr double($desired_iter) / double($max_iter)])]
				if {$STKO_VAR_process_id == 0} {
					puts "Reducing increment factor due to custom error controls. Factor = $factor"
				}
			}
			
			set factor [expr $factor * $factor_increment]
			if {$factor > $max_factor} {
				set factor $max_factor
			}
			if {$factor > $old_factor} {
				if {$STKO_VAR_process_id == 0} {
					puts "Increasing increment factor due to faster convergence. Factor = $factor"
				}
			}
			set old_factor $factor
			set dU_cumulative [expr $dU_cumulative + $dU_adapt]
			
			# increment time step
			incr STKO_VAR_increment
			
		} else {
			
			# update adaptive factor
			set STKO_VAR_num_iter $max_iter
			set factor_increment [expr max($min_factor_increment, [expr double($desired_iter) / double($STKO_VAR_num_iter)])]
			set factor [expr $factor * $factor_increment]
			if {$STKO_VAR_process_id == 0} {
				puts "Reducing increment factor due to non convergence. Factor = $factor"
			}
			if {$factor < $min_factor} {
				if {$STKO_VAR_process_id == 0} {
					puts "ERROR: current factor is less then the minimum allowed ($factor < $min_factor)"
					puts "Giving up"
				}
				error "ERROR: the analysis did not converge"
			}
		}
		
	}
	# end of adaptive time stepping
}
wipeAnalysis

# Done!
puts "ANALYSIS SUCCESSFULLY FINISHED"
