import opensees as ops
import numpy as np
import os

def gravityLoadAnalysis():
    
    addVerLoad = 0.0
    
    ops.timeSeries('Linear',1)
    ops.pattern('Plain',1,1)
    
    # Create the nodal load ---------------------------------------------------
    ops.load(22,*[0.0,-addVerLoad*1/4,0.0])
    ops.load(23,*[0.0,-addVerLoad*2/4,0.0])
    ops.load(24,*[0.0,-addVerLoad*1/4,0.0])
    
    # Analysis generation -----------------------------------------------------
    
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

    load_step = 1

    # Set Control Node and DOF
    IDctrlNode = 19
    IDctrlDOF = 1

    iDmax = [0.04,0.08,0.13,0.16,0.24,0.32,0.47,0.47,0.47,0.63,0.63,0.63,0.79,0.79,0.79,0.95,0.95,0.95,1.11,1.11,1.11,1.26,1.26,1.26,1.42,1.42,1.42,1.58,1.58,1.58,1.89,1.89,1.89]
    Dincr = 0.02
    Ncycles = 1
    CycleType = 'Full'
    Fact = 95.0 / 100                       # scale drift ratio by storey height for displacement cycles

    ops.loadConst('-time', 0.0)

    # Lateral load pattern ----------------------------------------------------
    PLateral = 100.               # [N] Reference lateral load  
    
    #ops.pattern('Plain',2,'Linear')
    ops.timeSeries('Linear',2)
    ops.pattern('Plain',2,2)
    
    # Create the nodal load ---------------------------------------------------
    ops.load(16,*[PLateral,0,0])
    ops.load(17,*[PLateral,0,0])
    ops.load(18,*[PLateral,0,0])
    ops.load(19,*[PLateral,0,0])
    ops.load(20,*[PLateral,0,0])
    ops.load(21,*[PLateral,0,0])
    ops.load(22,*[PLateral,0,0])
    ops.load(23,*[PLateral,0,0])
    ops.load(24,*[PLateral,0,0])
    
    # Analysis generation -----------------------------------------------------
    Tol = 1.e-4                            # Convergence Test: tolerance
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
    
    print("########## Start Displacement controlled analysis ##########")
    
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
                        print("Trying 2 times smaller timestep at step ",load_step)
                        ops.integrator('DisplacementControl',IDctrlNode,IDctrlDOF,Dincr/2)
                        ok = ops.analyze(1)
                    
                    if ok != 0:
                        print("Trying 4 times smaller timestep at step ",load_step)
                        ops.integrator('DisplacementControl',IDctrlNode,IDctrlDOF,Dincr/4)
                        ok = ops.analyze(1)
                    
                    if ok != 0:
                        print("Trying 20 times smaller timestep at step ",load_step)
                        ops.integrator('DisplacementControl',IDctrlNode,IDctrlDOF,Dincr/20)
                        ok = ops.analyze(1)

                    if ok != 0:
                        print("Trying 160 times smaller timestep at step ",load_step)
                        ops.integrator('DisplacementControl',IDctrlNode,IDctrlDOF,Dincr/160)
                        ok = ops.analyze(1)

                    if ok != 0:
                        print("Trying 1000 times smaller timestep at step ",load_step)
                        ops.integrator('DisplacementControl',IDctrlNode,IDctrlDOF,Dincr/1000)
                        ok = ops.analyze(1)

                    if ok != 0:
                        print("Trying 10 times greater tolerance at step ",load_step)
                        ops.test(TestType, Tol*10, maxNumIter, 0)
                        ok = ops.analyze(1)

                    if ok != 0:
                        print("Trying 100 times greater tolerance at step ",load_step)
                        ops.test(TestType, Tol*100, maxNumIter, 0)
                        ok = ops.analyze(1)
                    
                    if ok != 0:
                        print("Trying Newton with Current Tangent at load factor ",load_step)
                        ops.test('NormDispIncr', Tol, 1000, 0)
                        ops.algorithm('Newton')
                        ok = ops.analyze(1)
                        ops.test(TestType, Tol, maxNumIter, 0)
                        ops.algorithm(algorithmType)
                
                    if ok != 0:
                        print("Trying Newton with Initial Tangent at load factor ",load_step)
                        ops.test('NormDispIncr', 0.01, 2000, 0)
                        ops.algorithm('Newton',False,True,False)
                        ok = ops.analyze(1)
                        ops.test(TestType, Tol, maxNumIter, 0)
                        ops.algorithm(algorithmType)
                
                    if ok != 0:
                        print("Trying Modified Newton at load factor ", load_step)
                        ops.test('NormDispIncr', 0.01, 2000, 0)
                        ops.algorithm('ModifiedNewton')
                        ok = ops.analyze(1)
                        ops.test(TestType, Tol, maxNumIter, 0)
                        ops.algorithm(algorithmType)
                
                    if ok != 0:
                        print("Trying Broyden at load factor ", load_step)
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
        print("########## Analysis failed ##########")
    else:
        print("########## Analysis completed successfully ##########")

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    