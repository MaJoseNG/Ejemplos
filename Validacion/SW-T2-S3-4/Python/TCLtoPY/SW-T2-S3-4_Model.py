import opensees as ops

ops.wipe('all')

# Source display procedures
ops.source('LibUnits.tcl')

# --------------------------------------------------------
# Start of model generation (Units: kgf, cm)
# --------------------------------------------------------
ops.set('dataDir','MEFISection_SW_T2_S3_4_Concrete02')

ops.file('mkdir','$dataDir;')

# Create ModelBuilder for 2D element (with two-dimensions and 3 DOF/node)
ops.model('BasicBuilder','-ndm',2,'-ndf','3;')

# --------------------------------------------
# Set geometry, nodes, boundary conditions
# --------------------------------------------
# Nodes 
# node $nodeTag (ndm $coords) <-mass (ndf $massValues)>
ops.node(1,0,'0;')
ops.node(2,75,'0;')
ops.node(3,150,'0;')
ops.node(4,0,'15;')
ops.node(5,75,'15;')
ops.node(6,150,'15;')
ops.node(7,0,'30;')
ops.node(8,75,'30;')
ops.node(9,150,'30;')
ops.node(10,0,'45;')
ops.node(11,75,'45;')
ops.node(12,150,'45;')
ops.node(13,0,'60;')
ops.node(14,75,'60;')
ops.node(15,150,'60;')
ops.node(16,0,'75;')
ops.node(17,75,'75;')
ops.node(18,150,'75;')
ops.node(19,0,'95;')
ops.node(20,75,'95;')
ops.node(21,150,'95;')
ops.node(22,0,'115;')
ops.node(23,75,'115;')
ops.node(24,150,'115;')


# ------------------------------
# Define propierties materials
# ------------------------------
# Steel propierties
ops.set('Fy','[expr','584.0*10.2];','#[MPa]*10.2','=','[kgf/cm2]')
ops.set('Fy_hw','[expr','584.0*10.2];','#[MPa]*10.2','=','[kgf/cm2]')
ops.set('Fy_vw','[expr','584.0*10.2];','#[MPa]*10.2','=','[kgf/cm2]')
ops.set('Fy_b','[expr','473.0*10.2];','#[MPa]*10.2','=','[kgf/cm2]')

ops.set('Es','[expr','200000.0*10.2];','#[MPa]*10.2','=','[kgf/cm2]')
ops.set('OrientationEmbeddedSteel','0.0;')
ops.set('R0','18.0;')
ops.set('CR1','0.9;')
ops.set('CR2','0.15;')
ops.set('a1','0.0;')
ops.set('a2','1.0;')
ops.set('a3','0.0;')
ops.set('a4','1.0;')
ops.set('b','0.02;','#','valor','momentaneo')

ops.set('strainAtFy','0.002;','#','no','se','debiera','requerir')

# Concrete propierties
#set Fc_Pedestal [expr -29.0*10.2];          #[MPa]*10.2 = [kgf/cm2]
#set Ec_Pedestal [expr 31000.0*10.2];        #[MPa]*10.2 = [kgf/cm2]

ops.set('magnitudGSelfWeightLoad','980.0;','#','[cm/s^2]')
ops.set('rhoConcreteMaterial','[expr','2500.0*(10**(-6))/$magnitudGSelfWeightLoad];')

ops.set('damageConstantUnconf_1','0.15;')
ops.set('damageConstantUnconf_2','0.5;')
ops.set('damageConstantConf_1','0.15;')
ops.set('damageConstantConf_2','0.5;')
# ======== Parametros adicionales para uso con Concrete06 ========
ops.set('AlphaC','0.32;')
ops.set('AlphaT','0.08;')
ops.set('AlphaC_Conf','0.32;')
ops.set('AlphaT_Conf','0.08;')
# ================================================================
ops.set('Fc','[expr','-29.0*10.2];','#[MPa]*10.2','=','[kgf/cm2]')
ops.set('Fcr','[expr','1.67*10.2];','#[MPa]*10.2','=','[kgf/cm2]')
ops.set('strainAtFcr','0.00008;')
ops.set('strainAtFc','-0.002;')
ops.set('strainAtFc_conf','-0.005;')

# ======== Parametros adicionales para uso con Concrete02 ========
ops.set('Et','[expr','0.1*$Fc/$strainAtFc];')
ops.set('Et_conf','[expr','0.1*$Fc/$strainAtFc_conf];')
ops.set('Fcu','[expr','0.09*$Fc];')
ops.set('strainAtFcu','-0.016;')
ops.set('lambda','0.05;')
# ================================================================

# ------------------------------
# Build materials and sections
# ------------------------------
########### Wall: Confined border ###############
ops.set('wallThickness','12.0;','#[cm]')

ops.set('rouXb','0.0067;','#','X','boundary')
ops.set('rouYb','0.0516;','#','Y','boundary')

# ======== Parametros adicionales para uso con Concrete06 ========
ops.set('K','0.75;')
ops.set('R','2.5;')
ops.set('BB','0.4;')
# ================================================================

# =========== CORRECCION ==========================
#set Bfactor1 [expr (1/$rouXb)*(($Fcr/$Fy_b)**(1.5))];
#set Bfactor2 [expr (1/$rouYb)*(($Fcr/$Fy_b)**(1.5))];

#set Fy_bWY [expr (0.93-2*$Bfactor1)*$Fy_b];
#set Fy_bWX [expr (0.93-2*$Bfactor2)*$Fy_b];
#set bY [expr 0.02+0.24*$Bfactor1];
#set bX [expr 0.02+0.24*$Bfactor2];

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
#uniaxialMaterial Steel02 2 $Fy_bWX $Es $bX $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel X
#uniaxialMaterial Steel02 3 $Fy_bWY $Es $bY $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel Y boundary
#==================================================

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
ops.uniaxialMaterial('Steel02',2,'$Fy_b','$Es','$b','$R0','$CR1','$CR2','$a1','$a2','$a3','$a4;','#','steel','X')
ops.uniaxialMaterial('Steel02',3,'$Fy_b','$Es','$b','$R0','$CR1','$CR2','$a1','$a2','$a3','$a4;','#','steel','Y','boundary')
# nDMaterial SmearedSteelDoubleLayerT2DMaterial01 $tag $s1 $s2 $ratioSteelLayer1 $ratioSteelLayer2 $OrientationEmbeddedSteel
ops.nDMaterial('SmearedSteelDoubleLayerT2DMaterial01',20,2,3,'$rouXb','$rouYb','$OrientationEmbeddedSteel;','#','steel','boundary')

# uniaxialMaterial Concrete02 $matTag       $fpc          $epsc0         $fpcu    $epsU     $lambda $ft  $Ets
ops.uniaxialMaterial('Concrete02',10,'[expr','0.75*$Fc]','$strainAtFc_conf','$Fcu','$strainAtFcu','$lambda','$Fcr','$Et_conf;','#','confined','concrete')

#uniaxialMaterial Concrete06 $matTag      $fc             $e0       $n $k    $alpha1   $fcr     $ecr     $b  $alpha2
#uniaxialMaterial Concrete06    10    [expr $K*$Fc] $strainAtFc_conf $R $K $AlphaC_Conf $Fcr $strainAtFcr $BB $AlphaT_Conf;
# nDMaterial OrthotropicRotatingAngleConcreteT2DMaterial01 $matTag $conc     $ecr             $ec              $ey            $rho
ops.nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01',21,10,'$strainAtFcr','$strainAtFc_conf','$strainAtFy','$rhoConcreteMaterial','-damageCte1','$damageConstantConf_1','-damageCte2','$damageConstantConf_2;','#','Boundary','(confined','concrete)')

##section ReinforcedConcreteLayerMembraneSection01 $secTag $nSteelLayer $nConcLayer -reinfSteel{RSteelAtEachLayer} –conc{concAtEachLayer} -concThick{concThicknessesAtEachLayer}
ops.section('ReinforcedConcreteLayerMembraneSection01',30,1,1,'-reinfSteel',20,'-conc',21,'-concThick','$wallThickness;','#','Wall','Boundary')


########### Wall: Unconfined center ###############
ops.set('rouXw','0.0067;','#','X','web')
ops.set('rouYw','0.0067;','#','Y','web')

# ======== Parametros adicionales para uso con Concrete06 ========
ops.set('K','0.75;')
ops.set('R','2.5;')
ops.set('BB','0.6;')
# ================================================================

# =========== CORRECCION ==========================
#set Bfactor1 [expr (1/$rouXw)*(($Fcr/$Fy_vw)**(1.5))];
#set Bfactor2 [expr (1/$rouYw)*(($Fcr/$Fy_hw)**(1.5))];

#set Fy_vwWY [expr (0.93-2*$Bfactor1)*$Fy_vw];
#set Fy_hwWX [expr (0.93-2*$Bfactor2)*$Fy_hw];
#set bY [expr 0.02+0.24*$Bfactor1];
#set bX [expr 0.02+0.24*$Bfactor2];

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
#uniaxialMaterial Steel02 4 $Fy_vwWY $Es $bX $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel X
#uniaxialMaterial Steel02 5 $Fy_hwWX $Es $bY $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel Y boundary
#==================================================

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
ops.uniaxialMaterial('Steel02',4,'$Fy_vw','$Es','$b','$R0','$CR1','$CR2','$a1','$a2','$a3','$a4;','#','steel','X')
ops.uniaxialMaterial('Steel02',5,'$Fy_hw','$Es','$b','$R0','$CR1','$CR2','$a1','$a2','$a3','$a4;','#','steel','Y','web')
# nDMaterial SmearedSteelDoubleLayerT2DMaterial01 $tag $s1 $s2 $ratioSteelLayer1 $ratioSteelLayer2 $OrientationEmbeddedSteel
ops.nDMaterial('SmearedSteelDoubleLayerT2DMaterial01',22,4,5,'$rouXw','$rouYw','$OrientationEmbeddedSteel;')

# uniaxialMaterial Concrete02 $matTag        $fpc          $epsc0      $fpcu    $epsU     $lambda $ft  $Ets
ops.uniaxialMaterial('Concrete02',11,'[expr','0.75*$Fc]','$strainAtFc','$Fcu','$strainAtFcu','$lambda','$Fcr','$Et;','#','confined','concrete')

#uniaxialMaterial Concrete06 $matTag      $fc         $e0      $n $k $alpha1 $fcr     $ecr     $b  $alpha2
#uniaxialMaterial Concrete06    11    [expr $K*$Fc] $strainAtFc $R $K $AlphaC $Fcr $strainAtFcr $BB $AlphaT;
# nDMaterial OrthotropicRotatingAngleConcreteT2DMaterial01 $matTag $conc     $ecr          $ec            $ey            $rho
ops.nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01',23,11,'$strainAtFcr','$strainAtFc','$strainAtFy','$rhoConcreteMaterial','-damageCte1','$damageConstantUnconf_1','-damageCte2','$damageConstantUnconf_2;','#','Boundary','(confined','concrete)')

##section ReinforcedConcreteLayerMembraneSection01 $secTag $nSteelLayer $nConcLayer -reinfSteel{RSteelAtEachLayer} –conc{concAtEachLayer} -concThick{concThicknessesAtEachLayer}
ops.section('ReinforcedConcreteLayerMembraneSection01',31,1,1,'-reinfSteel',22,'-conc',23,'-concThick','$wallThickness;','#','Wall','Boundary')

########### Beam: Border ###############
ops.set('BeamThickness','40.0;','#[cm]')

ops.set('rouXb','[expr','0.0067*2];','#','X','boundary')
ops.set('rouYb','[expr','0.0516*2];','#','Y','boundary')

# ======== Parametros adicionales para uso con Concrete06 ========
ops.set('K','0.75;')
ops.set('R','2.4;')
ops.set('BB','0.6;')
# ================================================================
# =========== CORRECCION ==========================
#set Bfactor1 [expr (1/$rouXb)*(($Fcr/$Fy_b)**(1.5))];
#set Bfactor2 [expr (1/$rouYb)*(($Fcr/$Fy_b)**(1.5))];

#set Fy_bBY [expr (0.93-2*$Bfactor1)*$Fy_b];
#set Fy_bBX [expr (0.93-2*$Bfactor2)*$Fy_b];
#set bY [expr 0.02+0.24*$Bfactor1];
#set bX [expr 0.02+0.24*$Bfactor2];

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
#uniaxialMaterial Steel02 6 $Fy_bBX $Es $bX $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel X
#uniaxialMaterial Steel02 7 $Fy_bBY $Es $bY $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel Y boundary
#==================================================

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
ops.uniaxialMaterial('Steel02',6,'$Fy_b','$Es','$b','$R0','$CR1','$CR2','$a1','$a2','$a3','$a4;','#','steel','X')
ops.uniaxialMaterial('Steel02',7,'$Fy_b','$Es','$b','$R0','$CR1','$CR2','$a1','$a2','$a3','$a4;','#','steel','Y','web')
# nDMaterial SmearedSteelDoubleLayerT2DMaterial01 $tag $s1 $s2 $ratioSteelLayer1 $ratioSteelLayer2 $OrientationEmbeddedSteel
ops.nDMaterial('SmearedSteelDoubleLayerT2DMaterial01',24,6,7,'$rouXb','$rouYb','$OrientationEmbeddedSteel;')

# uniaxialMaterial Concrete02 $matTag       $fpc            $epsc0     $fpcu    $epsU     $lambda $ft  $Ets
ops.uniaxialMaterial('Concrete02',12,'[expr','0.75*$Fc]','$strainAtFc','$Fcu','$strainAtFcu','$lambda','$Fcr','$Et;','#','confined','concrete')

#uniaxialMaterial Concrete06 $matTag      $fc         $e0      $n $k $alpha1 $fcr     $ecr     $b  $alpha2
#uniaxialMaterial Concrete06    12    [expr $K*$Fc] $strainAtFc $R $K $AlphaC $Fcr $strainAtFcr $BB $AlphaT;
# nDMaterial OrthotropicRotatingAngleConcreteT2DMaterial01 $matTag $conc     $ecr          $ec            $ey            $rho
ops.nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01',25,12,'$strainAtFcr','$strainAtFc','$strainAtFy','$rhoConcreteMaterial','-damageCte1','$damageConstantUnconf_1','-damageCte2','$damageConstantUnconf_2;','#','Boundary','(confined','concrete)')

##section ReinforcedConcreteLayerMembraneSection01 $secTag $nSteelLayer $nConcLayer -reinfSteel{RSteelAtEachLayer} –conc{concAtEachLayer} -concThick{concThicknessesAtEachLayer}
ops.section('ReinforcedConcreteLayerMembraneSection01',32,1,1,'-reinfSteel',24,'-conc',25,'-concThick','$BeamThickness;','#','Wall','Boundary')

########### Beam: Center ###############
ops.set('rouXw','[expr','0.0067*2];','#','X','web')
ops.set('rouYw','[expr','0.0067*2];','#','Y','web')

# ======== Parametros adicionales para uso con Concrete06 ========
ops.set('K','0.75;')
ops.set('R','2.5;')
ops.set('BB','0.6;')
# ================================================================
# =========== CORRECCION ==========================
#set Bfactor1 [expr (1/$rouXw)*(($Fcr/$Fy_b)**(1.5))];
#set Bfactor2 [expr (1/$rouYw)*(($Fcr/$Fy_b)**(1.5))];

#set Fy_bBY [expr (0.93-2*$Bfactor1)*$Fy_b];
#set Fy_bBX [expr (0.93-2*$Bfactor2)*$Fy_b];
#set bY [expr 0.02+0.24*$Bfactor1];
#set bX [expr 0.02+0.24*$Bfactor2];

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
#uniaxialMaterial Steel02 8 $Fy_bBX $Es $bX $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel X
#uniaxialMaterial Steel02 9 $Fy_bBY $Es $bY $R0 $CR1 $CR2 $a1 $a2 $a3 $a4;  # steel Y boundary
#==================================================

#uniaxialMaterial Steel02 $matTag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>
ops.uniaxialMaterial('Steel02',8,'$Fy_b','$Es','$b','$R0','$CR1','$CR2','$a1','$a2','$a3','$a4;','#','steel','X')
ops.uniaxialMaterial('Steel02',9,'$Fy_b','$Es','$b','$R0','$CR1','$CR2','$a1','$a2','$a3','$a4;','#','steel','Y','web')
# nDMaterial SmearedSteelDoubleLayerT2DMaterial01 $tag $s1 $s2 $ratioSteelLayer1 $ratioSteelLayer2 $OrientationEmbeddedSteel
ops.nDMaterial('SmearedSteelDoubleLayerT2DMaterial01',26,8,9,'$rouXw','$rouYw','$OrientationEmbeddedSteel;')

# uniaxialMaterial Concrete02 $matTag       $fpc          $epsc0     $fpcu    $epsU     $lambda $ft  $Ets
ops.uniaxialMaterial('Concrete02',13,'[expr','0.75*$Fc]','$strainAtFc','$Fcu','$strainAtFcu','$lambda','$Fcr','$Et;','#','confined','concrete')

#uniaxialMaterial Concrete06 $matTag      $fc         $e0      $n $k $alpha1 $fcr     $ecr     $b  $alpha2
#uniaxialMaterial Concrete06    13    [expr $K*$Fc] $strainAtFc $R $K $AlphaC $Fcr $strainAtFcr $BB $AlphaT;
# nDMaterial OrthotropicRotatingAngleConcreteT2DMaterial01 $matTag $conc     $ecr          $ec            $ey            $rho
ops.nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01',27,13,'$strainAtFcr','$strainAtFc','$strainAtFy','$rhoConcreteMaterial','-damageCte1','$damageConstantUnconf_1','-damageCte2','$damageConstantUnconf_2;')

##section ReinforcedConcreteLayerMembraneSection01 $secTag $nSteelLayer $nConcLayer -reinfSteel{RSteelAtEachLayer} –conc{concAtEachLayer} -concThick{concThicknessesAtEachLayer}
ops.section('ReinforcedConcreteLayerMembraneSection01',33,1,1,'-reinfSteel',26,'-conc',27,'-concThick','$BeamThickness;','#','Wall','Boundary')

# -----------------------------
#  Define elements
# ------------------------------
ops.set('nFiber','4;')
ops.set('db','[expr','130.0/10];','#','[cm]','Ancho','de','fibra','del','elemento','de','borde')
ops.set('dw','[expr','206.66667/10];','#','[cm]','Ancho','de','fibra','del','elemento','central')
#set pwb [expr (300/10)/4];        # [cm] Ancho de fibra del elemento left y right (Pedestal)
#set tw $wallThickness;
#set tb $BeamThickness;

ops.element('MEFISection',1,1,2,5,4,'$nFiber','-width','$db','$dw','$dw','$dw','-section',30,31,31,'31;','#izq')
ops.element('MEFISection',2,2,3,6,5,'$nFiber','-width','$dw','$dw','$dw','$db','-section',31,31,31,'30;','#der')
ops.element('MEFISection',3,4,5,8,7,'$nFiber','-width','$db','$dw','$dw','$dw','-section',30,31,31,'31;')
ops.element('MEFISection',4,5,6,9,8,'$nFiber','-width','$dw','$dw','$dw','$db','-section',31,31,31,'30;','#der')
ops.element('MEFISection',5,7,8,11,10,'$nFiber','-width','$db','$dw','$dw','$dw','-section',30,31,31,'31;','#izq')
ops.element('MEFISection',6,8,9,12,11,'$nFiber','-width','$dw','$dw','$dw','$db','-section',31,31,31,'30;','#der')
ops.element('MEFISection',7,10,11,14,13,'$nFiber','-width','$db','$dw','$dw','$dw','-section',30,31,31,'31;','#izq')
ops.element('MEFISection',8,11,12,15,14,'$nFiber','-width','$dw','$dw','$dw','$db','-section',31,31,31,'30;','#der')
ops.element('MEFISection',9,13,14,17,16,'$nFiber','-width','$db','$dw','$dw','$dw','-section',30,31,31,'31;','#izq')
ops.element('MEFISection',10,14,15,18,17,'$nFiber','-width','$dw','$dw','$dw','$db','-section',31,31,31,'30;','#der')
ops.element('MEFISection',11,16,17,20,19,'$nFiber','-width','$db','$dw','$dw','$dw','-section',32,33,33,'33;','#izq')
ops.element('MEFISection',12,17,18,21,20,'$nFiber','-width','$dw','$dw','$dw','$db','-section',33,33,33,'32;','#der')
ops.element('MEFISection',13,19,20,23,22,'$nFiber','-width','$db','$dw','$dw','$dw','-section',32,33,33,'33;','#izq')
ops.element('MEFISection',14,20,21,24,23,'$nFiber','-width','$dw','$dw','$dw','$db','-section',33,33,33,'32;','#der')

# Restraint Fixes
# fix $nodeTag (ndf $constrValues)
ops.fix(1,1,1,'1;')
ops.fix(2,1,1,'1;')
ops.fix(3,1,1,'1;')

#fix 22 0 0 1;
#fix 23 0 0 1;
#fix 24 0 0 1;

# Node Restraints 
#equalDOF $masterNodeTag $slaveNodeTag $dof1 $dof2 ...
ops.equalDOF(16,17,'1;')
ops.equalDOF(16,18,'1;')
ops.equalDOF(19,20,'1;')
ops.equalDOF(19,21,'1;')
ops.equalDOF(22,23,'1;')
ops.equalDOF(22,24,'1;')

# ------------------------------
#  Define recorders
# ------------------------------
ops.source('Recorders_SWT2S34.tcl')

ops.puts('"MODEL','GENERATED','successfully."')


