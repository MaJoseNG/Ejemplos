import opensees as ops

ops.set('PLateral','[expr','100.];','#','[N]','Reference','lateral','load')
ops.pattern('Plain',2,'Linear')
    # Create the nodal load - command: load nodeID xForce yForce zMoment
ops.load(16,'$PLateral',0,0)
ops.load(17,'$PLateral',0,0)
ops.load(18,'$PLateral',0,0)
ops.load(19,'$PLateral',0,0)
ops.load(20,'$PLateral',0,0)
ops.load(21,'$PLateral',0,0)
ops.load(22,'$PLateral',0,0)
ops.load(23,'$PLateral',0,0)
ops.load(24,'$PLateral',0,0)


# ----------------------------------------------------
# Displacement Controlled Analysis
# ----------------------------------------------------

# Set the loads to be constant & reset the time in the domain
ops.loadConst('-time',0.0)

ops.source('SW_S34_HorizontalLoad.tcl')

# ------------------------------
ops.set('Tol','1.e-3;','#','Convergence','Test:','tolerance')
ops.set('maxNumIter','1000;','#','Convergence','Test:','maximum','number','of','iterations','that','will','be','performed','before','"failure','to','converge"','is','returned')
ops.set('printFlag','0;','#','Convergence','Test:','flag','used','to','print','information','on','convergence','(optional)','#','1:','print','information','on','each','step;')
ops.set('TestType','NormDispIncr;','#','Convergence-test','type')
ops.set('algorithmType','KrylovNewton;','#','Algorithm','type')

ops.constraints('Transformation;')
ops.numberer('RCM')
ops.system('BandGeneral')
ops.test('$TestType','$Tol','$maxNumIter','$printFlag')
ops.algorithm('$algorithmType;')
ops.analysis('Static')

ops.set('fmt1','"%s','Cyclic','analysis:','CtrlNode','%.3i,','dof','%.1i,','Disp=%.4f','%s";','#','format','for','screen/file','output','of','DONE/PROBLEM','analysis')

ops.foreach('Dmax','$iDmax')

ops.set('iDstep','[GeneratePeaks','$Dmax','$Dincr','$CycleType','$Fact];','#','this','proc','is','defined','above')

ops.for('{set','i','1}','{$i','<=','$Ncycles}','{incr','i','1}')

ops.set('zeroD',0)
ops.set('D0',0.0)
ops.foreach('Dstep','$iDstep')
ops.set('D1','$Dstep')
ops.set('Dincr','[expr','$D1','-','$D0]')
ops.integrator('DisplacementControl','$IDctrlNode','$IDctrlDOF','$Dincr')
ops.analysis('Static')
            # ----------------------------------------------first analyze command------------------------
ops.set('ok','[analyze','1]')
            # ----------------------------------------------if convergence failure-------------------------
ops.if('{$ok','!=','0}')
                # if analysis fails, we try some other stuff
                # performance is slower inside this loop    global maxNumIterStatic;# max no. of iterations performed before "failure to converge" is ret'd
ops.if('{$ok','!=','0}')
ops.puts('"Trying','Newton','with','Current','Tangent','.."')
ops.test('NormDispIncr','$Tol',1000,0)
ops.algorithm('Newton')
ops.set('ok','[analyze','1]')
ops.test('$TestType','$Tol','$maxNumIter',0)
ops.algorithm('$algorithmType')
ops.if('{$ok','!=','0}')
ops.puts('"Trying','Newton','with','Initial','Tangent','.."')
ops.test('NormDispIncr',0.01,2000,0)
ops.algorithm('Newton','-initial')
ops.set('reSolution','[expr','$reSolution','+','1]')
ops.set('ok','[analyze','1]')
ops.test('$TestType','$Tol','$maxNumIter',0)
ops.algorithm('$algorithmType')
ops.if('{$ok','!=','0}')
ops.puts('"Trying','Modified','Newton','.."')
ops.test('NormDispIncr',0.01,2000,0)
ops.algorithm('ModifiedNewton')
ops.set('ok','[analyze','1]')
ops.test('$TestType','$Tol','$maxNumIter',0)
ops.algorithm('$algorithmType')
ops.if('{$ok','!=','0}')
ops.puts('"Trying','Broyden','.."')
ops.algorithm('Broyden',500)
ops.set('ok','[analyze',1,']')
ops.algorithm('$algorithmType')
ops.if('{$ok','!=','0}')
ops.set('putout','[format','$fmt1','"PROBLEM"','$IDctrlNode','$IDctrlDOF','[nodeDisp','$IDctrlNode','$IDctrlDOF]','$LunitTXT]')
ops.puts('$putout')
ops.return(-1)
            # -----------------------------------------------------------------------------------------------------
ops.set('D0','$D1;','#','move','to','next','step')

            # print load step on the screen
ops.puts('"Load','Step:','[expr','$load_step]"')
ops.set('load_step','[expr','$load_step+1]')





# -----------------------------------------------------------------------------------------------------
ops.if('{$ok','!=',0ops.puts('[format','$fmt1','"PROBLEM"','$IDctrlNode','$IDctrlDOF','[nodeDisp','$IDctrlNode','$IDctrlDOF]','$LunitTXT]')
ops.puts('[format','$fmt1','"DONE"','$IDctrlNode','$IDctrlDOF','[nodeDisp','$IDctrlNode','$IDctrlDOF]','$LunitTXT]')


