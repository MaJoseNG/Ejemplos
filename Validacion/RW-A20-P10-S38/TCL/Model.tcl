wipe all

# Source display procedures
source LibUnits.tcl

# --------------------------------------------------------
# Start of model generation
# --------------------------------------------------------
#set dataDir MEFI
#set dataDir MEFISection-Concrete02
#set dataDir MEFISection-Concrete06

# Datos para 1 ciclo por drift
#set dataDir RCLMS02C02S02
#set dataDir RCLMS01C02S02
#set dataDir RCLMS01C06S02

# Datos para más de 1 ciclo por drift
#set dataDir RCLMS02C02S02-1
#set dataDir RCLMS01C02S02-1
#set dataDir RCLMS01C06S02-1

# Datos para push para maximo drift
#set dataDir RCLMS02C02S02-Push
#set dataDir RCLMS01C02S02-Push
#set dataDir RCLMS01C06S02-Push

# Datos para push para maximo drift - Regularizacion de la respuesta segun largo de rotula plastica
#set dataDir RCLMS02C02S02-PushLp
#set dataDir RCLMS01C02S02-PushLp
#set dataDir RCLMS01C06S02-PushLp

# Datos para push para maximo drift - Regularizacion de la respuesta segun largo de rotula plastica: 2 eltos por largo de rot plast
set dataDir RCLMS02C02S02-2Lp
#set dataDir RCLMS01C02S02-2Lp
#set dataDir RCLMS01C06S02-2Lp

file mkdir $dataDir;# Create ModelBuilder for 3D element (with three-dimensions and 6 DOF/node)
model BasicBuilder -ndm 2 -ndf 3;

# --------------------------------------------
# Set geometry, nodes, boundary conditions
# --------------------------------------------
#source Nodes.tcl;
source Nodes2Lp.tcl;
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