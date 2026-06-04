
################################################################
# This is a generated script based on design: RiscV_BD
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source RiscV_BD_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# ALU_OPER, EX_MA_PR, ID_EX_PR, IF_ID_PR, MA_WB_PR, Q16_16_Mult, Write_back_Mux, alu_fixed_point_mux, alu_muxes, apb_soc_top, branch_fsm, combinational, concat_2to1, concat_2to1, concat_2to1, controller, csr, csr_mux, data_mem, forwarding_mux, hazard_unit, imm_extend, instr_mem, instr_retire_mux, load_extend, mul_fsm, or_gate, pc, register_file, two_in32bitmix, two_in32bitmix

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg400-1
   set_property BOARD_PART tul.com.tw:pynq-z2:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name RiscV_BD

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set clk_0 [ create_bd_port -dir I -type clk clk_0 ]
  set gpio_pins_0 [ create_bd_port -dir IO -from 15 -to 0 gpio_pins_0 ]
  set reset_0 [ create_bd_port -dir I -type rst reset_0 ]
  set spi_mosi_0 [ create_bd_port -dir O spi_mosi_0 ]
  set spi_sclk_0 [ create_bd_port -dir O spi_sclk_0 ]
  set spi_ss_n_0 [ create_bd_port -dir O spi_ss_n_0 ]

  # Create instance: ALU_OPER_0, and set properties
  set block_name ALU_OPER
  set block_cell_name ALU_OPER_0
  if { [catch {set ALU_OPER_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ALU_OPER_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: EX_MA_PR_0, and set properties
  set block_name EX_MA_PR
  set block_cell_name EX_MA_PR_0
  if { [catch {set EX_MA_PR_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $EX_MA_PR_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ID_EX_PR_0, and set properties
  set block_name ID_EX_PR
  set block_cell_name ID_EX_PR_0
  if { [catch {set ID_EX_PR_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ID_EX_PR_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: IF_ID_PR_0, and set properties
  set block_name IF_ID_PR
  set block_cell_name IF_ID_PR_0
  if { [catch {set IF_ID_PR_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $IF_ID_PR_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: MA_WB_PR_0, and set properties
  set block_name MA_WB_PR
  set block_cell_name MA_WB_PR_0
  if { [catch {set MA_WB_PR_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $MA_WB_PR_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Q16_16_Mult_0, and set properties
  set block_name Q16_16_Mult
  set block_cell_name Q16_16_Mult_0
  if { [catch {set Q16_16_Mult_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Q16_16_Mult_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Write_back_Mux_0, and set properties
  set block_name Write_back_Mux
  set block_cell_name Write_back_Mux_0
  if { [catch {set Write_back_Mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Write_back_Mux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: alu_fixed_point_mux_0, and set properties
  set block_name alu_fixed_point_mux
  set block_cell_name alu_fixed_point_mux_0
  if { [catch {set alu_fixed_point_mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $alu_fixed_point_mux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: alu_muxes_0, and set properties
  set block_name alu_muxes
  set block_cell_name alu_muxes_0
  if { [catch {set alu_muxes_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $alu_muxes_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: apb_soc_top_0, and set properties
  set block_name apb_soc_top
  set block_cell_name apb_soc_top_0
  if { [catch {set apb_soc_top_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $apb_soc_top_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: branch_fsm_0, and set properties
  set block_name branch_fsm
  set block_cell_name branch_fsm_0
  if { [catch {set branch_fsm_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $branch_fsm_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: combinational_0, and set properties
  set block_name combinational
  set block_cell_name combinational_0
  if { [catch {set combinational_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $combinational_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: concat_2to1_0, and set properties
  set block_name concat_2to1
  set block_cell_name concat_2to1_0
  if { [catch {set concat_2to1_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $concat_2to1_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: concat_2to1_1, and set properties
  set block_name concat_2to1
  set block_cell_name concat_2to1_1
  if { [catch {set concat_2to1_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $concat_2to1_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: concat_2to1_2, and set properties
  set block_name concat_2to1
  set block_cell_name concat_2to1_2
  if { [catch {set concat_2to1_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $concat_2to1_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: controller_0, and set properties
  set block_name controller
  set block_cell_name controller_0
  if { [catch {set controller_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $controller_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: csr_0, and set properties
  set block_name csr
  set block_cell_name csr_0
  if { [catch {set csr_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $csr_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: csr_mux_0, and set properties
  set block_name csr_mux
  set block_cell_name csr_mux_0
  if { [catch {set csr_mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $csr_mux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: data_mem_0, and set properties
  set block_name data_mem
  set block_cell_name data_mem_0
  if { [catch {set data_mem_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $data_mem_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: forwarding_mux_0, and set properties
  set block_name forwarding_mux
  set block_cell_name forwarding_mux_0
  if { [catch {set forwarding_mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $forwarding_mux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: hazard_unit_0, and set properties
  set block_name hazard_unit
  set block_cell_name hazard_unit_0
  if { [catch {set hazard_unit_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $hazard_unit_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_0 ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_ILA_AXI_MON {false} \
   CONFIG.C_MONITOR_TYPE {Native} \
   CONFIG.C_NUM_OF_PROBES {41} \
   CONFIG.C_PROBE10_WIDTH {32} \
   CONFIG.C_PROBE11_WIDTH {12} \
   CONFIG.C_PROBE12_WIDTH {1} \
   CONFIG.C_PROBE14_WIDTH {2} \
   CONFIG.C_PROBE15_WIDTH {1} \
   CONFIG.C_PROBE16_WIDTH {32} \
   CONFIG.C_PROBE17_WIDTH {32} \
   CONFIG.C_PROBE18_WIDTH {32} \
   CONFIG.C_PROBE19_WIDTH {32} \
   CONFIG.C_PROBE1_WIDTH {32} \
   CONFIG.C_PROBE20_WIDTH {32} \
   CONFIG.C_PROBE21_WIDTH {32} \
   CONFIG.C_PROBE22_WIDTH {32} \
   CONFIG.C_PROBE23_WIDTH {32} \
   CONFIG.C_PROBE24_WIDTH {32} \
   CONFIG.C_PROBE25_WIDTH {32} \
   CONFIG.C_PROBE26_WIDTH {32} \
   CONFIG.C_PROBE27_WIDTH {32} \
   CONFIG.C_PROBE28_WIDTH {32} \
   CONFIG.C_PROBE2_WIDTH {32} \
   CONFIG.C_PROBE31_WIDTH {32} \
   CONFIG.C_PROBE34_WIDTH {1} \
   CONFIG.C_PROBE3_WIDTH {7} \
   CONFIG.C_PROBE4_WIDTH {5} \
   CONFIG.C_PROBE5_WIDTH {32} \
   CONFIG.C_PROBE6_WIDTH {5} \
   CONFIG.C_PROBE7_WIDTH {32} \
   CONFIG.C_PROBE8_WIDTH {5} \
   CONFIG.C_PROBE9_WIDTH {32} \
 ] $ila_0

  # Create instance: imm_extend_0, and set properties
  set block_name imm_extend
  set block_cell_name imm_extend_0
  if { [catch {set imm_extend_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $imm_extend_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: instr_mem_0, and set properties
  set block_name instr_mem
  set block_cell_name instr_mem_0
  if { [catch {set instr_mem_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $instr_mem_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: instr_retire_mux_0, and set properties
  set block_name instr_retire_mux
  set block_cell_name instr_retire_mux_0
  if { [catch {set instr_retire_mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $instr_retire_mux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: load_extend_0, and set properties
  set block_name load_extend
  set block_cell_name load_extend_0
  if { [catch {set load_extend_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $load_extend_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: mul_fsm_0, and set properties
  set block_name mul_fsm
  set block_cell_name mul_fsm_0
  if { [catch {set mul_fsm_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mul_fsm_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: or_gate_1, and set properties
  set block_name or_gate
  set block_cell_name or_gate_1
  if { [catch {set or_gate_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $or_gate_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pc_0, and set properties
  set block_name pc
  set block_cell_name pc_0
  if { [catch {set pc_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pc_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: register_file_0, and set properties
  set block_name register_file
  set block_cell_name register_file_0
  if { [catch {set register_file_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $register_file_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: two_in32bitmix_0, and set properties
  set block_name two_in32bitmix
  set block_cell_name two_in32bitmix_0
  if { [catch {set two_in32bitmix_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $two_in32bitmix_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: two_in32bitmix_1, and set properties
  set block_name two_in32bitmix
  set block_cell_name two_in32bitmix_1
  if { [catch {set two_in32bitmix_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $two_in32bitmix_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net ALU_OPER_0_alu_out [get_bd_pins ALU_OPER_0/alu_out] [get_bd_pins alu_fixed_point_mux_0/alu_output]
  connect_bd_net -net ALU_OPER_0_branch_condi [get_bd_pins ALU_OPER_0/branch_condi] [get_bd_pins alu_muxes_0/condition] [get_bd_pins branch_fsm_0/condition] [get_bd_pins hazard_unit_0/condition_stall]
  connect_bd_net -net EX_MA_PR_0_ALU_result_M [get_bd_pins EX_MA_PR_0/ALU_result_M] [get_bd_pins MA_WB_PR_0/alu_result_M] [get_bd_pins apb_soc_top_0/proc_addr] [get_bd_pins data_mem_0/dmem_addr] [get_bd_pins forwarding_mux_0/rs_M] [get_bd_pins ila_0/probe27]
  connect_bd_net -net EX_MA_PR_0_CSR_Rdata_M [get_bd_pins EX_MA_PR_0/CSR_Rdata_M] [get_bd_pins MA_WB_PR_0/CSR_Rdata_M]
  connect_bd_net -net EX_MA_PR_0_Ex_Imm_M [get_bd_pins EX_MA_PR_0/Ex_Imm_M] [get_bd_pins MA_WB_PR_0/Ex_imm_M] [get_bd_pins apb_soc_top_0/proc_wdata] [get_bd_pins ila_0/probe28]
  connect_bd_net -net EX_MA_PR_0_PC_plus4_M [get_bd_pins EX_MA_PR_0/PC_plus4_M] [get_bd_pins MA_WB_PR_0/PC_plus4_M]
  connect_bd_net -net EX_MA_PR_0_RD_M [get_bd_pins EX_MA_PR_0/RD_M] [get_bd_pins MA_WB_PR_0/RD_M] [get_bd_pins hazard_unit_0/rdmem]
  connect_bd_net -net EX_MA_PR_0_Result_src_M [get_bd_pins EX_MA_PR_0/Result_src_M] [get_bd_pins MA_WB_PR_0/result_src_M]
  connect_bd_net -net EX_MA_PR_0_inst_retired_M [get_bd_pins EX_MA_PR_0/inst_retired_M] [get_bd_pins MA_WB_PR_0/inst_retired_M]
  connect_bd_net -net EX_MA_PR_0_load_peripharal_M [get_bd_pins EX_MA_PR_0/load_peripharal_M] [get_bd_pins hazard_unit_0/peripheral_load]
  connect_bd_net -net EX_MA_PR_0_load_src_M [get_bd_pins EX_MA_PR_0/load_src_M] [get_bd_pins load_extend_0/load_src_M]
  connect_bd_net -net EX_MA_PR_0_mem_write_M [get_bd_pins EX_MA_PR_0/mem_write_M] [get_bd_pins data_mem_0/memWrite_en]
  connect_bd_net -net EX_MA_PR_0_peripheral_wen_M [get_bd_pins EX_MA_PR_0/peripheral_wen_M] [get_bd_pins apb_soc_top_0/proc_wr_en] [get_bd_pins hazard_unit_0/processor_wen] [get_bd_pins ila_0/probe29]
  connect_bd_net -net EX_MA_PR_0_proces_req_M [get_bd_pins EX_MA_PR_0/proces_req_M] [get_bd_pins apb_soc_top_0/proc_req] [get_bd_pins hazard_unit_0/processor_request] [get_bd_pins ila_0/probe30]
  connect_bd_net -net EX_MA_PR_0_reg_write_M [get_bd_pins EX_MA_PR_0/reg_write_M] [get_bd_pins MA_WB_PR_0/Reg_write_M]
  connect_bd_net -net EX_MA_PR_0_write_data_M [get_bd_pins EX_MA_PR_0/write_data_M] [get_bd_pins data_mem_0/write_data] [get_bd_pins ila_0/probe25]
  connect_bd_net -net ID_EX_PR_0_CSR_Rdata_E [get_bd_pins EX_MA_PR_0/CSR_Rdata_E] [get_bd_pins ID_EX_PR_0/CSR_Rdata_E]
  connect_bd_net -net ID_EX_PR_0_Ex_Imm_E [get_bd_pins EX_MA_PR_0/Ex_Imm_E] [get_bd_pins ID_EX_PR_0/Ex_Imm_E] [get_bd_pins alu_muxes_0/immediate]
  connect_bd_net -net ID_EX_PR_0_PC_E [get_bd_pins ID_EX_PR_0/PC_E] [get_bd_pins alu_muxes_0/pc_Plus_4]
  connect_bd_net -net ID_EX_PR_0_PC_plus4_E [get_bd_pins EX_MA_PR_0/PC_plus4_E] [get_bd_pins ID_EX_PR_0/PC_plus4_E]
  connect_bd_net -net ID_EX_PR_0_RD1_E [get_bd_pins ID_EX_PR_0/RD1_E] [get_bd_pins forwarding_mux_0/rs1_E] [get_bd_pins two_in32bitmix_0/in1]
  connect_bd_net -net ID_EX_PR_0_RD2_E [get_bd_pins ID_EX_PR_0/RD2_E] [get_bd_pins forwarding_mux_0/rs2_E]
  connect_bd_net -net ID_EX_PR_0_RD_E [get_bd_pins EX_MA_PR_0/RD_E] [get_bd_pins ID_EX_PR_0/RD_E] [get_bd_pins hazard_unit_0/rdex]
  connect_bd_net -net ID_EX_PR_0_RS1_E [get_bd_pins ID_EX_PR_0/RS1_E] [get_bd_pins hazard_unit_0/rs1ex]
  connect_bd_net -net ID_EX_PR_0_RS2_E [get_bd_pins ID_EX_PR_0/RS2_E] [get_bd_pins hazard_unit_0/rs2ex]
  connect_bd_net -net ID_EX_PR_0_Reg_write_E [get_bd_pins EX_MA_PR_0/reg_write_E] [get_bd_pins ID_EX_PR_0/Reg_write_E]
  connect_bd_net -net ID_EX_PR_0_Result_src_E [get_bd_pins EX_MA_PR_0/Result_src_E] [get_bd_pins ID_EX_PR_0/Result_src_E]
  connect_bd_net -net ID_EX_PR_0_alu_op_ctrl_E [get_bd_pins ID_EX_PR_0/alu_op_ctrl_E] [get_bd_pins alu_muxes_0/ALUOpCtrl] [get_bd_pins mul_fsm_0/alu_op]
  connect_bd_net -net ID_EX_PR_0_alu_src_E [get_bd_pins ID_EX_PR_0/alu_src_E] [get_bd_pins alu_muxes_0/ALUSrc]
  connect_bd_net -net ID_EX_PR_0_branch_E [get_bd_pins ID_EX_PR_0/branch_E] [get_bd_pins alu_muxes_0/branch_E] [get_bd_pins branch_fsm_0/branch] [get_bd_pins combinational_0/Branch_E]
  connect_bd_net -net ID_EX_PR_0_fix_P_mux_E [get_bd_pins ID_EX_PR_0/fix_P_mux_E] [get_bd_pins alu_fixed_point_mux_0/fixed_pmux_E]
  connect_bd_net -net ID_EX_PR_0_inst_retired_E [get_bd_pins ID_EX_PR_0/inst_retired_E] [get_bd_pins instr_retire_mux_0/instr_retired]
  connect_bd_net -net ID_EX_PR_0_jump_E [get_bd_pins ID_EX_PR_0/jump_E] [get_bd_pins combinational_0/jump_E]
  connect_bd_net -net ID_EX_PR_0_load_peripheral_E [get_bd_pins EX_MA_PR_0/load_peripharal_E] [get_bd_pins ID_EX_PR_0/load_peripheral_E]
  connect_bd_net -net ID_EX_PR_0_load_src_E [get_bd_pins EX_MA_PR_0/load_src_E] [get_bd_pins ID_EX_PR_0/load_src_E]
  connect_bd_net -net ID_EX_PR_0_mem2reg_E [get_bd_pins ID_EX_PR_0/mem2reg_E] [get_bd_pins hazard_unit_0/memtoreg]
  connect_bd_net -net ID_EX_PR_0_mem_write_E [get_bd_pins EX_MA_PR_0/mem_write_E] [get_bd_pins ID_EX_PR_0/mem_write_E]
  connect_bd_net -net ID_EX_PR_0_peripheral_wen_E [get_bd_pins EX_MA_PR_0/peripheral_wen_E] [get_bd_pins ID_EX_PR_0/peripheral_wen_E]
  connect_bd_net -net ID_EX_PR_0_processer_req_E [get_bd_pins EX_MA_PR_0/proces_req_E] [get_bd_pins ID_EX_PR_0/processer_req_E] [get_bd_pins two_in32bitmix_0/sel]
  connect_bd_net -net IF_ID_PR_0_Imm_D [get_bd_pins IF_ID_PR_0/Imm_D] [get_bd_pins imm_extend_0/instr_in]
  connect_bd_net -net IF_ID_PR_0_PC_D [get_bd_pins ID_EX_PR_0/PC_D] [get_bd_pins IF_ID_PR_0/PC_D]
  connect_bd_net -net IF_ID_PR_0_PC_plus4_D [get_bd_pins ID_EX_PR_0/PC_plus4_D] [get_bd_pins IF_ID_PR_0/PC_plus4_D]
  connect_bd_net -net IF_ID_PR_0_Rd_D [get_bd_pins ID_EX_PR_0/RD_D] [get_bd_pins IF_ID_PR_0/Rd_D]
  connect_bd_net -net IF_ID_PR_0_Rs1_D [get_bd_pins ID_EX_PR_0/RS1_D] [get_bd_pins IF_ID_PR_0/Rs1_D] [get_bd_pins hazard_unit_0/rs1id] [get_bd_pins ila_0/probe4] [get_bd_pins register_file_0/rs1]
  connect_bd_net -net IF_ID_PR_0_Rs2_D [get_bd_pins ID_EX_PR_0/RS2_D] [get_bd_pins IF_ID_PR_0/Rs2_D] [get_bd_pins hazard_unit_0/rs2id] [get_bd_pins ila_0/probe6] [get_bd_pins register_file_0/rs2]
  connect_bd_net -net IF_ID_PR_0_csr_add_D [get_bd_pins IF_ID_PR_0/csr_add_D] [get_bd_pins csr_0/csr_addr] [get_bd_pins ila_0/probe11]
  connect_bd_net -net IF_ID_PR_0_funct3_D [get_bd_pins IF_ID_PR_0/funct3_D] [get_bd_pins controller_0/funct3]
  connect_bd_net -net IF_ID_PR_0_funct7_D [get_bd_pins IF_ID_PR_0/funct7_D] [get_bd_pins controller_0/funct7]
  connect_bd_net -net IF_ID_PR_0_opcode [get_bd_pins IF_ID_PR_0/opcode] [get_bd_pins controller_0/opcode] [get_bd_pins ila_0/probe3]
  connect_bd_net -net MA_WB_PR_0_CSR_Rdata_W [get_bd_pins MA_WB_PR_0/CSR_Rdata_W] [get_bd_pins Write_back_Mux_0/CSR_rdata_W]
  connect_bd_net -net MA_WB_PR_0_Ex_imm_W [get_bd_pins MA_WB_PR_0/Ex_imm_W] [get_bd_pins Write_back_Mux_0/Ex_Imm_W]
  connect_bd_net -net MA_WB_PR_0_PC_plus4_W [get_bd_pins MA_WB_PR_0/PC_plus4_W] [get_bd_pins Write_back_Mux_0/PC_plus4_W]
  connect_bd_net -net MA_WB_PR_0_RD_W [get_bd_pins MA_WB_PR_0/RD_W] [get_bd_pins hazard_unit_0/rdwb] [get_bd_pins ila_0/probe8] [get_bd_pins register_file_0/rd]
  connect_bd_net -net MA_WB_PR_0_Reg_write_W [get_bd_pins MA_WB_PR_0/Reg_write_W] [get_bd_pins register_file_0/reg_write]
  connect_bd_net -net MA_WB_PR_0_alu_result_W [get_bd_pins MA_WB_PR_0/alu_result_W] [get_bd_pins Write_back_Mux_0/Alu_result_W]
  connect_bd_net -net MA_WB_PR_0_inst_retired_W [get_bd_pins MA_WB_PR_0/inst_retired_W] [get_bd_pins csr_0/instr_retired]
  connect_bd_net -net MA_WB_PR_0_read_data_W [get_bd_pins MA_WB_PR_0/read_data_W] [get_bd_pins Write_back_Mux_0/Read_data_W]
  connect_bd_net -net MA_WB_PR_0_result_src_W [get_bd_pins MA_WB_PR_0/result_src_W] [get_bd_pins Write_back_Mux_0/result_src_W]
  connect_bd_net -net Net [get_bd_ports gpio_pins_0] [get_bd_pins apb_soc_top_0/gpio_pins]
  connect_bd_net -net Q16_16_Mult_0_result [get_bd_pins Q16_16_Mult_0/result] [get_bd_pins alu_fixed_point_mux_0/fixed_point_output] [get_bd_pins ila_0/probe24]
  connect_bd_net -net Write_back_Mux_0_W_data [get_bd_pins Write_back_Mux_0/W_data] [get_bd_pins forwarding_mux_0/rs_W] [get_bd_pins ila_0/probe9] [get_bd_pins register_file_0/wr_data]
  connect_bd_net -net alu_fixed_point_mux_0_final_output [get_bd_pins alu_fixed_point_mux_0/final_output] [get_bd_pins pc_0/pc_alu] [get_bd_pins two_in32bitmix_0/in2]
  connect_bd_net -net alu_muxes_0_ALU_op [get_bd_pins ALU_OPER_0/alu_oper] [get_bd_pins alu_muxes_0/alu_op]
  connect_bd_net -net alu_muxes_0_alu_branch [get_bd_pins ALU_OPER_0/branch_E] [get_bd_pins alu_muxes_0/alu_branch]
  connect_bd_net -net alu_muxes_0_alu_input_1 [get_bd_pins ALU_OPER_0/alu_in_1] [get_bd_pins alu_muxes_0/alu_input_1] [get_bd_pins ila_0/probe19]
  connect_bd_net -net alu_muxes_0_alu_input_2 [get_bd_pins ALU_OPER_0/alu_in_2] [get_bd_pins alu_muxes_0/alu_input_2] [get_bd_pins ila_0/probe20]
  connect_bd_net -net alu_muxes_0_condition_out [get_bd_pins alu_muxes_0/condition_out] [get_bd_pins combinational_0/condition_out]
  connect_bd_net -net apb_soc_top_0_gpio_interrupt [get_bd_pins apb_soc_top_0/gpio_interrupt] [get_bd_pins controller_0/interrupt_in] [get_bd_pins ila_0/probe33]
  connect_bd_net -net apb_soc_top_0_proc_ack [get_bd_pins apb_soc_top_0/proc_ack] [get_bd_pins hazard_unit_0/proc_ack] [get_bd_pins ila_0/probe32] [get_bd_pins two_in32bitmix_1/sel]
  connect_bd_net -net apb_soc_top_0_proc_rdata [get_bd_pins apb_soc_top_0/proc_rdata] [get_bd_pins ila_0/probe31] [get_bd_pins two_in32bitmix_1/in1]
  connect_bd_net -net apb_soc_top_0_spi_mosi [get_bd_ports spi_mosi_0] [get_bd_pins apb_soc_top_0/spi_mosi]
  connect_bd_net -net apb_soc_top_0_spi_sclk [get_bd_ports spi_sclk_0] [get_bd_pins apb_soc_top_0/spi_sclk]
  connect_bd_net -net apb_soc_top_0_spi_ss_n [get_bd_ports spi_ss_n_0] [get_bd_pins apb_soc_top_0/spi_ss_n]
  connect_bd_net -net branch_fsm_0_alu_mux_in [get_bd_pins alu_muxes_0/alu_mux_in] [get_bd_pins branch_fsm_0/alu_mux_in]
  connect_bd_net -net branch_fsm_0_alu_mux_sel [get_bd_pins alu_muxes_0/alu_mux_sel] [get_bd_pins branch_fsm_0/alu_mux_sel]
  connect_bd_net -net branch_fsm_0_branch_mux_sel [get_bd_pins alu_muxes_0/branch_mux_sel] [get_bd_pins branch_fsm_0/branch_mux_sel]
  connect_bd_net -net branch_fsm_0_condition_mux_sel [get_bd_pins alu_muxes_0/condition_mux_sel] [get_bd_pins branch_fsm_0/condition_mux_sel]
  connect_bd_net -net branch_fsm_0_flush_allow [get_bd_pins branch_fsm_0/flush_allow] [get_bd_pins combinational_0/flush_allow]
  connect_bd_net -net branch_fsm_0_mux1_in [get_bd_pins alu_muxes_0/mux1_in] [get_bd_pins branch_fsm_0/mux1_in]
  connect_bd_net -net branch_fsm_0_mux1_sel [get_bd_pins alu_muxes_0/mux1_sel] [get_bd_pins branch_fsm_0/mux1_sel]
  connect_bd_net -net branch_fsm_0_mux2_in [get_bd_pins alu_muxes_0/mux2_in] [get_bd_pins branch_fsm_0/mux2_in]
  connect_bd_net -net branch_fsm_0_mux2_sel [get_bd_pins alu_muxes_0/mux2_sel] [get_bd_pins branch_fsm_0/mux2_sel]
  connect_bd_net -net clk_0_1 [get_bd_ports clk_0] [get_bd_pins ALU_OPER_0/clk] [get_bd_pins EX_MA_PR_0/clk] [get_bd_pins ID_EX_PR_0/clk] [get_bd_pins IF_ID_PR_0/clk] [get_bd_pins MA_WB_PR_0/clk] [get_bd_pins apb_soc_top_0/clk] [get_bd_pins branch_fsm_0/clk] [get_bd_pins csr_0/clk] [get_bd_pins data_mem_0/clk] [get_bd_pins ila_0/clk] [get_bd_pins mul_fsm_0/clk] [get_bd_pins pc_0/clk] [get_bd_pins register_file_0/clk]
  connect_bd_net -net combinational_0_pc_mux_sel0 [get_bd_pins combinational_0/pc_mux_sel0] [get_bd_pins concat_2to1_2/in0] [get_bd_pins hazard_unit_0/jump_branch_flush]
  connect_bd_net -net concat_2to1_0_conct_out [get_bd_pins concat_2to1_0/conct_out] [get_bd_pins forwarding_mux_0/Hazard_mux_sel_1]
  connect_bd_net -net concat_2to1_1_conct_out [get_bd_pins concat_2to1_1/conct_out] [get_bd_pins forwarding_mux_0/Hazard_mux_sel_2]
  connect_bd_net -net concat_2to1_2_conct_out [get_bd_pins concat_2to1_2/conct_out] [get_bd_pins pc_0/pc_mux_sel]
  connect_bd_net -net controller_0_ALUOpCtrl [get_bd_pins ID_EX_PR_0/alu_op_ctrl_D] [get_bd_pins controller_0/ALUOpCtrl]
  connect_bd_net -net controller_0_ALUSrc [get_bd_pins ID_EX_PR_0/alu_src_D] [get_bd_pins controller_0/ALUSrc]
  connect_bd_net -net controller_0_Branch [get_bd_pins ID_EX_PR_0/branch_D] [get_bd_pins controller_0/Branch] [get_bd_pins ila_0/probe13]
  connect_bd_net -net controller_0_ImmSrc [get_bd_pins controller_0/ImmSrc] [get_bd_pins imm_extend_0/imm_type_in]
  connect_bd_net -net controller_0_Jump [get_bd_pins ID_EX_PR_0/jump_D] [get_bd_pins controller_0/Jump] [get_bd_pins ila_0/probe12]
  connect_bd_net -net controller_0_MemWrite [get_bd_pins ID_EX_PR_0/mem_write_D] [get_bd_pins controller_0/MemWrite]
  connect_bd_net -net controller_0_RegWrite [get_bd_pins ID_EX_PR_0/Reg_write_D] [get_bd_pins controller_0/RegWrite]
  connect_bd_net -net controller_0_ResultSrc [get_bd_pins ID_EX_PR_0/Result_src_D] [get_bd_pins controller_0/ResultSrc]
  connect_bd_net -net controller_0_csr_op [get_bd_pins controller_0/csr_op] [get_bd_pins csr_0/csr_op] [get_bd_pins ila_0/probe14]
  connect_bd_net -net controller_0_csr_wen [get_bd_pins controller_0/csr_wen] [get_bd_pins csr_0/csr_wen]
  connect_bd_net -net controller_0_excep [get_bd_pins controller_0/excep] [get_bd_pins csr_mux_0/exception] [get_bd_pins ila_0/probe15] [get_bd_pins or_gate_1/b]
  connect_bd_net -net controller_0_fixed_pMUX [get_bd_pins ID_EX_PR_0/fix_P_mux_D] [get_bd_pins controller_0/fixed_pMUX]
  connect_bd_net -net controller_0_instr_retired [get_bd_pins ID_EX_PR_0/inst_retired_D] [get_bd_pins controller_0/instr_retired]
  connect_bd_net -net controller_0_load_src [get_bd_pins ID_EX_PR_0/load_src_D] [get_bd_pins controller_0/load_src]
  connect_bd_net -net controller_0_mem2reg [get_bd_pins ID_EX_PR_0/mem2reg_D] [get_bd_pins controller_0/mem2reg]
  connect_bd_net -net controller_0_peripheral_load [get_bd_pins ID_EX_PR_0/load_peripharal_D] [get_bd_pins controller_0/peripheral_load]
  connect_bd_net -net controller_0_processor_request [get_bd_pins ID_EX_PR_0/processer_req_D] [get_bd_pins controller_0/processor_request]
  connect_bd_net -net controller_0_processor_wen [get_bd_pins ID_EX_PR_0/peripheral_wen_D] [get_bd_pins controller_0/processor_wen]
  connect_bd_net -net csr_0_csr_rdata [get_bd_pins ID_EX_PR_0/CSR_Rdata_D] [get_bd_pins csr_0/csr_rdata] [get_bd_pins ila_0/probe16]
  connect_bd_net -net csr_0_mepc_out [get_bd_pins csr_0/mepc_out] [get_bd_pins ila_0/probe17] [get_bd_pins pc_0/pc_mepc]
  connect_bd_net -net csr_0_mtvec_out [get_bd_pins csr_0/mtvec_out] [get_bd_pins ila_0/probe18] [get_bd_pins pc_0/pc_mtvec]
  connect_bd_net -net csr_mux_0_csr_exc [get_bd_pins csr_0/csr_exc] [get_bd_pins csr_mux_0/csr_exc]
  connect_bd_net -net data_mem_0_data_out [get_bd_pins data_mem_0/data_out] [get_bd_pins ila_0/probe26] [get_bd_pins load_extend_0/mem_data]
  connect_bd_net -net forwarding_mux_0_rs1 [get_bd_pins Q16_16_Mult_0/A] [get_bd_pins alu_muxes_0/rs1] [get_bd_pins forwarding_mux_0/rs1] [get_bd_pins ila_0/probe22]
  connect_bd_net -net forwarding_mux_0_rs2 [get_bd_pins EX_MA_PR_0/write_data_E] [get_bd_pins Q16_16_Mult_0/B] [get_bd_pins alu_muxes_0/rs2] [get_bd_pins forwarding_mux_0/rs2] [get_bd_pins ila_0/probe23]
  connect_bd_net -net hazard_unit_0_flushd [get_bd_pins IF_ID_PR_0/flush_F] [get_bd_pins hazard_unit_0/flushd] [get_bd_pins ila_0/probe40]
  connect_bd_net -net hazard_unit_0_flushe [get_bd_pins ID_EX_PR_0/flush_D] [get_bd_pins hazard_unit_0/flushe] [get_bd_pins ila_0/probe39]
  connect_bd_net -net hazard_unit_0_mem_sel_s1 [get_bd_pins concat_2to1_0/in0] [get_bd_pins hazard_unit_0/mem_sel_s1]
  connect_bd_net -net hazard_unit_0_mem_sel_s2 [get_bd_pins concat_2to1_1/in0] [get_bd_pins hazard_unit_0/mem_sel_s2]
  connect_bd_net -net hazard_unit_0_stall_exmem [get_bd_pins EX_MA_PR_0/stall_E] [get_bd_pins hazard_unit_0/stall_exmem] [get_bd_pins ila_0/probe37]
  connect_bd_net -net hazard_unit_0_stall_idex [get_bd_pins ID_EX_PR_0/stall_D] [get_bd_pins hazard_unit_0/stall_idex] [get_bd_pins ila_0/probe36] [get_bd_pins instr_retire_mux_0/instr_stalled]
  connect_bd_net -net hazard_unit_0_stall_ifid [get_bd_pins IF_ID_PR_0/stall_F] [get_bd_pins hazard_unit_0/stall_ifid] [get_bd_pins ila_0/probe35]
  connect_bd_net -net hazard_unit_0_stall_memwb [get_bd_pins MA_WB_PR_0/stall_M] [get_bd_pins hazard_unit_0/stall_memwb] [get_bd_pins ila_0/probe38]
  connect_bd_net -net hazard_unit_0_stall_pc [get_bd_pins hazard_unit_0/stall_pc] [get_bd_pins ila_0/probe34] [get_bd_pins pc_0/stall]
  connect_bd_net -net hazard_unit_0_wb_sel_s1 [get_bd_pins concat_2to1_0/in1] [get_bd_pins hazard_unit_0/wb_sel_s1]
  connect_bd_net -net hazard_unit_0_wb_sel_s2 [get_bd_pins concat_2to1_1/in1] [get_bd_pins hazard_unit_0/wb_sel_s2]
  connect_bd_net -net imm_extend_0_imm_out [get_bd_pins ID_EX_PR_0/Ex_Imm_D] [get_bd_pins ila_0/probe10] [get_bd_pins imm_extend_0/imm_out]
  connect_bd_net -net instr_mem_0_instr [get_bd_pins IF_ID_PR_0/Inst_F] [get_bd_pins ila_0/probe2] [get_bd_pins instr_mem_0/instr]
  connect_bd_net -net instr_retire_mux_0_instr_retired_out [get_bd_pins EX_MA_PR_0/inst_retired_E] [get_bd_pins instr_retire_mux_0/instr_retired_out]
  connect_bd_net -net interrupt_0_1 [get_bd_pins controller_0/interrupt_out] [get_bd_pins csr_mux_0/interrupt] [get_bd_pins or_gate_1/a]
  connect_bd_net -net load_extend_0_read_data_M [get_bd_pins load_extend_0/read_data_M] [get_bd_pins two_in32bitmix_1/in2]
  connect_bd_net -net mul_fsm_0_mul_stall [get_bd_pins hazard_unit_0/mul_stall] [get_bd_pins mul_fsm_0/mul_stall]
  connect_bd_net -net or_gate_1_y [get_bd_pins concat_2to1_2/in1] [get_bd_pins or_gate_1/y]
  connect_bd_net -net pc_0_pc_f [get_bd_pins IF_ID_PR_0/PC_F] [get_bd_pins ila_0/probe1] [get_bd_pins instr_mem_0/addr] [get_bd_pins pc_0/pc_f]
  connect_bd_net -net pc_0_pc_inc [get_bd_pins IF_ID_PR_0/PC_plus4_F] [get_bd_pins csr_0/pc_current] [get_bd_pins pc_0/pc_inc]
  connect_bd_net -net register_file_0_rd_data1 [get_bd_pins ID_EX_PR_0/RD1_D] [get_bd_pins csr_0/rs1_data] [get_bd_pins ila_0/probe5] [get_bd_pins register_file_0/rd_data1]
  connect_bd_net -net register_file_0_rd_data2 [get_bd_pins ID_EX_PR_0/RD2_D] [get_bd_pins ila_0/probe7] [get_bd_pins register_file_0/rd_data2]
  connect_bd_net -net reset_0_1 [get_bd_ports reset_0] [get_bd_pins ALU_OPER_0/rst] [get_bd_pins EX_MA_PR_0/rst] [get_bd_pins ID_EX_PR_0/rst] [get_bd_pins IF_ID_PR_0/rst] [get_bd_pins MA_WB_PR_0/rst] [get_bd_pins apb_soc_top_0/rst] [get_bd_pins branch_fsm_0/reset_p] [get_bd_pins csr_0/rst] [get_bd_pins ila_0/probe0] [get_bd_pins mul_fsm_0/reset_p] [get_bd_pins pc_0/reset] [get_bd_pins register_file_0/syn_rst]
  connect_bd_net -net two_in32bitmix_0_out [get_bd_pins EX_MA_PR_0/ALU_result_E] [get_bd_pins ila_0/probe21] [get_bd_pins two_in32bitmix_0/result]
  connect_bd_net -net two_in32bitmix_1_result [get_bd_pins MA_WB_PR_0/read_data_M] [get_bd_pins two_in32bitmix_1/result]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


