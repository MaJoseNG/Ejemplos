 set PLateral [expr 100.];     # [N] Reference lateral load    
 pattern Plain 2 Linear {
    # Create the nodal load - command: load nodeID xForce yForce zMoment
    load 16 $PLateral 0 0
    load 17 $PLateral 0 0
    load 18 $PLateral 0 0
    load 19 $PLateral 0 0
    load 20 $PLateral 0 0
    load 21 $PLateral 0 0
    load 22 $PLateral 0 0
    load 23 $PLateral 0 0
    load 24 $PLateral 0 0
}