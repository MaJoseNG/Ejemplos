# Nodes 
# node $nodeTag (ndm $coords) <-mass (ndf $massValues)>
node 1   0    0;
node 2   750  0;
node 3   1500 0;
node 4   0    150;
node 5   750  150;
node 6   1500 150;
node 7   0    300;
node 8   750  300;
node 9   1500 300;
node 10  0    450;
node 11  750  450;
node 12  1500 450;
node 13  0    600;
node 14  750  600;
node 15  1500 600;
node 16  0    750;
node 17  750  750;
node 18  1500 750;
node 19  0    950;
node 20  750  950;
node 21  1500 950;
node 22  0    1150;
node 23  750  1150;
node 24  1500 1150;
          
# Restraint Fixes
# fix $nodeTag (ndf $constrValues)
fix 1 1 1 1;                       
fix 2 1 1 1;                      
fix 3 1 1 1; 

       #fix 22 0 0 1;
#fix 23 0 0 1;
#fix 24 0 0 1;

# Node Restraints 
#equalDOF $masterNodeTag $slaveNodeTag $dof1 $dof2 ...
equalDOF 16 17 1;
equalDOF 16 18 1;
equalDOF 19 20 1;
equalDOF 19 21 1;
equalDOF 22 23 1;
equalDOF 22 24 1;