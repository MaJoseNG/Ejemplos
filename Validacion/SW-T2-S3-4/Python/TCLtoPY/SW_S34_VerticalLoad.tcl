set addVerLoad 0.0;
pattern Plain 1 Linear {
    # Create the nodal load - command: load nodeID xForce yForce zMoment
    load 22  0.0  [expr -$addVerLoad*1/4]  0.0 
    load 23  0.0  [expr -$addVerLoad*2/4]  0.0
    load 24  0.0  [expr -$addVerLoad*1/4]  0.0
}