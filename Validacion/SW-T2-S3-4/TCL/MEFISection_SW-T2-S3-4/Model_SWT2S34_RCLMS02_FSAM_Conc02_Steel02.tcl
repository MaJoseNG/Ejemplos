wipe all

# Source display procedures
source LibUnits.tcl

# --------------------------------------------------------
# Start of model generation (Units: kgf, cm)
# --------------------------------------------------------
set dataDir MEFISection_SW-T2-S3-4_RCLMS02_Conc02_Steel02

file mkdir $dataDir;

# Create ModelBuilder for 2D element (with two-dimensions and 3 DOF/node)
model BasicBuilder -ndm 2 -ndf 3;

# --------------------------------------------
# Set geometry, nodes, boundary conditions
# --------------------------------------------
source Nodes_SWT2S34.tcl;
          
# ------------------------------
# Define materials
# ------------------------------
source Materials_SWT2S34_RCLMS02_Conc02_Steel02.tcl

# ------------------------------
#  Define elements
# ------------------------------
source Area_Elements_SWT2S34_5_fibers.tcl

# ------------------------------
#  Define recorders
# ------------------------------
source Recorders_SWT2S34.tcl

puts "MODEL GENERATED successfully."