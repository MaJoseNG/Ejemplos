wipe all

# Source display procedures
source LibUnits.tcl

# --------------------------------------------------------
# Start of model generation
# --------------------------------------------------------
#set dataDir MEFI
#set dataDir MEFISection-Concrete02
#set dataDir MEFISection-Concrete06

set dataDir RCLMS02C02S02-2
#set dataDir RCLMS01C02S02-2
#set dataDir RCLMS01C06S02-2

file mkdir $dataDir;# Create ModelBuilder for 3D element (with three-dimensions and 6 DOF/node)
model BasicBuilder -ndm 2 -ndf 3;

# --------------------------------------------
# Set geometry, nodes, boundary conditions
# --------------------------------------------
source Nodes.tcl;

# ------------------------------
# Define materials
# ------------------------------
source Materials.tcl

# ------------------------------
#  Define elements
# ------------------------------
source Area_Elements.tcl

# ------------------------------
#  Define recorders
# ------------------------------
source Recorders.tcl

puts "MODEL GENERATED successfully."