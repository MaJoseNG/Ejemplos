set LATERAL 1;                  # Pattern tag   
set PLateral [expr 1.*$kN];     # Reference lateral load    
pattern Plain $LATERAL Linear {
    # Create the nodal load - command: load nodeID xForce yForce zMoment
    load 13 $PLateral 0 0
    load 14 $PLateral 0 0
    load 15 $PLateral 0 0
    load 16 $PLateral 0 0
    load 17 $PLateral 0 0
    load 18 $PLateral 0 0
}