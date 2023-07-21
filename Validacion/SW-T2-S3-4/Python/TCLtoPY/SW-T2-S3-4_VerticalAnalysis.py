import opensees as ops

ops.set('addVerLoad','0.0;')
ops.pattern('Plain',1,'Linear')
    # Create the nodal load - command: load nodeID xForce yForce zMoment
ops.load(22,0.0,'[expr','-$addVerLoad*1/4]',0.0)
ops.load(23,0.0,'[expr','-$addVerLoad*2/4]',0.0)
ops.load(24,0.0,'[expr','-$addVerLoad*1/4]',0.0)


# ------------------------------
# Gravity load analysis
# ------------------------------

ops.set('Tol',.0001)
ops.source('SW_S34_VerticalLoad.tcl')

# ------------------------------
# Analysis generation
# ------------------------------
# Create the integration scheme, the LoadControl scheme using steps of 0.05
ops.integrator('LoadControl',0.05)

# Create the system of equation, a sparse solver with partial pivoting
ops.system('BandGeneral')

# Create the convergence test, the norm of the residual with a tolerance of
# Tol and a max number of iterations of 100
ops.test('NormDispIncr','$Tol',100,0)

# Create the DOF numberer, the reverse Cuthill-McKee algorithm
ops.numberer('RCM')

# Create the constraint handler, the transformation method
ops.constraints('Transformation')

# Create the solution algorithm, a Newton-Raphson algorithm
ops.algorithm('Newton','-initial','#','-initialThenCurrent')

# Create the analysis object
ops.analysis('Static')

# Run analysis
ops.analyze(20)


