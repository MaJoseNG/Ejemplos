wipe all

# Source display procedures
source LibUnits.tcl

# --------------------------------------------------------
# Start of model generation (Units: kgf, cm)
# --------------------------------------------------------
set dataDir MEFI_SW_T2_S3_4

file mkdir $dataDir;

# Create ModelBuilder for 2D element (with two-dimensions and 3 DOF/node)
model BasicBuilder -ndm 2 -ndf 3;

# --------------------------------------------
# Set geometry, nodes, boundary conditions
# --------------------------------------------
# Nodes 
# node $nodeTag (ndm $coords) <-mass (ndf $massValues)>
node 1   0    0;
node 2   75   0;
node 3   150  0;
node 4   0    15;
node 5   75   15;
node 6   150  15;
node 7   0    30;
node 8   75   30;
node 9   150  30;
node 10  0    45;
node 11  75   45;
node 12  150  45;
node 13  0    60;
node 14  75   60;
node 15  150  60;
node 16  0    75;
node 17  75   75;
node 18  150  75;
node 19  0    95;
node 20  75   95;
node 21  150  95;
node 22  0    115;
node 23  75   115;
node 24  150  115;
          
        
# ------------------------------
# Define propierties materials
# ------------------------------
# Steel propierties
set Fy    [expr 584.0*10.2];             #[MPa]*10.2 = [kgf/cm2]
set Fy_hw [expr 584.0*10.2];             #[MPa]*10.2 = [kgf/cm2]
set Fy_vw [expr 584.0*10.2];             #[MPa]*10.2 = [kgf/cm2]
set Fy_b  [expr 473.0*10.2];             #[MPa]*10.2 = [kgf/cm2]

set Es [expr 200000.0*10.2];                 #[MPa]*10.2 = [kgf/cm2]
set OrientationEmbeddedSteel 0.0;
set R0 18.0;                      
set CR1 0.9;                      
set CR2 0.15;    
set a1 0.0;
set a2 1.0;
set a3 0.0;
set a4 1.0;       
set b  0.02;            # valor momentaneo  

set strainAtFy 0.002;   # no se debiera requerir     

# Concrete propierties
#set Fc_Pedestal [expr -29.0*10.2];          #[MPa]*10.2 = [kgf/cm2]
#set Ec_Pedestal [expr 31000.0*10.2];        #[MPa]*10.2 = [kgf/cm2]

set magnitudGSelfWeightLoad 980.0;            # [cm/s^2]
set rhoConcreteMaterial [expr 2500.0*(10**(-6))/$magnitudGSelfWeightLoad];

#set damageConstantUnconf_1 0.15;
#set damageConstantUnconf_2 0.5;
#set damageConstantConf_1   0.15;
#set damageConstantConf_2   0.5;

set Fc  [expr -29.0*10.2];                   #[MPa]*10.2 = [kgf/cm2]
set Fcr [expr 1.67*10.2];                   #[MPa]*10.2 = [kgf/cm2]
set strainAtFcr 0.00008;
set strainAtFc  -0.002;
set strainAtFc_conf -0.005;
#set nuConcrete  0.2;  
  
# Parametros adicionales para uso con Concrete02
set Et [expr 0.1*$Fc/$strainAtFc];
set Et_conf [expr 0.1*$Fc/$strainAtFc_conf];
set Fcu [expr 0.09*$Fc];
set strainAtFcu -0.016;
set lambda 0.05;
# ------------------------------
# Build materials and sections
# ------------------------------
########### Wall: Confined border ###############
set wallThickness 12.0;                         #[cm]

set rouXb 0.0067;               # X boundary
set rouYb 0.0516;               # Y boundary

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
uniaxialMaterial Steel02 2 $Fy_b $Es $b $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel X
uniaxialMaterial Steel02 3 $Fy_b $Es $b $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel Y boundary

# uniaxialMaterial Concrete02 $matTag       $fpc          $epsc0         $fpcu    $epsU     $lambda $ft  $Ets
uniaxialMaterial Concrete02       10   [expr 0.75*$Fc]  $strainAtFc_conf  $Fcu  $strainAtFcu $lambda $Fcr $Et_conf;       # confined concrete

# ----------------------------------------------------------------------------------------
# Shear resisting mechanism parameters
# ----------------------------------------------------------------------------------------
set nu 0.35;                # friction coefficient
set alfadow [expr 0.005];   # dowel action stiffness parameter
#set alfadow [expr 0.05/5];   # dowel action stiffness parameter

#nDMaterial FSAM $mattag      $rho          $sX $sY $conc  $rouX  $rouY   $nu $alfadow
nDMaterial FSAM    30  $rhoConcreteMaterial  2   3    10   $rouXb $rouYb  $nu  $alfadow; 

########### Wall: Unconfined center ###############
set rouXw 0.0067;               # X web
set rouYw 0.0067;               # Y web

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
uniaxialMaterial Steel02 4 $Fy_vw $Es $b $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel X 
uniaxialMaterial Steel02 5 $Fy_hw $Es $b $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel Y web
 
# uniaxialMaterial Concrete02 $matTag        $fpc          $epsc0      $fpcu    $epsU     $lambda $ft  $Ets
uniaxialMaterial Concrete02       11   [expr 0.75*$Fc]    $strainAtFc  $Fcu  $strainAtFcu $lambda $Fcr $Et;       # confined concrete

#nDMaterial FSAM $mattag      $rho          $sX $sY $conc  $rouX  $rouY   $nu $alfadow
nDMaterial FSAM    31  $rhoConcreteMaterial  4   5    11   $rouXw $rouYw  $nu  $alfadow; 

########### Beam: Border ###############
set BeamThickness 40.0;   #[cm]

set rouXb [expr 0.0067*2];               # X boundary
set rouYb [expr 0.0516*2];               # Y boundary

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
uniaxialMaterial Steel02 6 $Fy_b $Es $b $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel X 
uniaxialMaterial Steel02 7 $Fy_b $Es $b $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel Y web   

# uniaxialMaterial Concrete02 $matTag       $fpc            $epsc0     $fpcu    $epsU     $lambda $ft  $Ets
uniaxialMaterial Concrete02      12    [expr 0.75*$Fc]    $strainAtFc  $Fcu  $strainAtFcu $lambda $Fcr $Et;       # confined concrete

#nDMaterial FSAM $mattag      $rho          $sX $sY $conc  $rouX  $rouY   $nu $alfadow
nDMaterial FSAM    32  $rhoConcreteMaterial  6   7    12   $rouXb $rouYb  $nu  $alfadow; 

########### Beam: Center ###############
set rouXw [expr 0.0067*2];               # X web
set rouYw [expr 0.0067*2];               # Y web

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
uniaxialMaterial Steel02 8 $Fy_b $Es $b $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel X 
uniaxialMaterial Steel02 9 $Fy_b $Es $b $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel Y web 

# uniaxialMaterial Concrete02 $matTag       $fpc          $epsc0     $fpcu    $epsU     $lambda $ft  $Ets
uniaxialMaterial Concrete02       13   [expr 0.75*$Fc]   $strainAtFc  $Fcu  $strainAtFcu $lambda $Fcr $Et;       # confined concrete  

#nDMaterial FSAM $mattag      $rho          $sX $sY $conc  $rouX  $rouY   $nu $alfadow
nDMaterial FSAM    33  $rhoConcreteMaterial  8   9    13   $rouXw $rouYw  $nu  $alfadow; 

# -----------------------------
#  Define elements
# ------------------------------
set nFiber 4;
set db [expr 130.0/10];           # [cm] Ancho de fibra del elemento de borde
set dw [expr 206.66667/10];       # [cm] Ancho de fibra del elemento central
#set pwb [expr (300/10)/4];        # [cm] Ancho de fibra del elemento left y right (Pedestal)
set tw $wallThickness;
set tb $BeamThickness;

element MEFI 1 1 2 5 4 $nFiber -thick $tw $tw $tw $tw -width $db $dw $dw $dw  -mat 30 31 31 31; #izq
element MEFI 2 2 3 6 5 $nFiber -thick $tw $tw $tw $tw -width $dw $dw $dw $db  -mat 31 31 31 30; #der
element MEFI 3 4 5 8 7 $nFiber -thick $tw $tw $tw $tw -width $db $dw $dw $dw  -mat 30 31 31 31;
element MEFI 4 5 6 9 8 $nFiber -thick $tw $tw $tw $tw -width $dw $dw $dw $db  -mat 31 31 31 30; #der
element MEFI 5 7 8 11 10 $nFiber -thick $tw $tw $tw $tw -width $db $dw $dw $dw  -mat 30 31 31 31; #izq
element MEFI 6 8 9 12 11 $nFiber -thick $tw $tw $tw $tw -width $dw $dw $dw $db  -mat 31 31 31 30; #der
element MEFI 7 10 11 14 13 $nFiber -thick $tw $tw $tw $tw -width $db $dw $dw $dw  -mat 30 31 31 31; #izq
element MEFI 8 11 12 15 14 $nFiber -thick $tw $tw $tw $tw -width $dw $dw $dw $db  -mat 31 31 31 30; #der
element MEFI 9 13 14 17 16 $nFiber -thick $tw $tw $tw $tw -width $db $dw $dw $dw  -mat 30 31 31 31; #izq
element MEFI 10 14 15 18 17 $nFiber -thick $tw $tw $tw $tw -width $dw $dw $dw $db  -mat 31 31 31 30; #der
element MEFI 11 16 17 20 19 $nFiber -thick $tb $tb $tb $tb -width $db $dw $dw $dw  -mat 32 33 33 33; #izq
element MEFI 12 17 18 21 20 $nFiber -thick $tb $tb $tb $tb -width $dw $dw $dw $db  -mat 33 33 33 32; #der
element MEFI 13 19 20 23 22 $nFiber -thick $tb $tb $tb $tb -width $db $dw $dw $dw  -mat 32 33 33 33; #izq
element MEFI 14 20 21 24 23 $nFiber -thick $tb $tb $tb $tb -width $dw $dw $dw $db  -mat 33 33 33 32; #der

# Restraint Fixes
# fix $nodeTag (ndf $constrValues)
fix 1 1 1 1;                       
fix 2 1 1 1;                      
fix 3 1 1 1; 

# Node Restraints 
#equalDOF $masterNodeTag $slaveNodeTag $dof1 $dof2 ...
equalDOF 16 17 1;
equalDOF 16 18 1;
equalDOF 19 20 1;
equalDOF 19 21 1;
equalDOF 22 23 1;
equalDOF 22 24 1;

# ------------------------------
#  Define recorders
# ------------------------------
source Recorders_SWT2S34.tcl

puts "MODEL GENERATED successfully."