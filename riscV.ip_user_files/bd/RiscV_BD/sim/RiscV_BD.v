//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Fri Apr 17 05:28:08 2026
//Host        : Jaswanth_K running 64-bit major release  (build 9200)
//Command     : generate_target RiscV_BD.bd
//Design      : RiscV_BD
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "RiscV_BD,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=RiscV_BD,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=32,numReposBlks=32,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=31,numPkgbdBlks=0,bdsource=USER,da_clkrst_cnt=20,synth_mode=Global}" *) (* HW_HANDOFF = "RiscV_BD.hwdef" *) 
module RiscV_BD
   (clk_0,
    gpio_pins_0,
    reset_0,
    spi_mosi_0,
    spi_sclk_0,
    spi_ss_n_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, ASSOCIATED_RESET reset_0, CLK_DOMAIN RiscV_BD_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  inout [15:0]gpio_pins_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;
  output spi_mosi_0;
  output spi_sclk_0;
  output spi_ss_n_0;

  wire [31:0]ALU_OPER_0_alu_out;
  wire ALU_OPER_0_branch_condi;
  wire [31:0]EX_MA_PR_0_ALU_result_M;
  wire [31:0]EX_MA_PR_0_CSR_Rdata_M;
  wire [31:0]EX_MA_PR_0_Ex_Imm_M;
  wire [31:0]EX_MA_PR_0_PC_plus4_M;
  wire [4:0]EX_MA_PR_0_RD_M;
  wire [2:0]EX_MA_PR_0_Result_src_M;
  wire EX_MA_PR_0_inst_retired_M;
  wire EX_MA_PR_0_load_peripharal_M;
  wire [2:0]EX_MA_PR_0_load_src_M;
  wire EX_MA_PR_0_mem_write_M;
  wire EX_MA_PR_0_peripheral_wen_M;
  wire EX_MA_PR_0_proces_req_M;
  wire EX_MA_PR_0_reg_write_M;
  wire [31:0]EX_MA_PR_0_write_data_M;
  wire [31:0]ID_EX_PR_0_CSR_Rdata_E;
  wire [31:0]ID_EX_PR_0_Ex_Imm_E;
  wire [31:0]ID_EX_PR_0_PC_E;
  wire [31:0]ID_EX_PR_0_PC_plus4_E;
  wire [31:0]ID_EX_PR_0_RD1_E;
  wire [31:0]ID_EX_PR_0_RD2_E;
  wire [4:0]ID_EX_PR_0_RD_E;
  wire [4:0]ID_EX_PR_0_RS1_E;
  wire [4:0]ID_EX_PR_0_RS2_E;
  wire ID_EX_PR_0_Reg_write_E;
  wire [2:0]ID_EX_PR_0_Result_src_E;
  wire [3:0]ID_EX_PR_0_alu_op_ctrl_E;
  wire [1:0]ID_EX_PR_0_alu_src_E;
  wire ID_EX_PR_0_branch_E;
  wire ID_EX_PR_0_fix_P_mux_E;
  wire ID_EX_PR_0_inst_retired_E;
  wire ID_EX_PR_0_jump_E;
  wire ID_EX_PR_0_load_peripheral_E;
  wire [2:0]ID_EX_PR_0_load_src_E;
  wire ID_EX_PR_0_mem2reg_E;
  wire ID_EX_PR_0_mem_write_E;
  wire ID_EX_PR_0_peripheral_wen_E;
  wire ID_EX_PR_0_processer_req_E;
  wire [24:0]IF_ID_PR_0_Imm_D;
  wire [31:0]IF_ID_PR_0_PC_D;
  wire [31:0]IF_ID_PR_0_PC_plus4_D;
  wire [4:0]IF_ID_PR_0_Rd_D;
  wire [4:0]IF_ID_PR_0_Rs1_D;
  wire [4:0]IF_ID_PR_0_Rs2_D;
  wire [11:0]IF_ID_PR_0_csr_add_D;
  wire [2:0]IF_ID_PR_0_funct3_D;
  wire [6:0]IF_ID_PR_0_funct7_D;
  wire [6:0]IF_ID_PR_0_opcode;
  wire [31:0]MA_WB_PR_0_CSR_Rdata_W;
  wire [31:0]MA_WB_PR_0_Ex_imm_W;
  wire [31:0]MA_WB_PR_0_PC_plus4_W;
  wire [4:0]MA_WB_PR_0_RD_W;
  wire MA_WB_PR_0_Reg_write_W;
  wire [31:0]MA_WB_PR_0_alu_result_W;
  wire MA_WB_PR_0_inst_retired_W;
  wire [31:0]MA_WB_PR_0_read_data_W;
  wire [2:0]MA_WB_PR_0_result_src_W;
  wire [15:0]Net;
  wire [31:0]Q16_16_Mult_0_result;
  wire [31:0]Write_back_Mux_0_W_data;
  wire [31:0]alu_fixed_point_mux_0_final_output;
  wire [3:0]alu_muxes_0_ALU_op;
  wire alu_muxes_0_alu_branch;
  wire [31:0]alu_muxes_0_alu_input_1;
  wire [31:0]alu_muxes_0_alu_input_2;
  wire alu_muxes_0_condition_out;
  wire apb_soc_top_0_gpio_interrupt;
  wire apb_soc_top_0_proc_ack;
  wire [31:0]apb_soc_top_0_proc_rdata;
  wire apb_soc_top_0_spi_mosi;
  wire apb_soc_top_0_spi_sclk;
  wire apb_soc_top_0_spi_ss_n;
  wire [3:0]branch_fsm_0_alu_mux_in;
  wire branch_fsm_0_alu_mux_sel;
  wire branch_fsm_0_branch_mux_sel;
  wire branch_fsm_0_condition_mux_sel;
  wire branch_fsm_0_flush_allow;
  wire branch_fsm_0_mux1_in;
  wire branch_fsm_0_mux1_sel;
  wire branch_fsm_0_mux2_in;
  wire branch_fsm_0_mux2_sel;
  wire clk_0_1;
  wire combinational_0_pc_mux_sel0;
  wire [1:0]concat_2to1_0_conct_out;
  wire [1:0]concat_2to1_1_conct_out;
  wire [1:0]concat_2to1_2_conct_out;
  wire [3:0]controller_0_ALUOpCtrl;
  wire [1:0]controller_0_ALUSrc;
  wire controller_0_Branch;
  wire [2:0]controller_0_ImmSrc;
  wire controller_0_Jump;
  wire controller_0_MemWrite;
  wire controller_0_RegWrite;
  wire [2:0]controller_0_ResultSrc;
  wire [1:0]controller_0_csr_op;
  wire controller_0_csr_wen;
  wire controller_0_excep;
  wire controller_0_fixed_pMUX;
  wire controller_0_instr_retired;
  wire [2:0]controller_0_load_src;
  wire controller_0_mem2reg;
  wire controller_0_peripheral_load;
  wire controller_0_processor_request;
  wire controller_0_processor_wen;
  wire [31:0]csr_0_csr_rdata;
  wire [31:0]csr_0_mepc_out;
  wire [31:0]csr_0_mtvec_out;
  wire csr_mux_0_csr_exc;
  wire [31:0]data_mem_0_data_out;
  wire [31:0]forwarding_mux_0_rs1;
  wire [31:0]forwarding_mux_0_rs2;
  wire hazard_unit_0_flushd;
  wire hazard_unit_0_flushe;
  wire hazard_unit_0_mem_sel_s1;
  wire hazard_unit_0_mem_sel_s2;
  wire hazard_unit_0_stall_exmem;
  wire hazard_unit_0_stall_idex;
  wire hazard_unit_0_stall_ifid;
  wire hazard_unit_0_stall_memwb;
  wire hazard_unit_0_stall_pc;
  wire hazard_unit_0_wb_sel_s1;
  wire hazard_unit_0_wb_sel_s2;
  wire [31:0]imm_extend_0_imm_out;
  wire [31:0]instr_mem_0_instr;
  wire instr_retire_mux_0_instr_retired_out;
  wire interrupt_0_1;
  wire [31:0]load_extend_0_read_data_M;
  wire mul_fsm_0_mul_stall;
  wire or_gate_1_y;
  wire [31:0]pc_0_pc_f;
  wire [31:0]pc_0_pc_inc;
  wire [31:0]register_file_0_rd_data1;
  wire [31:0]register_file_0_rd_data2;
  wire reset_0_1;
  wire [31:0]two_in32bitmix_0_out;
  wire [31:0]two_in32bitmix_1_result;

  assign clk_0_1 = clk_0;
  assign reset_0_1 = reset_0;
  assign spi_mosi_0 = apb_soc_top_0_spi_mosi;
  assign spi_sclk_0 = apb_soc_top_0_spi_sclk;
  assign spi_ss_n_0 = apb_soc_top_0_spi_ss_n;
  RiscV_BD_ALU_OPER_0_0 ALU_OPER_0
       (.alu_in_1(alu_muxes_0_alu_input_1),
        .alu_in_2(alu_muxes_0_alu_input_2),
        .alu_oper(alu_muxes_0_ALU_op),
        .alu_out(ALU_OPER_0_alu_out),
        .branch_E(alu_muxes_0_alu_branch),
        .branch_condi(ALU_OPER_0_branch_condi),
        .clk(clk_0_1),
        .rst(reset_0_1));
  RiscV_BD_EX_MA_PR_0_0 EX_MA_PR_0
       (.ALU_result_E(two_in32bitmix_0_out),
        .ALU_result_M(EX_MA_PR_0_ALU_result_M),
        .CSR_Rdata_E(ID_EX_PR_0_CSR_Rdata_E),
        .CSR_Rdata_M(EX_MA_PR_0_CSR_Rdata_M),
        .Ex_Imm_E(ID_EX_PR_0_Ex_Imm_E),
        .Ex_Imm_M(EX_MA_PR_0_Ex_Imm_M),
        .PC_plus4_E(ID_EX_PR_0_PC_plus4_E),
        .PC_plus4_M(EX_MA_PR_0_PC_plus4_M),
        .RD_E(ID_EX_PR_0_RD_E),
        .RD_M(EX_MA_PR_0_RD_M),
        .Result_src_E(ID_EX_PR_0_Result_src_E),
        .Result_src_M(EX_MA_PR_0_Result_src_M),
        .clk(clk_0_1),
        .inst_retired_E(instr_retire_mux_0_instr_retired_out),
        .inst_retired_M(EX_MA_PR_0_inst_retired_M),
        .load_peripharal_E(ID_EX_PR_0_load_peripheral_E),
        .load_peripharal_M(EX_MA_PR_0_load_peripharal_M),
        .load_src_E(ID_EX_PR_0_load_src_E),
        .load_src_M(EX_MA_PR_0_load_src_M),
        .mem_write_E(ID_EX_PR_0_mem_write_E),
        .mem_write_M(EX_MA_PR_0_mem_write_M),
        .peripheral_wen_E(ID_EX_PR_0_peripheral_wen_E),
        .peripheral_wen_M(EX_MA_PR_0_peripheral_wen_M),
        .proces_req_E(ID_EX_PR_0_processer_req_E),
        .proces_req_M(EX_MA_PR_0_proces_req_M),
        .reg_write_E(ID_EX_PR_0_Reg_write_E),
        .reg_write_M(EX_MA_PR_0_reg_write_M),
        .rst(reset_0_1),
        .stall_E(hazard_unit_0_stall_exmem),
        .write_data_E(forwarding_mux_0_rs2),
        .write_data_M(EX_MA_PR_0_write_data_M));
  RiscV_BD_ID_EX_PR_0_0 ID_EX_PR_0
       (.CSR_Rdata_D(csr_0_csr_rdata),
        .CSR_Rdata_E(ID_EX_PR_0_CSR_Rdata_E),
        .Ex_Imm_D(imm_extend_0_imm_out),
        .Ex_Imm_E(ID_EX_PR_0_Ex_Imm_E),
        .PC_D(IF_ID_PR_0_PC_D),
        .PC_E(ID_EX_PR_0_PC_E),
        .PC_plus4_D(IF_ID_PR_0_PC_plus4_D),
        .PC_plus4_E(ID_EX_PR_0_PC_plus4_E),
        .RD1_D(register_file_0_rd_data1),
        .RD1_E(ID_EX_PR_0_RD1_E),
        .RD2_D(register_file_0_rd_data2),
        .RD2_E(ID_EX_PR_0_RD2_E),
        .RD_D(IF_ID_PR_0_Rd_D),
        .RD_E(ID_EX_PR_0_RD_E),
        .RS1_D(IF_ID_PR_0_Rs1_D),
        .RS1_E(ID_EX_PR_0_RS1_E),
        .RS2_D(IF_ID_PR_0_Rs2_D),
        .RS2_E(ID_EX_PR_0_RS2_E),
        .Reg_write_D(controller_0_RegWrite),
        .Reg_write_E(ID_EX_PR_0_Reg_write_E),
        .Result_src_D(controller_0_ResultSrc),
        .Result_src_E(ID_EX_PR_0_Result_src_E),
        .alu_op_ctrl_D(controller_0_ALUOpCtrl),
        .alu_op_ctrl_E(ID_EX_PR_0_alu_op_ctrl_E),
        .alu_src_D(controller_0_ALUSrc),
        .alu_src_E(ID_EX_PR_0_alu_src_E),
        .branch_D(controller_0_Branch),
        .branch_E(ID_EX_PR_0_branch_E),
        .clk(clk_0_1),
        .fix_P_mux_D(controller_0_fixed_pMUX),
        .fix_P_mux_E(ID_EX_PR_0_fix_P_mux_E),
        .flush_D(hazard_unit_0_flushe),
        .inst_retired_D(controller_0_instr_retired),
        .inst_retired_E(ID_EX_PR_0_inst_retired_E),
        .jump_D(controller_0_Jump),
        .jump_E(ID_EX_PR_0_jump_E),
        .load_peripharal_D(controller_0_peripheral_load),
        .load_peripheral_E(ID_EX_PR_0_load_peripheral_E),
        .load_src_D(controller_0_load_src),
        .load_src_E(ID_EX_PR_0_load_src_E),
        .mem2reg_D(controller_0_mem2reg),
        .mem2reg_E(ID_EX_PR_0_mem2reg_E),
        .mem_write_D(controller_0_MemWrite),
        .mem_write_E(ID_EX_PR_0_mem_write_E),
        .peripheral_wen_D(controller_0_processor_wen),
        .peripheral_wen_E(ID_EX_PR_0_peripheral_wen_E),
        .processer_req_D(controller_0_processor_request),
        .processer_req_E(ID_EX_PR_0_processer_req_E),
        .rst(reset_0_1),
        .stall_D(hazard_unit_0_stall_idex));
  RiscV_BD_IF_ID_PR_0_0 IF_ID_PR_0
       (.Imm_D(IF_ID_PR_0_Imm_D),
        .Inst_F(instr_mem_0_instr),
        .PC_D(IF_ID_PR_0_PC_D),
        .PC_F(pc_0_pc_f),
        .PC_plus4_D(IF_ID_PR_0_PC_plus4_D),
        .PC_plus4_F(pc_0_pc_inc),
        .Rd_D(IF_ID_PR_0_Rd_D),
        .Rs1_D(IF_ID_PR_0_Rs1_D),
        .Rs2_D(IF_ID_PR_0_Rs2_D),
        .clk(clk_0_1),
        .csr_add_D(IF_ID_PR_0_csr_add_D),
        .flush_F(hazard_unit_0_flushd),
        .funct3_D(IF_ID_PR_0_funct3_D),
        .funct7_D(IF_ID_PR_0_funct7_D),
        .opcode(IF_ID_PR_0_opcode),
        .rst(reset_0_1),
        .stall_F(hazard_unit_0_stall_ifid));
  RiscV_BD_MA_WB_PR_0_0 MA_WB_PR_0
       (.CSR_Rdata_M(EX_MA_PR_0_CSR_Rdata_M),
        .CSR_Rdata_W(MA_WB_PR_0_CSR_Rdata_W),
        .Ex_imm_M(EX_MA_PR_0_Ex_Imm_M),
        .Ex_imm_W(MA_WB_PR_0_Ex_imm_W),
        .PC_plus4_M(EX_MA_PR_0_PC_plus4_M),
        .PC_plus4_W(MA_WB_PR_0_PC_plus4_W),
        .RD_M(EX_MA_PR_0_RD_M),
        .RD_W(MA_WB_PR_0_RD_W),
        .Reg_write_M(EX_MA_PR_0_reg_write_M),
        .Reg_write_W(MA_WB_PR_0_Reg_write_W),
        .alu_result_M(EX_MA_PR_0_ALU_result_M),
        .alu_result_W(MA_WB_PR_0_alu_result_W),
        .clk(clk_0_1),
        .inst_retired_M(EX_MA_PR_0_inst_retired_M),
        .inst_retired_W(MA_WB_PR_0_inst_retired_W),
        .read_data_M(two_in32bitmix_1_result),
        .read_data_W(MA_WB_PR_0_read_data_W),
        .result_src_M(EX_MA_PR_0_Result_src_M),
        .result_src_W(MA_WB_PR_0_result_src_W),
        .rst(reset_0_1),
        .stall_M(hazard_unit_0_stall_memwb));
  RiscV_BD_Q16_16_Mult_0_0 Q16_16_Mult_0
       (.A(forwarding_mux_0_rs1),
        .B(forwarding_mux_0_rs2),
        .result(Q16_16_Mult_0_result));
  RiscV_BD_Write_back_Mux_0_0 Write_back_Mux_0
       (.Alu_result_W(MA_WB_PR_0_alu_result_W),
        .CSR_rdata_W(MA_WB_PR_0_CSR_Rdata_W),
        .Ex_Imm_W(MA_WB_PR_0_Ex_imm_W),
        .PC_plus4_W(MA_WB_PR_0_PC_plus4_W),
        .Read_data_W(MA_WB_PR_0_read_data_W),
        .W_data(Write_back_Mux_0_W_data),
        .result_src_W(MA_WB_PR_0_result_src_W));
  RiscV_BD_alu_fixed_point_mux_0_0 alu_fixed_point_mux_0
       (.alu_output(ALU_OPER_0_alu_out),
        .final_output(alu_fixed_point_mux_0_final_output),
        .fixed_pmux_E(ID_EX_PR_0_fix_P_mux_E),
        .fixed_point_output(Q16_16_Mult_0_result));
  RiscV_BD_alu_muxes_0_2 alu_muxes_0
       (.ALUOpCtrl(ID_EX_PR_0_alu_op_ctrl_E),
        .ALUSrc(ID_EX_PR_0_alu_src_E),
        .alu_branch(alu_muxes_0_alu_branch),
        .alu_input_1(alu_muxes_0_alu_input_1),
        .alu_input_2(alu_muxes_0_alu_input_2),
        .alu_mux_in(branch_fsm_0_alu_mux_in),
        .alu_mux_sel(branch_fsm_0_alu_mux_sel),
        .alu_op(alu_muxes_0_ALU_op),
        .branch_E(ID_EX_PR_0_branch_E),
        .branch_mux_sel(branch_fsm_0_branch_mux_sel),
        .condition(ALU_OPER_0_branch_condi),
        .condition_mux_sel(branch_fsm_0_condition_mux_sel),
        .condition_out(alu_muxes_0_condition_out),
        .immediate(ID_EX_PR_0_Ex_Imm_E),
        .mux1_in(branch_fsm_0_mux1_in),
        .mux1_sel(branch_fsm_0_mux1_sel),
        .mux2_in(branch_fsm_0_mux2_in),
        .mux2_sel(branch_fsm_0_mux2_sel),
        .pc_Plus_4(ID_EX_PR_0_PC_E),
        .rs1(forwarding_mux_0_rs1),
        .rs2(forwarding_mux_0_rs2));
  RiscV_BD_apb_soc_top_0_0 apb_soc_top_0
       (.clk(clk_0_1),
        .gpio_interrupt(apb_soc_top_0_gpio_interrupt),
        .gpio_pins(gpio_pins_0[15:0]),
        .proc_ack(apb_soc_top_0_proc_ack),
        .proc_addr(EX_MA_PR_0_ALU_result_M),
        .proc_rdata(apb_soc_top_0_proc_rdata),
        .proc_req(EX_MA_PR_0_proces_req_M),
        .proc_wdata(EX_MA_PR_0_Ex_Imm_M),
        .proc_wr_en(EX_MA_PR_0_peripheral_wen_M),
        .rst(reset_0_1),
        .spi_mosi(apb_soc_top_0_spi_mosi),
        .spi_sclk(apb_soc_top_0_spi_sclk),
        .spi_ss_n(apb_soc_top_0_spi_ss_n));
  RiscV_BD_branch_fsm_0_0 branch_fsm_0
       (.alu_mux_in(branch_fsm_0_alu_mux_in),
        .alu_mux_sel(branch_fsm_0_alu_mux_sel),
        .branch(ID_EX_PR_0_branch_E),
        .branch_mux_sel(branch_fsm_0_branch_mux_sel),
        .clk(clk_0_1),
        .condition(ALU_OPER_0_branch_condi),
        .condition_mux_sel(branch_fsm_0_condition_mux_sel),
        .flush_allow(branch_fsm_0_flush_allow),
        .mux1_in(branch_fsm_0_mux1_in),
        .mux1_sel(branch_fsm_0_mux1_sel),
        .mux2_in(branch_fsm_0_mux2_in),
        .mux2_sel(branch_fsm_0_mux2_sel),
        .reset_p(reset_0_1));
  RiscV_BD_combinational_0_0 combinational_0
       (.Branch_E(ID_EX_PR_0_branch_E),
        .condition_out(alu_muxes_0_condition_out),
        .flush_allow(branch_fsm_0_flush_allow),
        .jump_E(ID_EX_PR_0_jump_E),
        .pc_mux_sel0(combinational_0_pc_mux_sel0));
  RiscV_BD_concat_2to1_0_0 concat_2to1_0
       (.conct_out(concat_2to1_0_conct_out),
        .in0(hazard_unit_0_mem_sel_s1),
        .in1(hazard_unit_0_wb_sel_s1));
  RiscV_BD_concat_2to1_1_0 concat_2to1_1
       (.conct_out(concat_2to1_1_conct_out),
        .in0(hazard_unit_0_mem_sel_s2),
        .in1(hazard_unit_0_wb_sel_s2));
  RiscV_BD_concat_2to1_2_0 concat_2to1_2
       (.conct_out(concat_2to1_2_conct_out),
        .in0(combinational_0_pc_mux_sel0),
        .in1(or_gate_1_y));
  RiscV_BD_controller_0_0 controller_0
       (.ALUOpCtrl(controller_0_ALUOpCtrl),
        .ALUSrc(controller_0_ALUSrc),
        .Branch(controller_0_Branch),
        .ImmSrc(controller_0_ImmSrc),
        .Jump(controller_0_Jump),
        .MemWrite(controller_0_MemWrite),
        .RegWrite(controller_0_RegWrite),
        .ResultSrc(controller_0_ResultSrc),
        .csr_op(controller_0_csr_op),
        .csr_wen(controller_0_csr_wen),
        .excep(controller_0_excep),
        .fixed_pMUX(controller_0_fixed_pMUX),
        .funct3(IF_ID_PR_0_funct3_D),
        .funct7(IF_ID_PR_0_funct7_D),
        .instr_retired(controller_0_instr_retired),
        .interrupt_in(apb_soc_top_0_gpio_interrupt),
        .interrupt_out(interrupt_0_1),
        .load_src(controller_0_load_src),
        .mem2reg(controller_0_mem2reg),
        .opcode(IF_ID_PR_0_opcode),
        .peripheral_load(controller_0_peripheral_load),
        .processor_request(controller_0_processor_request),
        .processor_wen(controller_0_processor_wen));
  RiscV_BD_csr_0_0 csr_0
       (.clk(clk_0_1),
        .csr_addr(IF_ID_PR_0_csr_add_D),
        .csr_exc(csr_mux_0_csr_exc),
        .csr_op(controller_0_csr_op),
        .csr_rdata(csr_0_csr_rdata),
        .csr_wen(controller_0_csr_wen),
        .instr_retired(MA_WB_PR_0_inst_retired_W),
        .mepc_out(csr_0_mepc_out),
        .mtvec_out(csr_0_mtvec_out),
        .pc_current(pc_0_pc_inc),
        .rs1_data(register_file_0_rd_data1),
        .rst(reset_0_1));
  RiscV_BD_csr_mux_0_0 csr_mux_0
       (.csr_exc(csr_mux_0_csr_exc),
        .exception(controller_0_excep),
        .interrupt(interrupt_0_1));
  RiscV_BD_data_mem_0_0 data_mem_0
       (.clk(clk_0_1),
        .data_out(data_mem_0_data_out),
        .dmem_addr(EX_MA_PR_0_ALU_result_M),
        .memWrite_en(EX_MA_PR_0_mem_write_M),
        .write_data(EX_MA_PR_0_write_data_M));
  RiscV_BD_forwarding_mux_0_0 forwarding_mux_0
       (.Hazard_mux_sel_1(concat_2to1_0_conct_out),
        .Hazard_mux_sel_2(concat_2to1_1_conct_out),
        .rs1(forwarding_mux_0_rs1),
        .rs1_E(ID_EX_PR_0_RD1_E),
        .rs2(forwarding_mux_0_rs2),
        .rs2_E(ID_EX_PR_0_RD2_E),
        .rs_M(EX_MA_PR_0_ALU_result_M),
        .rs_W(Write_back_Mux_0_W_data));
  RiscV_BD_hazard_unit_0_0 hazard_unit_0
       (.condition_stall(ALU_OPER_0_branch_condi),
        .flushd(hazard_unit_0_flushd),
        .flushe(hazard_unit_0_flushe),
        .jump_branch_flush(combinational_0_pc_mux_sel0),
        .mem_sel_s1(hazard_unit_0_mem_sel_s1),
        .mem_sel_s2(hazard_unit_0_mem_sel_s2),
        .memtoreg(ID_EX_PR_0_mem2reg_E),
        .mul_stall(mul_fsm_0_mul_stall),
        .peripheral_load(EX_MA_PR_0_load_peripharal_M),
        .proc_ack(apb_soc_top_0_proc_ack),
        .processor_request(EX_MA_PR_0_proces_req_M),
        .processor_wen(EX_MA_PR_0_peripheral_wen_M),
        .rdex(ID_EX_PR_0_RD_E),
        .rdmem(EX_MA_PR_0_RD_M),
        .rdwb(MA_WB_PR_0_RD_W),
        .rs1ex(ID_EX_PR_0_RS1_E),
        .rs1id(IF_ID_PR_0_Rs1_D),
        .rs2ex(ID_EX_PR_0_RS2_E),
        .rs2id(IF_ID_PR_0_Rs2_D),
        .stall_exmem(hazard_unit_0_stall_exmem),
        .stall_idex(hazard_unit_0_stall_idex),
        .stall_ifid(hazard_unit_0_stall_ifid),
        .stall_memwb(hazard_unit_0_stall_memwb),
        .stall_pc(hazard_unit_0_stall_pc),
        .wb_sel_s1(hazard_unit_0_wb_sel_s1),
        .wb_sel_s2(hazard_unit_0_wb_sel_s2));
  RiscV_BD_ila_0_0 ila_0
       (.clk(clk_0_1),
        .probe0(reset_0_1),
        .probe1(pc_0_pc_f),
        .probe10(imm_extend_0_imm_out),
        .probe11(IF_ID_PR_0_csr_add_D),
        .probe12(controller_0_Jump),
        .probe13(controller_0_Branch),
        .probe14(controller_0_csr_op),
        .probe15(controller_0_excep),
        .probe16(csr_0_csr_rdata),
        .probe17(csr_0_mepc_out),
        .probe18(csr_0_mtvec_out),
        .probe19(alu_muxes_0_alu_input_1),
        .probe2(instr_mem_0_instr),
        .probe20(alu_muxes_0_alu_input_2),
        .probe21(two_in32bitmix_0_out),
        .probe22(forwarding_mux_0_rs1),
        .probe23(forwarding_mux_0_rs2),
        .probe24(Q16_16_Mult_0_result),
        .probe25(EX_MA_PR_0_write_data_M),
        .probe26(data_mem_0_data_out),
        .probe27(EX_MA_PR_0_ALU_result_M),
        .probe28(EX_MA_PR_0_Ex_Imm_M),
        .probe29(EX_MA_PR_0_peripheral_wen_M),
        .probe3(IF_ID_PR_0_opcode),
        .probe30(EX_MA_PR_0_proces_req_M),
        .probe31(apb_soc_top_0_proc_rdata),
        .probe32(apb_soc_top_0_proc_ack),
        .probe33(apb_soc_top_0_gpio_interrupt),
        .probe34(hazard_unit_0_stall_pc),
        .probe35(hazard_unit_0_stall_ifid),
        .probe36(hazard_unit_0_stall_idex),
        .probe37(hazard_unit_0_stall_exmem),
        .probe38(hazard_unit_0_stall_memwb),
        .probe39(hazard_unit_0_flushe),
        .probe4(IF_ID_PR_0_Rs1_D),
        .probe40(hazard_unit_0_flushd),
        .probe5(register_file_0_rd_data1),
        .probe6(IF_ID_PR_0_Rs2_D),
        .probe7(register_file_0_rd_data2),
        .probe8(MA_WB_PR_0_RD_W),
        .probe9(Write_back_Mux_0_W_data));
  RiscV_BD_imm_extend_0_0 imm_extend_0
       (.imm_out(imm_extend_0_imm_out),
        .imm_type_in(controller_0_ImmSrc),
        .instr_in(IF_ID_PR_0_Imm_D));
  RiscV_BD_instr_mem_0_0 instr_mem_0
       (.addr(pc_0_pc_f),
        .instr(instr_mem_0_instr));
  RiscV_BD_instr_retire_mux_0_0 instr_retire_mux_0
       (.instr_retired(ID_EX_PR_0_inst_retired_E),
        .instr_retired_out(instr_retire_mux_0_instr_retired_out),
        .instr_stalled(hazard_unit_0_stall_idex));
  RiscV_BD_load_extend_0_0 load_extend_0
       (.load_src_M(EX_MA_PR_0_load_src_M),
        .mem_data(data_mem_0_data_out),
        .read_data_M(load_extend_0_read_data_M));
  RiscV_BD_mul_fsm_0_0 mul_fsm_0
       (.alu_op(ID_EX_PR_0_alu_op_ctrl_E),
        .clk(clk_0_1),
        .mul_stall(mul_fsm_0_mul_stall),
        .reset_p(reset_0_1));
  RiscV_BD_or_gate_1_0 or_gate_1
       (.a(interrupt_0_1),
        .b(controller_0_excep),
        .y(or_gate_1_y));
  RiscV_BD_pc_0_0 pc_0
       (.clk(clk_0_1),
        .pc_alu(alu_fixed_point_mux_0_final_output),
        .pc_f(pc_0_pc_f),
        .pc_inc(pc_0_pc_inc),
        .pc_mepc(csr_0_mepc_out),
        .pc_mtvec(csr_0_mtvec_out),
        .pc_mux_sel(concat_2to1_2_conct_out),
        .reset(reset_0_1),
        .stall(hazard_unit_0_stall_pc));
  RiscV_BD_register_file_0_0 register_file_0
       (.clk(clk_0_1),
        .rd(MA_WB_PR_0_RD_W),
        .rd_data1(register_file_0_rd_data1),
        .rd_data2(register_file_0_rd_data2),
        .reg_write(MA_WB_PR_0_Reg_write_W),
        .rs1(IF_ID_PR_0_Rs1_D),
        .rs2(IF_ID_PR_0_Rs2_D),
        .syn_rst(reset_0_1),
        .wr_data(Write_back_Mux_0_W_data));
  RiscV_BD_two_in32bitmix_0_0 two_in32bitmix_0
       (.in1(ID_EX_PR_0_RD1_E),
        .in2(alu_fixed_point_mux_0_final_output),
        .result(two_in32bitmix_0_out),
        .sel(ID_EX_PR_0_processer_req_E));
  RiscV_BD_two_in32bitmix_1_0 two_in32bitmix_1
       (.in1(apb_soc_top_0_proc_rdata),
        .in2(load_extend_0_read_data_M),
        .result(two_in32bitmix_1_result),
        .sel(apb_soc_top_0_proc_ack));
endmodule
