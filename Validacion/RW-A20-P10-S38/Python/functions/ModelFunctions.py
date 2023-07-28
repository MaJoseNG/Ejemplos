# ----------------------------------------------------
# Example: Simulation of wall cyclic behavior using MEFISection
# Specimen: RW-A20-P10-S38 (Tran and Wallace, 2012)
# Adapted by: Maria Jose Nunez G., MSc.(c) (maria.nunez.g@ug.uchile.cl)
# Date: 6/2023
# ----------------------------------------------------
import opensees as ops
import numpy as np

# =============================================================================
# UNITS
# =============================================================================
mm = 1.
N = 1.
sec = 1.

# Define engineering units
mm2 = mm*mm
MPa = N/mm2
kN = 1000*N

# Create ModelBuilder for 2D element (with two-dimensions and 3 DOF/node)
ops.model("Basic","-ndm", 2,"-ndf", 3)

def Nodes():
    # Nodes --------------------------------------------------
    #   node(nodeTag, *crds, '-ndf', ndf, '-mass', *mass, '-disp', *disp, '-vel', *vel, '-accel', *accel)
    ops.node(1, *[0,    0      ])
    ops.node(2, *[1220, 0      ])
    ops.node(3, *[0,    315.69 ])
    ops.node(4, *[1220, 315.69 ])
    ops.node(5, *[0,    631.37 ])
    ops.node(6, *[1220, 631.37 ])
    ops.node(7, *[0,    947.06 ])
    ops.node(8, *[1220, 947.06 ])
    ops.node(9, *[0,    1262.74])
    ops.node(10,*[1220, 1262.74])
    ops.node(11,*[0,    1578.43])
    ops.node(12,*[1220, 1578.43])
    ops.node(13,*[0,    1894.11])
    ops.node(14,*[1220, 1894.11])
    ops.node(15,*[0,    2209.8 ])
    ops.node(16,*[1220, 2209.8 ])
    ops.node(17,*[0,    2438.4 ])
    ops.node(18,*[1220, 2438.4 ])
    ops.node(19,*[0,    2667   ])
    ops.node(20,*[1220, 2667   ])

    # Restraint Fixes -------------------------
    #   fix(nodeTag, *constrValues)
    ops.fix(1, *[1,1,1])
    ops.fix(2, *[1,1,1])
    ops.fix(19,*[0,0,1])
    ops.fix(20,*[0,0,1])

    # Node Restraints --------------------------------------------------------------------------------------------------------------
    #   equalDOF(rNodeTag, cNodeTag, *dofs)
    ops.equalDOF(15,16,1)
    ops.equalDOF(17,18,1)
    ops.equalDOF(19,20,1)

def UniaxialMat_Steel02():
    # Propierties steel material ----------------------------------------------------------
    # steel x
    fyX = 469.93 * MPa  # fy
    bx = 0.02/2  # strain hardening

    # steel Y web
    fyYw = 409.71 * MPa  # fy
    byw = 0.02/2  # strain hardening

    # steel Y boundary
    fyYb = 429.78 * MPa  # fy
    byb = 0.01/2  # strain hardening

    # steel misc
    Esy = 200000.0 * MPa  # Young's modulus
    Esx = Esy  # Young's modulus
    R0 = 20.0  # initial value of curvature parameter
    A1 = 0.925  # curvature degradation parameter
    A2 = 0.15  # curvature degradation parameter
    ey = 0.002  # strain at the tension yielding of the steel

    # Build steel materials
    # uniaxialMaterial('Steel02', matTag, Fy, E0, b, *params, a1=a2*Fy/E0, a2=1.0, a3=a4*Fy/E0, a4=1.0, sigInit=0.0)
    ops.uniaxialMaterial('Steel02', 1, fyX, Esx, bx, R0, A1, A2)  # steel X
    ops.uniaxialMaterial('Steel02', 2, fyYw, Esy, byw, R0, A1, A2)  # steel Y web
    ops.uniaxialMaterial('Steel02', 3, fyYb, Esy, byb, R0, A1, A2)  # steel Y boundary

def UniaxialMat_Concrete02():
    # Propierties concrete material -------------------------------------------------------
    # *************************************************************************
    # fr = 0.0*fpc                       # concrete crushing strength
    # frc = 0.2*fpcc                     # concrete crushing strength
    # er = -0.037                        # concrete strain at crushing strength
    # erc = -0.047                       # concrete strain at crushing strength
    # lamb = 0.1                         # ratio between unloading slope and initial slope
    # Ets = 0.05*Ec                      # tension softening stiffness
    # Etsc = 0.05*Ecc                    # tension softening stiffness

    # Build de concrete materials
    #   uniaxialMaterial('Concrete02', matTag, fpc, epsc0, fpcu, epsU, lambda, ft, Ets)
    # ops.uniaxialMaterial('Concrete02',   4,    fpc,  ec0,   fr,   er,   lamb,  ft, Ets)          # unconfined concrete
    # ops.uniaxialMaterial('Concrete02',   5,   fpcc,  ec0c,  frc,  erc,  lamb,  ft, Etsc)     # confined concrete
    # **************************************************************************
    # unconfined
    fpc = -47.09 * MPa  # peak compressive stress
    ec0 = -0.00232  # strain at peak compressive stress
    ft = 2.13 * MPa  # peak tensile stress
    et = 0.00008  # strain at peak tensile stress
    Ec = 34766.59 * MPa  # Young's modulus

    # confined
    fpcc = -53.78 * MPa  # peak compressive stress
    ec0c = -0.00397  # strain at peak compressive stress
    Ecc = 36542.37 * MPa  # Young's modulus

    # Build concrete materials
    #   uniaxialMaterial('Concrete02', matTag, fpc, epsc0,  fpcu,    epsU, lambda, ft, Ets)
    ops.uniaxialMaterial('Concrete02', 4, fpc, ec0, 0.0 * fpc, -0.037, 0.1, ft, 0.05 * Ec)  # unconfined concrete
    ops.uniaxialMaterial('Concrete02', 5, fpcc, ec0c, 0.2 * fpc, -0.047, 0.1, ft, 0.05 * Ecc)  # confined concrete

def UniaxialMat_Concrete06():
    # unconfined
    fpc = -47.09 * MPa  # peak compressive stress
    ec0 = -0.00232  # strain at peak compressive stress
    ft = 2.13 * MPa  # peak tensile stress
    et = 0.00008  # strain at peak tensile stress
    # confined
    fpcc = -53.78 * MPa  # peak compressive stress
    ec0c = -0.00397  # strain at peak compressive stress

    n = 2.5
    k = 0.75
    AlphaC = 0.32
    AlphaT = 0.08
    B = 0.4

    # Build concrete materials
    #   uniaxialMaterial('Concrete06', matTag, fc, e0, n, k, alpha1, fcr, ecr, b, alpha2)
    ops.uniaxialMaterial('Concrete06', 4, fpc, ec0, n, k, AlphaC, ft, et, B, AlphaT)  # unconfined concrete
    ops.uniaxialMaterial('Concrete06', 5, fpcc, ec0c, n, k, AlphaC, ft, et, B, AlphaT)  # confined concrete

def materialsFSAM():
    # Reinforcing ratios
    rouXw = 0.0027         # X web 
    rouXb = 0.0082         # X boundary 
    rouYw = 0.0027         # Y web
    rouYb = 0.0323         # Y boundary
    
    # Shear resisting mechanism parameters ------------------------------------
    nu = 0.35                           # friction coefficient
    alfadow = 0.005                     # dowel action stiffness parameter
                         
    # Define FSAM nDMaterial --------------------------------------------------
    #   nDMaterial('FSAM', matTag, rho, sXTag, sYTag, concTag, rouX, rouY,  nu, alfadow)
    ops.nDMaterial('FSAM',   6  ,  0.0,   1,     2,      4,   rouXw, rouYw, nu, alfadow)           # Web (unconfined concrete)
    ops.nDMaterial('FSAM',   7  ,  0.0,   1,     3,      5,   rouXb, rouYb, nu, alfadow)           # Boundary (confined concrete)

def materialsRCLayerMembraneSection():

    ec0 = -0.00232  # strain at peak compressive stress
    ec0c = -0.00397  # strain at peak compressive stress
    et = 0.00008  # strain at peak tensile stress

    # Reinforcing ratios
    rouXw = 0.0027         # X web 
    rouXb = 0.0082         # X boundary 
    rouYw = 0.0027         # Y web
    rouYb = 0.0323         # Y boundary
    
    # Build Orthotropic Rotating Angle Concrete 2D
    #   nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01', matTag, conc,   ec,     ec,     rho)
    ops.nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01',   6,     4, et, ec0, 0.0)          # unconfined concrete
    ops.nDMaterial('OrthotropicRotatingAngleConcreteT2DMaterial01',   7,     5, et, ec0c, 0.0)          # confined concrete

    # Build Smeared Steel materials
    #   nDMaterial('SmearedSteelDoubleLayerT2DMaterial01', tag, s1, s2, ratioSteelLayer1, ratioSteelLayer2, OrientationEmbeddedSteel)
    ops.nDMaterial('SmearedSteelDoubleLayerT2DMaterial01',  8,  1,  2,      rouXw,             rouYw,                0.0)       # steel web
    ops.nDMaterial('SmearedSteelDoubleLayerT2DMaterial01',  9,  1,  3,      rouXb,             rouYb,                0.0)       # steel boundary

    # Section ----------------------------------------------------------------------------------------------------------------------
    # Build ReinforceConcreteLayerMembraneSection01
    
    tw = 152.4*mm                       # Wall thickness
    tb = 304.8*mm                       # Loading tranfer beam thickness
    tnc = 81.0*mm                       # unconfined concrete wall layer thickness
    tc = 71.4*mm                        # confined concrete wall layer thickness   
    tncv = 233.4*mm                     # unconfined concrete loading tranfer beam layer thickness
    tcv = 71.4*mm                       # confined concrete loading tranfer bream layer thickness

    # section('ReinforcedConcreteLayerMembraneSection01', secTag, nSteelLayer, nConcLayer, '-reinfSteel', *RSteelAtEachLayer, '–conc', *concAtEachLayer, '-concThick', *concThicknessesAtEachLayer)
    #ops.section('ReinforcedConcreteLayerMembraneSection01', 10,       1,           1,      '-reinfSteel',        *[8],           '-conc',      *[6],           '-concThick',   *[tw])           # Wall Web
    #ops.section('ReinforcedConcreteLayerMembraneSection01', 11,       1,           2,      '-reinfSteel',        *[9],           '-conc',      *[6, 7],        '-concThick',   *[tnc, tc])      # Wall Boundary
    #ops.section('ReinforcedConcreteLayerMembraneSection01', 12,       1,           1,      '-reinfSteel',        *[8],           '-conc',      *[6],           '-concThick',   *[tb])           # Loading tranfer beam web
    #ops.section('ReinforcedConcreteLayerMembraneSection01', 13,       1,           2,      '-reinfSteel',        *[9],           '-conc',      *[6, 7],        '-concThick',   *[tncv, tcv])    # Loading tranfer beam boundary
    
    ops.section('ReinforcedConcreteLayerMembraneSection01', 10, 1, 1, '-reinfSteel', 8, '-conc', 6,    '-concThick', tw)           # Wall Web
    ops.section('ReinforcedConcreteLayerMembraneSection01', 11, 1, 2, '-reinfSteel', 9, '-conc', 6, 7, '-concThick', tnc, tc)      # Wall Boundary
    ops.section('ReinforcedConcreteLayerMembraneSection01', 12, 1, 1, '-reinfSteel', 8, '-conc', 6,    '-concThick', tb)           # Loading tranfer beam web
    ops.section('ReinforcedConcreteLayerMembraneSection01', 13, 1, 2, '-reinfSteel', 9, '-conc', 6, 7, '-concThick', tncv, tcv)    # Loading tranfer beam boundary

    
def areaElements_MEFI():
    
    m_fibers = 8
    db = 228.6*mm                      # Wall boundary length discretization
    dw = 127.133*mm                    # Wall web length discretization
    tw = 152.4*mm                      # Wall thickness
    tb = 304.8*mm                      # Loading tranfer beam thickness

    # Build MEFI
    ops.element('MEFI',1,1,2,4,3,m_fibers,'-thick',tw,tw,tw,tw,tw,tw,tw,tw,'-width',db,dw,dw,dw,dw,dw,dw,db,'-mat',7,6,6,6,6,6,6,7)
    ops.element('MEFI',2,3,4,6,5,m_fibers,'-thick',tw,tw,tw,tw,tw,tw,tw,tw,'-width',db,dw,dw,dw,dw,dw,dw,db,'-mat',7,6,6,6,6,6,6,7)
    ops.element('MEFI',3,5,6,8,7,m_fibers,'-thick',tw,tw,tw,tw,tw,tw,tw,tw,'-width',db,dw,dw,dw,dw,dw,dw,db,'-mat',7,6,6,6,6,6,6,7)
    ops.element('MEFI',4,7,8,10,9,m_fibers,'-thick',tw,tw,tw,tw,tw,tw,tw,tw,'-width',db,dw,dw,dw,dw,dw,dw,db,'-mat',7,6,6,6,6,6,6,7)
    ops.element('MEFI',5,9,10,12,11,m_fibers,'-thick',tw,tw,tw,tw,tw,tw,tw,tw,'-width',db,dw,dw,dw,dw,dw,dw,db,'-mat',7,6,6,6,6,6,6,7)
    ops.element('MEFI',6,11,12,14,13,m_fibers,'-thick',tw,tw,tw,tw,tw,tw,tw,tw,'-width',db,dw,dw,dw,dw,dw,dw,db,'-mat',7,6,6,6,6,6,6,7)
    ops.element('MEFI',7,13,14,16,15,m_fibers,'-thick',tw,tw,tw,tw,tw,tw,tw,tw,'-width',db,dw,dw,dw,dw,dw,dw,db,'-mat',7,6,6,6,6,6,6,7)
    ops.element('MEFI',8,15,16,18,17,m_fibers,'-thick',tb,tb,tb,tb,tb,tb,tb,tb,'-width',db,dw,dw,dw,dw,dw,dw,db,'-mat',7,6,6,6,6,6,6,7)
    ops.element('MEFI',9,17,18,20,19,m_fibers,'-thick',tb,tb,tb,tb,tb,tb,tb,tb,'-width',db,dw,dw,dw,dw,dw,dw,db,'-mat',7,6,6,6,6,6,6,7)

def areaElements_MEFISection():
    
    m_fibers = 8
    db = 228.6*mm                      # Wall boundary length discretization
    dw = 127.133*mm                    # Wall web length discretization

    # Build MEFISection
    # element('MEFISection', eleTag, iNode, jNode, kNode, lNode, m, '-width', *Widths, '-section', *Section_tags)
    # element('MEFISection', eleTag,           *eleNodes,        m, '-width', *Widths, '-section', *Section_tags)
    ops.element('MEFISection',1,1,2,4,3,m_fibers,'-width',db,dw,dw,dw,dw,dw,dw,db,'-section',11,10,10,10,10,10,10,11)
    ops.element('MEFISection',2,3,4,6,5,m_fibers,'-width',db,dw,dw,dw,dw,dw,dw,db,'-section',11,10,10,10,10,10,10,11)
    ops.element('MEFISection',3,5,6,8,7,m_fibers,'-width',db,dw,dw,dw,dw,dw,dw,db,'-section',11,10,10,10,10,10,10,11)
    ops.element('MEFISection',4,7,8,10,9,m_fibers,'-width',db,dw,dw,dw,dw,dw,dw,db,'-section',11,10,10,10,10,10,10,11)
    ops.element('MEFISection',5,9,10,12,11,m_fibers,'-width',db,dw,dw,dw,dw,dw,dw,db,'-section',11,10,10,10,10,10,10,11)
    ops.element('MEFISection',6,11,12,14,13,m_fibers,'-width',db,dw,dw,dw,dw,dw,dw,db,'-section',11,10,10,10,10,10,10,11)
    ops.element('MEFISection',7,13,14,16,15,m_fibers,'-width',db,dw,dw,dw,dw,dw,dw,db,'-section',11,10,10,10,10,10,10,11)
    ops.element('MEFISection',8,15,16,18,17,m_fibers,'-width',db,dw,dw,dw,dw,dw,dw,db,'-section',13,12,12,12,12,12,12,13)
    ops.element('MEFISection',9,17,18,20,19,m_fibers,'-width',db,dw,dw,dw,dw,dw,dw,db,'-section',13,12,12,12,12,12,12,13)