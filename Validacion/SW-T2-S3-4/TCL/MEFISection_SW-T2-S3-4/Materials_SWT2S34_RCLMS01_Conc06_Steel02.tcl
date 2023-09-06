# -----------------------------------------
# Define and build steel uniaxial material
# -----------------------------------------
# Steel propierties
set Fy_hw 584.0;                            # [MPa]
set Fy_vw 584.0;                            # [MPa]
set Fy_b  473.0;                            # [MPa]

set Es 200000.0;                            # [MPa]
set OrientationEmbeddedSteel 0.0;
set R0  18.0;                      
set CR1 0.9;                      
set CR2 0.15;          
set b   0.008;
          
#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
uniaxialMaterial Steel02 2 $Fy_hw $Es $b $R0 $CR1 $CR2;   # steel X
uniaxialMaterial Steel02 3 $Fy_vw $Es $b $R0 $CR1 $CR2;   # steel Y web
uniaxialMaterial Steel02 4 $Fy_b  $Es $b $R0 $CR1 $CR2;   # steel X/Y boundary

# -----------------------------------------
# Define and build steel nD material
# -----------------------------------------
set rouXb 0.0068;               # X boundary
set rouYb 0.0515;               # Y boundary
set rouXw 0.0068;               # X web
set rouYw 0.0068;               # Y web

# nDMaterial SmearedSteelDoubleLayerT2DMaterial01 $tag $s1 $s2 $ratioSteelLayer1 $ratioSteelLayer2 $OrientationEmbeddedSteel
nDMaterial SmearedSteelDoubleLayerT2DMaterial01     20   4   4      $rouXb            $rouYb        $OrientationEmbeddedSteel;    # steel boundary
nDMaterial SmearedSteelDoubleLayerT2DMaterial01     22   2   3      $rouXw            $rouYw        $OrientationEmbeddedSteel;    # steel web

# -----------------------------------------
# Define and build concrete uniaxial material
# -----------------------------------------
set Fc  -29.0;                   # [MPa]
set Fcr  1.67;                   # [MPa]
set strainAtFc  -0.002;
set strainAtFc_conf  -0.005;
set strainAtFcr 0.00008;

set AlphaC 0.32;
set AlphaT 0.08;
#set K 0.75;
#set n 2.5;
#set BB 0.6;                 # o 0.4

set K 0.95;
set n 2.5;
set BB 0.6;   

#uniaxialMaterial Concrete06 $matTag  $fc    $e0      $n $k $alpha1 $fcr     $ecr     $b  $alpha2
#uniaxialMaterial Concrete06    10     $Fc  $strainAtFc_conf  $n $K $AlphaC $Fcr $strainAtFcr $BB $AlphaT;      #concrete boundary
uniaxialMaterial Concrete06    11     $Fc  $strainAtFc       $n $K $AlphaC $Fcr $strainAtFcr $BB $AlphaT;      #concrete web
# -----------------------------------------
# Define and build concrete nD material
# -----------------------------------------
set magnitudGSelfWeightLoad 9800.0;            # [mm/s^2]
set rhoConcreteMaterial [expr 2500.0*(10**(-9))/$magnitudGSelfWeightLoad];

set damageConstant_1 0.175;
set damageConstant_2 0.5;

# nDMaterial OrthotropicRotatingAngleConcreteT2DMaterial01 $matTag $conc     $ecr          $ec           $rho <-damageCte1 $DamageCte1> <-damageCte1 $DamageCte1>
#nDMaterial OrthotropicRotatingAngleConcreteT2DMaterial01      21     10   $strainAtFcr  $strainAtFc_conf  $rhoConcreteMaterial -damageCte1 $damageConstant_1 -damageCte2 $damageConstant_2;   # concrete boundary
nDMaterial OrthotropicRotatingAngleConcreteT2DMaterial01      23     11   $strainAtFcr  $strainAtFc       $rhoConcreteMaterial -damageCte1 $damageConstant_1 -damageCte2 $damageConstant_2;   # concrete web
# ----------------------------------------------------------------------------------------
# Define ReinforcedConcreteLayerMembraneSection01 section
# ----------------------------------------------------------------------------------------
set wallThickness 120;          # [mm]
set BeamThickness 400;          # [mm]

#section ReinforcedConcreteLayerMembraneSection01 $secTag $nSteelLayer $nConcLayer -reinfSteel{RSteelAtEachLayer} –conc{concAtEachLayer} -concThick{concThicknessesAtEachLayer} <-epscr $ecr> <-epsc $ec>
section ReinforcedConcreteLayerMembraneSection01 30 1 1 -reinfSteel 20 -conc 23 -concThick $wallThickness -epscr $strainAtFcr -epsc $strainAtFc;     # Wall boundary
section ReinforcedConcreteLayerMembraneSection01 31 1 1 -reinfSteel 22 -conc 23 -concThick $wallThickness -epscr $strainAtFcr -epsc $strainAtFc;     # Wall web
section ReinforcedConcreteLayerMembraneSection01 32 1 1 -reinfSteel 20 -conc 23 -concThick $BeamThickness -epscr $strainAtFcr -epsc $strainAtFc;     # Loading tranfer beam boundary
section ReinforcedConcreteLayerMembraneSection01 33 1 1 -reinfSteel 22 -conc 23 -concThick $BeamThickness -epscr $strainAtFcr -epsc $strainAtFc;     # Loading tranfer beam web