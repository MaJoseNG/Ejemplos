# Nodes 
# node $nodeTag (ndm $coords) <-mass (ndf $massValues)>
node 1  0       0          
node 2  1220    0           
node 3  0       610.0   
node 4  1220    610.0      
node 5  0       929.96     
node 6  1220    929.96      
node 7  0       1249.92      
node 8  1220    1249.92      
node 9  0       1569.88     
node 10 1220    1569.88     
node 11 0       1889.84     
node 12 1220    1889.84     
node 13 0       2209.8     
node 14 1220    2209.8     
node 15 0       2438.4       
node 16 1220    2438.4       
node 17 0       2667      
node 18 1220    2667      

# Restraint Fixes
# fix $nodeTag (ndf $constrValues)
fix 1 1 1 1;                       
fix 2 1 1 1;                       
fix 17 0 0 1;                       
fix 18 0 0 1; 

# Diaphragm Restraints
# rigidDiaphragm $perpDirn $masterNodeTag $slaveNodeTag1 $slaveNodeTag2 ...

# Node Restraints 
#equalDOF $masterNodeTag $slaveNodeTag $dof1 $dof2 ...
equalDOF 13 14 1
equalDOF 15 16 1
equalDOF 17 18 1