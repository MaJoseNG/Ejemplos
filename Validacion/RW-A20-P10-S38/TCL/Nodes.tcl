# Nodes 
# node $nodeTag (ndm $coords) <-mass (ndf $massValues)>
node 1	0       0          
node 2	1220	0           
node 3	0       315.69      
node 4	1220	315.69      
node 5	0       631.37      
node 6	1220	631.37      
node 7	0       947.06      
node 8	1220	947.06      
node 9	0       1262.74     
node 10	1220	1262.74     
node 11	0       1578.43     
node 12	1220	1578.43     
node 13	0       1894.11     
node 14	1220	1894.11     
node 15	0       2209.8      
node 16	1220	2209.8      
node 17	0       2438.4      
node 18	1220	2438.4      
node 19	0       2667        
node 20	1220	2667

# Restraint Fixes
# fix $nodeTag (ndf $constrValues)
fix 1 1 1 1;                       
fix 2 1 1 1;                       
fix 19 0 0 1;                       
fix 20 0 0 1; 

# Diaphragm Restraints
# rigidDiaphragm $perpDirn $masterNodeTag $slaveNodeTag1 $slaveNodeTag2 ...

# Node Restraints 
#equalDOF $masterNodeTag $slaveNodeTag $dof1 $dof2 ...
equalDOF 15 16 1
equalDOF 17 18 1
equalDOF 19 20 1