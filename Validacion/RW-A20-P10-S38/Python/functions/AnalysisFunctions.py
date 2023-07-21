import opensees as ops
import numpy as np
import os

# =============================================================================
# UNITS
# =============================================================================
mm = 1.
N = 1.
sec = 1.

# Define engineering units
mm2 = mm*mm
MPa = N/mm2
kN = 1000*N

def gravityLoadAnalysis():
    
    NAxial = 640.544*kN                       # Axial load

    ops.timeSeries('Linear',1)
    ops.pattern('Plain',1,1)

    # Create the nodal load ---------------------------------------------------
    #   load(nodeTag, *loadValues)
    ops.load(  19,    *[0.0, -NAxial/2, 0.0])
    ops.load(  20,    *[0.0, -NAxial/2, 0.0])

    # Analysis generation  ----------------------------------------------------
    Tol = 0.0001

    # Create the integration scheme, the LoadControl scheme using steps of 0.05
    ops.integrator('LoadControl',0.05)

    # Create the system of equation, a sparse solver with partial pivoting
    ops.system('BandGeneral')

    # Create the convergence test, the norm of the residual with a tolerance of
    # Tol and a max number of iterations of 100
    ops.test('NormDispIncr',Tol,100,0)

    # Create the DOF numberer, the reverse Cuthill-McKee algorithm
    ops.numberer('RCM')

    # Create the constraint handler, the transformation method
    ops.constraints('Transformation')

    # Create the solution algorithm, a Newton-Raphson algorithm
    # algorithm('Newton', secant=False, initial=False, initialThenCurrent=False)
    ops.algorithm('Newton',False,True,False)

    # Create the analysis object
    ops.analysis('Static')

    # Run analysis
    ops.analyze(20)
    
def GeneratePeaks(Dmax, Dincr = 0.01 , CycleType = 'Full', Fact = 1):
    ###########################################################################
    ## GeneratePeaks $Dmax $DincrStatic $CycleType $Fact 
    ###########################################################################
    # generate incremental disps for Dmax
    # this proc creates a file which defines a vector then executes the file to return the vector of disp. increments
    # by Silvia Mazzoni, 2006
    # input variables
    #   $Dmax   : peak displacement (can be + or negative)
    #   $DincrStatic    : displacement increment (optional, default=0.01, independently of units)
    #   $CycleType  : Push (0->+peak), Half (0->+peak->0), Full (0->+peak->0->-peak->0)   (optional, def=Full)
    #   $Fact   : scaling factor (optional, default=1)
    #   $iDstepFileName : file name where displacement history is stored temporarily, until next disp. peak
    # output variable
    #   $iDstep : vector of displacement increments
    
    carpeta = 'data'
    if not os.path.exists(carpeta):
        os.makedirs(carpeta)

    outFileID = open(carpeta + '/' + 'tmpDsteps.txt','w')    
    
    iDstep = []
    Disp = 0.0
    
    print('set iDstep {', file = outFileID) 
    print(Disp,file = outFileID)
    
    iDstep = np.append(iDstep,Disp)
    Dmax = Dmax*Fact
    
    if Dmax < 0:
        dx = -Dincr
    else:
        dx = Dincr
    
    NstepsPeak = int(abs(Dmax)/Dincr)
    for step in range(1,NstepsPeak+1):      # zero to one
        Disp = Disp + dx
        print(Disp,file = outFileID)
        iDstep = np.append(iDstep,Disp)
        
        
    if CycleType != 'Push':
        for step in range(1,NstepsPeak+1):      # one to zero
            Disp = Disp - dx
            print(Disp,file = outFileID)
            iDstep = np.append(iDstep,Disp)
        
        if CycleType != 'Half':
            for step in range(1,NstepsPeak+1):      # zero to minus one
                Disp = Disp - dx
                print(Disp,file = outFileID)
                iDstep = np.append(iDstep,Disp)
                
            for step in range(1,NstepsPeak+1):      # mius one to zero
                Disp = Disp + dx
                print(Disp,file = outFileID)
                iDstep = np.append(iDstep,Disp)
        
    print('}',file = outFileID)
    outFileID.close()
    
    return iDstep

    
def displacementControlledAnalysis():
    # Set the loads to be constant & reset the time in the domain 
    #   loadConst('-time', pseudoTime)
    ops.loadConst('-time', 0.0)

    # Lateral Load Pattern ----------------------------------------------------
    PLateral = 1.*kN                        # Reference lateral load

    ops.timeSeries('Linear',2)
    ops.pattern('Plain',200,2)
    # Create the nodal load - command: load(nodeTag, *loadValues)
    ops.load(15,*[PLateral,0,0])
    ops.load(16,*[PLateral,0,0])
    ops.load(17,*[PLateral,0,0])
    ops.load(18,*[PLateral,0,0])
    ops.load(19,*[PLateral,0,0])
    ops.load(20,*[PLateral,0,0])

    # Analysis generation -----------------------------------------------------
    Tol = 1.e-3                            # Convergence Test: tolerance
    maxNumIter = 1000                      # Convergence Test: maximum number of iterations that will be performed before "failure to converge" is returned
    printFlag = 0                          # Convergence Test: flag used to print information on convergence (optional)        # 1: print information on each step; 
    TestType = 'NormDispIncr'              # Convergence-test type
    algorithmType = 'KrylovNewton'         # Algorithm type

    ops.constraints('Transformation')
    ops.numberer('RCM')
    ops.system('BandGeneral')
    ops.test(TestType, Tol, maxNumIter, printFlag)
    ops.algorithm(algorithmType)
    ops.analysis('Static')
    
    load_step = 1
    
    # Set Control Node and DOF
    IDctrlNode = 17
    IDctrlDOF = 1

    iDmax = [0.1, 0.3, 0.5, 0.7, 1, 1.5, 2.2, 3.1]
    Dincr = 0.2
    Ncycles = 1
    CycleType = 'Full'
    Fact = 2438.4*mm/100                                  # scale drift ratio by storey height for displacement cycles
    
    #ops.record()
    print("Start Displacement controlled analysis")
    
    for Dmax in iDmax:
        iDstep = GeneratePeaks(Dmax, Dincr, CycleType, Fact)           # displacement steps
        for cycle in range(1,Ncycles+1):
            D0 = 0.0
            for Dstep in iDstep:
                D1 = Dstep
                Dincr = D1 - D0
                ops.integrator('DisplacementControl',IDctrlNode,IDctrlDOF,Dincr)
                ops.analysis('Static')
                # ----------- first analyze command ---------------------------
                ok = ops.analyze(1)
                # ----------- if convergence failure --------------------------
                if ok != 0:
                    if ok != 0:
                        print("Trying Newton with Current Tangent ...")
                        ops.test('NormDispIncr', Tol, 1000, 0)
                        ops.algorithm('Newton')
                        ok = ops.analyze(1)
                        ops.test(TestType, Tol, maxNumIter, 0)
                        ops.algorithm(algorithmType)
                    
                    if ok != 0:
                        print("Trying Newton with Initial Tangent ...")
                        ops.test('NormDispIncr', 0.01, 2000, 0)
                        ops.algorithm('Newton',False,True,False)
                        ok = ops.analyze(1)
                        ops.test(TestType, Tol, maxNumIter, 0)
                        ops.algorithm(algorithmType)
                    
                    if ok != 0:
                        print("Trying Modified Newton ...")
                        ops.test('NormDispIncr', 0.01, 2000, 0)
                        ops.algorithm('ModifiedNewton')
                        ok = ops.analyze(1)
                        ops.test(TestType, Tol, maxNumIter, 0)
                        ops.algorithm(algorithmType)
                    
                    if ok != 0:
                        print("Trying Broyden ...")
                        ops.algorithm('Broyden', 500)
                        ok = ops.analyze(1)
                        ops.algorithm(algorithmType)
                    
                    if ok != 0:
                        print("PROBLEM")
                        return -1
                    
                # -------------------------------------------------------------
                D0 = D1   # move to next step
                # Print load step on the screen
                print("Load Step: {}".format(load_step))
                load_step = load_step + 1
                
    
    if ok != 0:
        print("Analysis failed")
    else:
        print("Analysis completed successfully")
