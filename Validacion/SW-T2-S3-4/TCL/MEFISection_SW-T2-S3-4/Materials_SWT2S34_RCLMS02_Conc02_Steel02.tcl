# -----------------------------------------
# Define and build steel uniaxial material
# -----------------------------------------
# Steel propierties
set Fy_hw 584.0;                            # [MPa]
set Fy_vw 584.0;                            # [MPa]
set Fy_b  473.0;                            # [MPa]

set Es 200000.0;                            # [MPa]
set OrientationEmbeddedSteel 0.0;
#set R0  18.0;         #funciona mal pero funciona
set R0  20.0;               
#set CR1 0.9;     
set CR1 0.925;                 
set CR2 0.15;          
set b   0.008;
          
#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
uniaxialMaterial Steel02 2 $Fy_hw $Es $b $R0 $CR1 $CR2;   # steel X
uniaxialMaterial Steel02 3 $Fy_vw $Es $b $R0 $CR1 $CR2;   # steel Y web
uniaxialMaterial Steel02 4 $Fy_b  $Es $b $R0 $CR1 $CR2;   # steel X/Y boundary

# -----------------------------------------
# Define and build concrete uniaxial material
# -----------------------------------------
set Fc  -29.0;                          # [MPa]
set Fcr  1.67;                          # [MPa]
set strainAtFc  -0.002;
set strainAtFcr 0.00008;

set E0 29000;                            # [MPa]
set Et [expr 0.05*$E0];                  # [MPa]
set Fcu [expr 0.05*$Fc];                  # [MPa]
set strainAtFcu -0.041;
set lambda 0.1;

# uniaxialMaterial Concrete02 $matTag $fpc    $epsc0     $fpcu    $epsU     $lambda $ft  $Ets
uniaxialMaterial Concrete02     11     $Fc  $strainAtFc  $Fcu  $strainAtFcu $lambda $Fcr $Et;      
# -----------------------------------------
# Define FSAM nDMaterial
# -----------------------------------------
set rouXb 0.0068;               # X boundary
set rouYb 0.0515;               # Y boundary
set rouXw 0.0068;               # X web
set rouYw 0.0068;               # Y web

set nu 0.35;                    # friction coefficient
set alfadow 0.0001;             # dowel action stiffness parameter

set magnitudGSelfWeightLoad 9800.0;            # [mm/s^2]
set rhoConcreteMaterial [expr 2500.0*(10**(-9))/$magnitudGSelfWeightLoad];

nDMaterial FSAM 6  $rhoConcreteMaterial  2   3   11  $rouXw $rouYw  $nu  $alfadow; # Web 
nDMaterial FSAM 7  $rhoConcreteMaterial  4   4   11  $rouXb $rouYb  $nu  $alfadow; # Boundary 

# ----------------------------------------------------------------------------------------
# Define ReinforcedConcreteLayerMembraneSection01 section
# ----------------------------------------------------------------------------------------
set wallThickness 120;          # [mm]
set BeamThickness 400;          # [mm]

# section ReinforcedConcreteLayerMembraneSection02 $secTag $matTag $Thickness
section ReinforcedConcreteLayerMembraneSection02 30 7 $wallThickness;     # Wall boundary
section ReinforcedConcreteLayerMembraneSection02 31 6 $wallThickness;     # Wall web
section ReinforcedConcreteLayerMembraneSection02 32 7 $BeamThickness;     # Loading tranfer beam boundary
section ReinforcedConcreteLayerMembraneSection02 33 6 $BeamThickness;     # Loading tranfer beam web