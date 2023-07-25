# ----------------------------------------------------------------------------------------
# Define and build steel material
# ----------------------------------------------------------------------------------------

# steel X
set fyX [expr 469.93*$MPa];        # fy
set bx 0.02;                       # strain hardening

# steel Y web
set fyYw [expr 409.71*$MPa];       # fy
set byw 0.02;                      # strain hardening

# steel Y boundary
set fyYb [expr 429.78*$MPa];       # fy
set byb 0.01;                      # strain hardening

# steel misc
set Esy [expr 200000.0*$MPa];      # Young's modulus
set Esx $Esy;                      # Young's modulus
set R0 20.0;                       # initial value of curvature parameter
set A1 0.925;                      # curvature degradation parameter
set A2 0.15;                       # curvature degradation parameter
  
# Build steel materials
uniaxialMaterial  Steel02  1 $fyX  $Esx $bx  $R0 $A1 $A2; # steel X
uniaxialMaterial  Steel02  2 $fyYw $Esy $byw $R0 $A1 $A2; # steel Y web
uniaxialMaterial  Steel02  3 $fyYb $Esy $byb $R0 $A1 $A2; # steel Y boundary

# ----------------------------------------------------------------------------------------
# Define and build concrete material
# ----------------------------------------------------------------------------------------

# unconfined
set fpc [expr -47.09*$MPa];                          # peak compressive stress
set ec0 [expr -0.00232];                             # strain at peak compressive stress
set ft [expr 2.13*$MPa];                             # peak tensile stress
set et [expr 0.00008];                               # strain at peak tensile stress 
set Ec [expr 34766.59*$MPa];                         # Young's modulus     

# confined
set fpcc [expr -53.78*$MPa];                         # peak compressive stress
set ec0c [expr -0.00397];                            # strain at peak compressive stress
set Ecc [expr 36542.37*$MPa];                        # Young's modulus

# Build concrete materials
uniaxialMaterial Concrete02 4 $fpc $ec0 [expr 0.0*$fpc] -0.037 0.1 $ft [expr 0.05*$Ec]; # unconfined concrete
uniaxialMaterial Concrete02 5 $fpcc $ec0c [expr 0.2*$fpc] -0.047 0.1 $ft [expr 0.05*$Ecc]; # confined concrete

# ----------------------------------------------------------------------------------------
# Reinforcing ratios
# ----------------------------------------------------------------------------------------
 
set rouXw 0.0027;   # X web 
set rouXb 0.0082;   # X boundary 
set rouYw 0.0027;   # Y web
set rouYb 0.0323;   # Y boundary
# =================================== FSAM ===============================================
# ----------------------------------------------------------------------------------------
# Shear resisting mechanism parameters
# ----------------------------------------------------------------------------------------

set nu 0.35;                # friction coefficient
set alfadow [expr 0.005];   # dowel action stiffness parameter

# ----------------------------------------------------------------------------------------
# Define FSAM nDMaterial
# ----------------------------------------------------------------------------------------

nDMaterial FSAM 6  0.0  1   2   4  $rouXw $rouYw  $nu  $alfadow; # Web (unconfined concrete)
nDMaterial FSAM 7  0.0  1   3   5  $rouXb $rouYb  $nu  $alfadow; # Boundary (confined concrete)
# ================================= FIN FSAM =============================================

# ================================= NUEVAS CLASES ========================================

#set er [expr -0.037];                                # concrete strain at crushing strength
#set erc [expr -0.047];                               # concrete strain at crushing strength
#set strainAtFtu [expr 0.00008];                      # concrete strain at tension cracking
#set strainAtFy [expr 0.002];                         # strain at the tension yielding of the steel
## ----------------------------------------------------------------------------------------
## Define OrthotropicRotatingAngleConcreteT2DMaterial01 nDMaterial
## ----------------------------------------------------------------------------------------
## nDMaterial OrthotropicRotatingAngleConcreteT2DMaterial01 $matTag $conc     $ecr       $ec      $ey       $rho
#nDMaterial OrthotropicRotatingAngleConcreteT2DMaterial01      6       4   $strainAtFtu  $ec0   $strainAtFy   0.0;   # unconfined concrete
#nDMaterial OrthotropicRotatingAngleConcreteT2DMaterial01      7       5   $strainAtFtu  $ec0c  $strainAtFy   0.0;   # confined concrete
## ----------------------------------------------------------------------------------------
## Define SmearedSteelDoubleLayerT2DMaterial01 nDMaterial
## ----------------------------------------------------------------------------------------
## nDMaterial SmearedSteelDoubleLayerT2DMaterial01 $tag $s1 $s2 $ratioSteelLayer1 $ratioSteelLayer2 $OrientationEmbeddedSteel
#nDMaterial SmearedSteelDoubleLayerT2DMaterial01     8   1   2      $rouXw            $rouYw                 0.0;    # steel web
#nDMaterial SmearedSteelDoubleLayerT2DMaterial01     9   1   3      $rouXb            $rouYb                 0.0;    # steel boundary
## ----------------------------------------------------------------------------------------
## Define ReinforcedConcreteLayerMembraneSection01 section
## ----------------------------------------------------------------------------------------
#set tw   [expr 152.4*$mm];    # Wall thickness
#set tb   [expr 304.8*$mm];    # Loading tranfer beam thickness
#set tnc  [expr 81.0*$mm];     # unconfined concrete wall layer thickness
#set tc   [expr 71.4*$mm];     # confined concrete wall layer thickness   
#set tncv [expr 233.4*$mm];    # unconfined concrete loading tranfer beam layer thickness
#set tcv  [expr 71.4*$mm];     # confined concrete loading tranfer bream layer thickness
#
##section ReinforcedConcreteLayerMembraneSection01 $secTag $nSteelLayer $nConcLayer -reinfSteel{RSteelAtEachLayer} –conc{concAtEachLayer} -concThick{concThicknessesAtEachLayer}
#section ReinforcedConcreteLayerMembraneSection01 10 1 1 -reinfSteel 8   -conc 6   -concThick $tw;          # Wall Web
#section ReinforcedConcreteLayerMembraneSection01 11 1 2 -reinfSteel 9   -conc 6 7 -concThick $tnc $tc;     # Wall Boundary
#section ReinforcedConcreteLayerMembraneSection01 12 1 1 -reinfSteel 8   -conc 6   -concThick $tb;          # Loading tranfer beam web
#section ReinforcedConcreteLayerMembraneSection01 13 1 2 -reinfSteel 9   -conc 6 7 -concThick $tncv $tcv;   # Loading tranfer beam boundary   
# ================================== FIN NUEVAS CLASES =====================================