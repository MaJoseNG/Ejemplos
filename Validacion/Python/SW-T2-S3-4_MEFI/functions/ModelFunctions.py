# ----------------------------------------------------
# Example: Simulation of shear-controlled wall cyclic behavior using MEFI and MEFISection
# Specimen: SW-T2-S3-4 (Terzioglu etal.2018)
# Adapted by: Maria Jose Nunez G., MSc.(c) (maria.nunez.g@ug.uchile.cl)
# Date: 7/2023
# ----------------------------------------------------
import opensees as ops

# Units: cm, kgf

# Create ModelBuilder for 2D element (with two-dimensions and 3 DOF/node)
ops.model("Basic","-ndm", 2,"-ndf", 3)

def Nodes():
    # Nodes -------------------------------------------------------------------
    ops.node(1, *[0,   0  ])
    ops.node(2, *[75,  0  ])
    ops.node(3, *[150, 0  ])
    ops.node(4, *[0,   15 ])
    ops.node(5, *[75,  15 ])
    ops.node(6, *[150, 15 ])
    ops.node(7, *[0,   30 ])
    ops.node(8, *[75,  30 ])
    ops.node(9, *[150, 30 ])
    ops.node(10,*[0,  45 ])
    ops.node(11,*[75, 45 ])
    ops.node(12,*[150,45 ])
    ops.node(13,*[0,  60 ])
    ops.node(14,*[75, 60 ])
    ops.node(15,*[150,60 ])
    ops.node(16,*[0,  75 ])
    ops.node(17,*[75, 75 ])
    ops.node(18,*[150,75 ])
    ops.node(19,*[0,  95 ])
    ops.node(20,*[75, 95 ])
    ops.node(21,*[150,95 ])
    ops.node(22,*[0,  115])
    ops.node(23,*[75, 115])
    ops.node(24,*[150,115])
    
    # Restraint Fixes ---------------------------------------------------------
    ops.fix(1,*[1,1,1])
    ops.fix(2,*[1,1,1])
    ops.fix(3,*[1,1,1])

    #fix 22 0 0 1;
    #fix 23 0 0 1;
    #fix 24 0 0 1;

    # Node Restraints --------------------------------------------------------- 
    ops.equalDOF(16,17,1)
    ops.equalDOF(16,18,1)
    ops.equalDOF(19,20,1)
    ops.equalDOF(19,21,1)
    ops.equalDOF(22,23,1)
    ops.equalDOF(22,24,1)

def NodesFSAM():
    # Nodes -------------------------------------------------------------------
    ops.node(1, *[0, 0])
    ops.node(2, *[75, 0])
    ops.node(3, *[150, 0])
    ops.node(4, *[0, 24])
    ops.node(5, *[75, 24])
    ops.node(6, *[150, 24])
    ops.node(7, *[0, 36.75])
    ops.node(8, *[75, 36.75])
    ops.node(9, *[150, 36.75])
    ops.node(10, *[0, 49.5])
    ops.node(11, *[75, 49.5])
    ops.node(12, *[150, 49.5])
    ops.node(13, *[0, 62.25])
    ops.node(14, *[75, 62.25])
    ops.node(15, *[150, 62.25])
    ops.node(16, *[0, 75])
    ops.node(17, *[75, 75])
    ops.node(18, *[150, 75])
    ops.node(19, *[0, 95])
    ops.node(20, *[75, 95])
    ops.node(21, *[150, 95])
    ops.node(22, *[0, 115])
    ops.node(23, *[75, 115])
    ops.node(24, *[150, 115])

    # Restraint Fixes ---------------------------------------------------------
    ops.fix(1, *[1, 1, 1])
    ops.fix(2, *[1, 1, 1])
    ops.fix(3, *[1, 1, 1])

    # fix 22 0 0 1;
    # fix 23 0 0 1;
    # fix 24 0 0 1;

    # Node Restraints ---------------------------------------------------------
    ops.equalDOF(16, 17, 1)
    ops.equalDOF(16, 18, 1)
    ops.equalDOF(19, 20, 1)
    ops.equalDOF(19, 21, 1)
    ops.equalDOF(22, 23, 1)
    ops.equalDOF(22, 24, 1)

def UniaxialMat_Steel02():
    # Steel propierties
    Fy    = 584.0*10.2              #[MPa]*10.2 = [kgf/cm2]
    Fy_hw = 584.0*10.2              #[MPa]*10.2 = [kgf/cm2]
    Fy_vw = 584.0*10.2              #[MPa]*10.2 = [kgf/cm2]
    Fy_b  = 473.0*10.2              #[MPa]*10.2 = [kgf/cm2]

    Es  = 200000.0*10.2
    OrientationEmbeddedSteel = 0.0
    R0  = 18.0
    CR1 = 0.9
    CR2 = 0.15
    a1  = 0.0
    a2  = 1.0
    a3  = 0.0
    a4  = 1.0
    b   = 0.02

    ################# Wall: Confined border #################
    ops.uniaxialMaterial('Steel02', 2, Fy_b, Es, b, R0, CR1, CR2, a1, a2, a3, a4)  # steel X
    ops.uniaxialMaterial('Steel02', 3, Fy_b, Es, b, R0, CR1, CR2, a1, a2, a3, a4)  # steel Y boundary

    ################ Wall: Unconfined center ################
    ops.uniaxialMaterial('Steel02', 4, Fy_vw, Es, b, R0, CR1, CR2, a1, a2, a3, a4)  # steel X      
    ops.uniaxialMaterial('Steel02', 5, Fy_hw, Es, b, R0, CR1, CR2, a1, a2, a3, a4)  # steel Y web
    
    ################# Beam: Border ##########################
    ops.uniaxialMaterial('Steel02', 6, Fy_b, Es, b, R0, CR1, CR2, a1, a2, a3, a4)   # steel X
    ops.uniaxialMaterial('Steel02', 7, Fy_b, Es, b, R0, CR1, CR2, a1, a2, a3, a4)   # steel Y boundary
    
    ################# Beam: Center ##########################
    ops.uniaxialMaterial('Steel02', 8, Fy_b, Es, b, R0, CR1, CR2, a1, a2, a3, a4)   # steel X
    ops.uniaxialMaterial('Steel02', 9, Fy_b, Es, b, R0, CR1, CR2, a1, a2, a3, a4)   # steel Y web
    
def UniaxialMat_Concrete02():   
    # Concrete propierties
    Fc              = -29.0*10.2        #[MPa]*10.2 = [kgf/cm2]
    Fcr             = 1.67*10.2         #[MPa]*10.2 = [kgf/cm2]
    #strainAtFcr     = 0.00008
    strainAtFc      = -0.002
    strainAtFc_conf = -0.005

    # ======== Additional propierties for Concrete02 ========
    Et          = 0.1*Fc/strainAtFc
    Et_conf     = 0.1*Fc/strainAtFc_conf
    Fcu         = 0.09*Fc
    strainAtFcu = -0.016
    lamb        = 0.05
    # =======================================================
    
    ops.uniaxialMaterial('Concrete02', 10, 0.75*Fc, strainAtFc_conf, Fcu, strainAtFcu, lamb, Fcr, Et_conf)  # Wall: Confined border
    ops.uniaxialMaterial('Concrete02', 11, 0.75*Fc, strainAtFc, Fcu, strainAtFcu, lamb, Fcr, Et)            # Wall: Unconfined center
    ops.uniaxialMaterial('Concrete02', 12, 0.75*Fc, strainAtFc, Fcu, strainAtFcu, lamb, Fcr, Et)            # Beam: Border
    ops.uniaxialMaterial('Concrete02', 13, 0.75*Fc, strainAtFc, Fcu, strainAtFcu, lamb, Fcr, Et)            # Beam: Center

def UniaxialMat_Concrete06():
    # Concrete propierties
    Fc              = -29.0*10.2        #[MPa]*10.2 = [kgf/cm2]
    Fcr             = 1.67*10.2         #[MPa]*10.2 = [kgf/cm2]
    strainAtFcr     = 0.00008
    strainAtFc      = -0.002
    strainAtFc_conf = -0.005
    
    # ======== Additional propierties for Concrete06 ========
    AlphaC = 0.32
    AlphaT = 0.08
    AlphaC_Conf = 0.32
    AlphaT_Conf = 0.08
    # =======================================================
    
    ################# Wall: Confined border #################
    K  = 0.75
    R  = 2.5
    BB = 0.4
    ops.uniaxialMaterial('Concrete06', 10, K*Fc, strainAtFc_conf, R, K, AlphaC_Conf, Fcr, strainAtFcr, BB, AlphaT_Conf)
    
    ################ Wall: Unconfined center ################
    K  = 0.75
    R  = 2.5
    BB = 0.6
    ops.uniaxialMaterial('Concrete06', 11, K*Fc, strainAtFc, R, K, AlphaC, Fcr, strainAtFcr, BB, AlphaT)
    
    ################# Beam: Border ##########################
    K  = 0.75
    R  = 2.4
    BB = 0.6
    ops.uniaxialMaterial('Concrete06', 12, K*Fc, strainAtFc, R, K, AlphaC, Fcr, strainAtFcr, BB, AlphaT)
    
    ################# Beam: Center ##########################
    K  = 0.75
    R  = 2.5
    BB = 0.6
    ops.uniaxialMaterial('Concrete06', 13, K*Fc, strainAtFc, R, K, AlphaC, Fcr, strainAtFcr, BB, AlphaT)
    
def materialsRCLayerMembraneSection():
    
    OrientationEmbeddedSteel = 0.0
    strainAtFy = 0.002              # no se debiera requerir  
    
    strainAtFcr     = 0.00008
    strainAtFc      = -0.002
    strainAtFc_conf = -0.005
    
    magnitudGSelfWeightLoad = 980.0            # [cm/s^2]
    rhoConcreteMaterial = 2500.0*(10**(-6))/magnitudGSelfWeightLoad

    damageConstantUnconf_1 = 0.15
    damageConstantUnconf_2 = 0.5
    damageConstantConf_1   = 0.15
    damageConstantConf_2   = 0.5
    
    ################# Wall: Confined border #################
    wallThickness = 12.0         #[cm]
    
    # Reinforcing ratios
    rouXb = 0.0067               # X boundary
    rouYb = 0.0516               # Y boundary
    
    ops.nDMaterial('SmearedSteelDoubleLayerT2DMaterial01',20,2,3,rouXb,rouYb,OrientationEmbeddedSteel)
    ops.nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01',21,10,strainAtFcr,strainAtFc_conf,strainAtFy,rhoConcreteMaterial,'-damageCte1',damageConstantConf_1,'-damageCte2',damageConstantConf_2)
    ops.section('ReinforcedConcreteLayerMembraneSection01',30,1,1,'-reinfSteel',20,'-conc',21,'-concThick',wallThickness)

    ################ Wall: Unconfined center ################
    rouXw = 0.0067               # X web
    rouYw = 0.0067               # Y web

    ops.nDMaterial('SmearedSteelDoubleLayerT2DMaterial01',22,4,5,rouXw,rouYw,OrientationEmbeddedSteel)
    ops.nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01',23,11,strainAtFcr,strainAtFc,strainAtFy,rhoConcreteMaterial,'-damageCte1',damageConstantUnconf_1,'-damageCte2',damageConstantUnconf_2)
    ops.section('ReinforcedConcreteLayerMembraneSection01',31,1,1,'-reinfSteel',22,'-conc',23,'-concThick',wallThickness)

    ################# Beam: Border ##########################
    BeamThickness = 40.0           #[cm]

    rouXb = 0.0067*2               # X boundary
    rouYb = 0.0516*2               # Y boundary
    
    ops.nDMaterial('SmearedSteelDoubleLayerT2DMaterial01',24,6,7,rouXb,rouYb,OrientationEmbeddedSteel)
    ops.nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01',25,12,strainAtFcr,strainAtFc,strainAtFy,rhoConcreteMaterial,'-damageCte1',damageConstantUnconf_1,'-damageCte2',damageConstantUnconf_2)
    ops.section('ReinforcedConcreteLayerMembraneSection01',32,1,1,'-reinfSteel',24,'-conc',25,'-concThick',BeamThickness)

    ################# Beam: Center ##########################
    rouXw = 0.0067*2               # X web
    rouYw = 0.0067*2               # Y web

    ops.nDMaterial('SmearedSteelDoubleLayerT2DMaterial01',26,8,9,rouXw,rouYw,OrientationEmbeddedSteel)
    ops.nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01',27,13,strainAtFcr,strainAtFc,strainAtFy,rhoConcreteMaterial,'-damageCte1',damageConstantUnconf_1,'-damageCte2',damageConstantUnconf_2)
    ops.section('ReinforcedConcreteLayerMembraneSection01',33,1,1,'-reinfSteel',26,'-conc',27,'-concThick',BeamThickness)


def materialsFSAM():
    
    magnitudGSelfWeightLoad = 980.0             # [cm/s^2]
    rhoConcreteMaterial = 2500.0*(10**(-6))/magnitudGSelfWeightLoad
    
    nu = 0.35                                   # friction coefficient
    alfadow = 0.005                             # dowel action stiffness parameter
    #alfadow = 0.0001                             # dowel action stiffness parameter

    ################# Wall: Confined border #################
    # Reinforcing ratios
    rouXb = 0.0067               # X boundary
    rouYb = 0.0516               # Y boundary
    
    #nDMaterial('FSAM', matTag, rho, sXTag, sYTag, concTag, rouX, rouY, nu, alfadow)
    ops.nDMaterial('FSAM', 30, rhoConcreteMaterial, 2, 3, 10, rouXb, rouYb, nu, alfadow) 

    ################ Wall: Unconfined center ################
    rouXw = 0.0067               # X web
    rouYw = 0.0067               # Y web
    
    ops.nDMaterial('FSAM', 31, rhoConcreteMaterial, 4, 5, 11, rouXw, rouYw, nu, alfadow)
    
    ################# Beam: Border ##########################
    rouXb = 0.0067*2               # X boundary
    rouYb = 0.0516*2               # Y boundary

    ops.nDMaterial('FSAM', 32, rhoConcreteMaterial, 6, 7, 12, rouXb, rouYb, nu, alfadow)
    
    ################# Beam: Center ##########################
    rouXw = 0.0067*2               # X web
    rouYw = 0.0067*2               # Y web

    ops.nDMaterial('FSAM', 33, rhoConcreteMaterial, 8, 9, 13, rouXw, rouYw, nu, alfadow) 


def areaElements_MEFISection():
    nFiber = 4
    db = 130.0/10                   # [cm] Ancho de fibra del elemento de borde
    dw = 206.66667/10               # [cm] Ancho de fibra del elemento central

    ops.element('MEFISection',1,1,2,5,4,nFiber,'-width',db,dw,dw,dw,'-section',30,31,31,31)
    ops.element('MEFISection',2,2,3,6,5,nFiber,'-width',dw,dw,dw,db,'-section',31,31,31,30)
    ops.element('MEFISection',3,4,5,8,7,nFiber,'-width',db,dw,dw,dw,'-section',30,31,31,31)
    ops.element('MEFISection',4,5,6,9,8,nFiber,'-width',dw,dw,dw,db,'-section',31,31,31,30)
    ops.element('MEFISection',5,7,8,11,10,nFiber,'-width',db,dw,dw,dw,'-section',30,31,31,31)
    ops.element('MEFISection',6,8,9,12,11,nFiber,'-width',dw,dw,dw,db,'-section',31,31,31,30)
    ops.element('MEFISection',7,10,11,14,13,nFiber,'-width',db,dw,dw,dw,'-section',30,31,31,31)
    ops.element('MEFISection',8,11,12,15,14,nFiber,'-width',dw,dw,dw,db,'-section',31,31,31,30)
    ops.element('MEFISection',9,13,14,17,16,nFiber,'-width',db,dw,dw,dw,'-section',30,31,31,31)
    ops.element('MEFISection',10,14,15,18,17,nFiber,'-width',dw,dw,dw,db,'-section',31,31,31,30)
    ops.element('MEFISection',11,16,17,20,19,nFiber,'-width',db,dw,dw,dw,'-section',32,33,33,33)
    ops.element('MEFISection',12,17,18,21,20,nFiber,'-width',dw,dw,dw,db,'-section',33,33,33,32)
    ops.element('MEFISection',13,19,20,23,22,nFiber,'-width',db,dw,dw,dw,'-section',32,33,33,33)
    ops.element('MEFISection',14,20,21,24,23,nFiber,'-width',dw,dw,dw,db,'-section',33,33,33,32)

def areaElements_MEFI():
    wallThickness = 12.0            #[cm]
    BeamThickness = 40.0            #[cm]
    
    nFiber = 4
    db = 130.0/10           # [cm] Ancho de fibra del elemento de borde
    dw = 206.66667/10       # [cm] Ancho de fibra del elemento central
    tw = wallThickness
    tb = BeamThickness

    ops.element('MEFI',1,1,2,5,4,nFiber,'-thick',tw,tw,tw,tw,'-width',db,dw,dw,dw,'-mat',30,31,31,31)
    ops.element('MEFI',2,2,3,6,5,nFiber,'-thick',tw,tw,tw,tw,'-width',dw,dw,dw,db,'-mat',31,31,31,30)
    ops.element('MEFI',3,4,5,8,7,nFiber,'-thick',tw,tw,tw,tw,'-width',db,dw,dw,dw,'-mat',30,31,31,31)
    ops.element('MEFI',4,5,6,9,8,nFiber,'-thick',tw,tw,tw,tw,'-width',dw,dw,dw,db,'-mat',31,31,31,30)
    ops.element('MEFI',5,7,8,11,10,nFiber,'-thick',tw,tw,tw,tw,'-width',db,dw,dw,dw,'-mat',30,31,31,31)
    ops.element('MEFI',6,8,9,12,11,nFiber,'-thick',tw,tw,tw,tw,'-width',dw,dw,dw,db,'-mat',31,31,31,30)
    ops.element('MEFI',7,10,11,14,13,nFiber,'-thick',tw,tw,tw,tw,'-width',db,dw,dw,dw,'-mat',30,31,31,31)
    ops.element('MEFI',8,11,12,15,14,nFiber,'-thick',tw,tw,tw,tw,'-width',dw,dw,dw,db,'-mat',31,31,31,30)
    ops.element('MEFI',9,13,14,17,16,nFiber,'-thick',tw,tw,tw,tw,'-width',db,dw,dw,dw,'-mat',30,31,31,31)
    ops.element('MEFI',10,14,15,18,17,nFiber,'-thick',tw,tw,tw,tw,'-width',dw,dw,dw,db,'-mat',31,31,31,30)
    ops.element('MEFI',11,16,17,20,19,nFiber,'-thick',tb,tb,tb,tb,'-width',db,dw,dw,dw,'-mat',32,33,33,33)
    ops.element('MEFI',12,17,18,21,20,nFiber,'-thick',tb,tb,tb,tb,'-width',dw,dw,dw,db,'-mat',33,33,33,32)
    ops.element('MEFI',13,19,20,23,22,nFiber,'-thick',tb,tb,tb,tb,'-width',db,dw,dw,dw,'-mat',32,33,33,33)
    ops.element('MEFI',14,20,21,24,23,nFiber,'-thick',tb,tb,tb,tb,'-width',dw,dw,dw,db,'-mat',33,33,33,32)


    
    
    
    