vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -sv "+incdir+../../../../FINAL_TEST2.gen/sources_1/bd/RiscV_BD/ipshared/1b7e/hdl/verilog" "+incdir+../../../../FINAL_TEST2.gen/sources_1/bd/RiscV_BD/ipshared/122e/hdl/verilog" "+incdir+../../../../FINAL_TEST2.gen/sources_1/bd/RiscV_BD/ipshared/b205/hdl/verilog" "+incdir+../../../../FINAL_TEST2.gen/sources_1/bd/RiscV_BD/ipshared/c968/hdl/verilog" \
"C:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93 \
"C:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  "+incdir+../../../../FINAL_TEST2.gen/sources_1/bd/RiscV_BD/ipshared/1b7e/hdl/verilog" "+incdir+../../../../FINAL_TEST2.gen/sources_1/bd/RiscV_BD/ipshared/122e/hdl/verilog" "+incdir+../../../../FINAL_TEST2.gen/sources_1/bd/RiscV_BD/ipshared/b205/hdl/verilog" "+incdir+../../../../FINAL_TEST2.gen/sources_1/bd/RiscV_BD/ipshared/c968/hdl/verilog" \
"../../../bd/RiscV_BD/ip/RiscV_BD_register_file_0_0/sim/RiscV_BD_register_file_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_csr_0_0/sim/RiscV_BD_csr_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_alu_fixed_point_mux_0_0/sim/RiscV_BD_alu_fixed_point_mux_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_csr_mux_0_0/sim/RiscV_BD_csr_mux_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_forwarding_mux_0_0/sim/RiscV_BD_forwarding_mux_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_load_extend_0_0/sim/RiscV_BD_load_extend_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_Write_back_Mux_0_0/sim/RiscV_BD_Write_back_Mux_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_combinational_0_0/sim/RiscV_BD_combinational_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_instr_retire_mux_0_0/sim/RiscV_BD_instr_retire_mux_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_concat_2to1_0_0/sim/RiscV_BD_concat_2to1_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_concat_2to1_1_0/sim/RiscV_BD_concat_2to1_1_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_concat_2to1_2_0/sim/RiscV_BD_concat_2to1_2_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_or_gate_1_0/sim/RiscV_BD_or_gate_1_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_alu_muxes_0_2/sim/RiscV_BD_alu_muxes_0_2.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_pc_0_0/sim/RiscV_BD_pc_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_mul_fsm_0_0/sim/RiscV_BD_mul_fsm_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_IF_ID_PR_0_0/sim/RiscV_BD_IF_ID_PR_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_MA_WB_PR_0_0/sim/RiscV_BD_MA_WB_PR_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_imm_extend_0_0/sim/RiscV_BD_imm_extend_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_hazard_unit_0_0/sim/RiscV_BD_hazard_unit_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_two_in32bitmix_0_0/sim/RiscV_BD_two_in32bitmix_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_two_in32bitmix_1_0/sim/RiscV_BD_two_in32bitmix_1_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_ID_EX_PR_0_0/sim/RiscV_BD_ID_EX_PR_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_EX_MA_PR_0_0/sim/RiscV_BD_EX_MA_PR_0_0.v" \
"../../../bd/RiscV_BD/ip/RiscV_BD_ila_0_0/sim/RiscV_BD_ila_0_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

