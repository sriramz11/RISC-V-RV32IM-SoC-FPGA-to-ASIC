`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 19.03.2026 15:35:25
//// Design Name: 
//// Module Name: controller
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//// =============================================================================
////  Combinational Controller - RISC-V RV32IM + CSR + Fixed-Point Extension
////
////  Inputs  : opcode[6:0], funct3[2:0], funct7[6:0]
////  Outputs : RegWrite, ResultSrc[2:0], MemWrite, Jump, Branch,
////             ALUOpCtrl[3:0], ALUSrc[1:0], ImmSrc[2:0], excep, interrupt,
////             csr_op[1:0], csr_wen, instr_retired,
////             fixed_pMUX, load_src[2:0]
//// =============================================================================

module controller (
    input  wire [6:0] opcode,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    input  wire interrupt_in,

    // Register file
    output reg        RegWrite,

    // Result mux: 000-ALU, 001-Mem, 010-Imm, 011-PC+4, 100-CSR_rdata
    output reg  [2:0] ResultSrc,

    // Memory
    output reg        MemWrite,

    // PC control
    output reg        Jump,
    output reg        Branch,

    // ALU
    output reg  [3:0] ALUOpCtrl,

    // ALU source:  [0]: 0=Rs2  1=Imm
    //              [1]: 0=Rs1  1=PC
    output reg  [1:0] ALUSrc,

    // Immediate format: 000=I, 001=S, 010=B, 011=U, 100=J
    output reg  [2:0] ImmSrc,

    //  exception / interrupt
    output reg        excep,
    output reg       interrupt_out,

    // CSR write-data mux:
    //   00 = rs1_data
    //   01 = csr_rdata | rs1_data
    //   10 = csr_rdata & ~rs1_data
    output reg  [1:0] csr_op,
    output reg        csr_wen,

    // Misc
    output reg        instr_retired,
    output reg        fixed_pMUX,      // 1 = fixed-point multiply result
    output reg  [2:0] load_src ,       // load width/sign: 000=LW,001=LH,010=LHU,011=LB,100=LBU
    output reg        mem2reg,
    output reg        processor_request,
    output reg        processor_wen,
    output reg        peripheral_load


);

    // -------------------------------------------------------------------------
    // Opcode constants
    // -------------------------------------------------------------------------
    localparam OP_RTYPE   = 7'b0110011;   // R-type ALU + M-ext
    localparam OP_IALU    = 7'b0010011;   // I-type ALU-immediate
    localparam OP_LOAD    = 7'b0000011;   // Load
    localparam OP_STORE   = 7'b0100011;   // Store
    localparam OP_BRANCH  = 7'b1100011;   // Branch
    localparam OP_JALR    = 7'b1100111;   // JALR
    localparam OP_JAL     = 7'b1101111;   // JAL
    localparam OP_LUI     = 7'b0110111;   // LUI
    localparam OP_AUIPC   = 7'b0010111;   // AUIPC
    localparam OP_SYSTEM  = 7'b1110011;   // SYSTEM (CSR)
    localparam OP_CUSTOM0 = 7'b0000001;   // Custom: q16.16 fixed-point multiply (INM)
    localparam OP_LOAD_PERI    = 7'b1111111;   
    localparam OP_STORE_PERI   = 7'b1111110;


  
    // -------------------------------------------------------------------------
    // Combinational decode
    // -------------------------------------------------------------------------
    
    always @(*) begin
        // ----- safe defaults -----
 
        RegWrite     = 1'b0;
        ResultSrc    = 3'b000;
        MemWrite     = 1'b0;
        Jump         = 1'b0;
        Branch       = 1'b0;
        ALUOpCtrl    = 4'b0000;
        ALUSrc       = 2'b00;
        ImmSrc       = 3'b000;
        excep        = 1'b0;
        csr_op       = 2'b00;
        csr_wen      = 1'b0;
        instr_retired= 1'b1;   // retire every valid instruction
        fixed_pMUX   = 1'b0;
        load_src     = 3'b000;
        mem2reg      = 1'b0;
        processor_request = 1'b0;
        processor_wen = 1'b0;
        peripheral_load = 1'b0;
        
        interrupt_out = interrupt_in ;

        case (opcode)

            // =================================================================
            // R-Type  (0110011)
            // =================================================================
            OP_RTYPE: begin
                RegWrite  = 1'b1;
                ResultSrc = 3'b000;   // ALU result
                MemWrite  = 1'b0;
                Jump      = 1'b0;
                Branch    = 1'b0;
                ALUSrc    = 2'b00;    // Rs1 / Rs2
                ImmSrc    = 3'b000;   // don't care - no immediate used
                excep         = 1'b0;

                if (funct7 == 7'b0000001) begin
                    // ---- M-Extension: funct7=0000001 ----
                    // All M-ops share the same control signals;
                    // the multiplier unit is selected by ALUOpCtrl=1010
                    ALUOpCtrl = 4'b1010;   // MUL (lower 32-bit product)
                end else begin
                    // ---- Base R-Type ----
                    case ({funct7[5], funct3})   // use bit[5] of funct7 as SUB/SRA discriminator
                        4'b0_000: ALUOpCtrl = 4'b0000; // ADD
                        4'b1_000: ALUOpCtrl = 4'b0001; // SUB
                        4'b0_001: ALUOpCtrl = 4'b0010; // SLL
                        4'b0_010: ALUOpCtrl = 4'b0011; // SLT
                        4'b0_011: ALUOpCtrl = 4'b0100; // SLTU
                        4'b0_100: ALUOpCtrl = 4'b0101; // XOR
                        4'b0_101: ALUOpCtrl = 4'b0110; // SRL
                        4'b1_101: ALUOpCtrl = 4'b0111; // SRA
                        4'b0_110: ALUOpCtrl = 4'b1000; // OR
                        4'b0_111: ALUOpCtrl = 4'b1001; // AND
                        default:  ALUOpCtrl = 4'b0000;
                    endcase
                end
            end

            // =================================================================
            // I-Type ALU-Immediate  (0010011)
            // =================================================================
            OP_IALU: begin
                RegWrite  = 1'b1;
                ResultSrc = 3'b000;   // ALU result
                MemWrite  = 1'b0;
                Jump      = 1'b0;
                Branch    = 1'b0;
                ALUSrc    = 2'b01;    // [0]=1 ? Imm; [1]=0 ? Rs1
                ImmSrc    = 3'b000;   // I-type
                excep         = 1'b0;

                case (funct3)
                    3'b000: ALUOpCtrl = 4'b0000; // ADDI
                    3'b010: ALUOpCtrl = 4'b0011; // SLTI
                    3'b011: ALUOpCtrl = 4'b0100; // SLTIU
                    3'b100: ALUOpCtrl = 4'b0101; // XORI
                    3'b110: ALUOpCtrl = 4'b1000; // ORI
                    3'b111: ALUOpCtrl = 4'b1001; // ANDI
                    3'b001: ALUOpCtrl = 4'b0010; // SLLI  (funct7=0000000)
                    3'b101: begin
                        // SRLI (funct7=0000000) vs SRAI (funct7=0100000)
                        if (funct7[5])
                            ALUOpCtrl = 4'b0111; // SRAI
                        else
                            ALUOpCtrl = 4'b0110; // SRLI
                    end
                    default: ALUOpCtrl = 4'b0000;
                endcase
            end

            // =================================================================
            // Load  (0000011)
            // =================================================================
            OP_LOAD: begin
                RegWrite  = 1'b1;
                ResultSrc = 3'b001;   // Memory data
                MemWrite  = 1'b0;
                Jump      = 1'b0;
                Branch    = 1'b0;
                ALUOpCtrl = 4'b0000;  // ADD  (address = rs1 + imm)
                ALUSrc    = 2'b01;    // Imm
                ImmSrc    = 3'b000;   // I-type
                excep     = 1'b0;
                mem2reg   = 1'b1;

                // load_src selects width/sign extension in the memory interface
                case (funct3)
                    3'b010: load_src = 3'b000; // LW
                    3'b001: load_src = 3'b001; // LH  (sign-extend)
                    3'b101: load_src = 3'b010; // LHU (zero-extend)
                    3'b000: load_src = 3'b011; // LB  (sign-extend)
                    3'b100: load_src = 3'b100; // LBU (zero-extend)
                    default: load_src = 3'b000;
                endcase
            end

            // =================================================================
            // Store  (0100011)
            // =================================================================
            OP_STORE: begin
                RegWrite  = 1'b0;
                MemWrite  = 1'b1;
                Jump      = 1'b0;
                Branch    = 1'b0;
                ALUOpCtrl = 4'b0000;  // ADD  (address = rs1 + imm)
                ALUSrc    = 2'b01;    // Imm
                ImmSrc    = 3'b001;   // S-type
                ResultSrc = 3'b000;   // don't care (no writeback)
                excep         = 1'b0;
            end

            // =================================================================
            // Branch  (1100011)
            // =================================================================
            OP_BRANCH: begin
                RegWrite  = 1'b0;
                MemWrite  = 1'b0;
                Jump      = 1'b0;
                Branch    = 1'b1;
                ALUSrc    = 2'b00;    // Rs1 / Rs2
                ImmSrc    = 3'b010;   // B-type
                ResultSrc = 3'b000;   // don't care
                excep         = 1'b0;
                // ALUOpCtrl encodes the comparison for the branch condition
                case (funct3)
                    3'b000: ALUOpCtrl = 4'b0000; // BEQ  - SUB, check zero
                    3'b001: ALUOpCtrl = 4'b0001; // BNE  - SUB, check !zero
                    3'b100: ALUOpCtrl = 4'b0010; // BLT  - signed less
                    3'b101: ALUOpCtrl = 4'b0011; // BGE  - signed >=
                    3'b110: ALUOpCtrl = 4'b0100; // BLTU - unsigned less
                    3'b111: ALUOpCtrl = 4'b0101; // BGEU - unsigned >=
                    default: ALUOpCtrl = 4'b0000;
                endcase
            end

            // =================================================================
            // JALR  (1100111)
            // =================================================================
            OP_JALR: begin
                RegWrite  = 1'b1;
                ResultSrc = 3'b011;   // PC+4
                MemWrite  = 1'b0;
                Jump      = 1'b1;
                Branch    = 1'b0;
                ALUOpCtrl = 4'b0000;  // ADD  (target = rs1 + imm)
                ALUSrc    = 2'b01;    // [0]=1 ? Imm; [1]=0 ? Rs1
                ImmSrc    = 3'b000;   // I-type
                excep         = 1'b0;
            end

            // =================================================================
            // JAL  (1101111)
            // =================================================================
            OP_JAL: begin
                RegWrite  = 1'b1;
                ResultSrc = 3'b011;   // PC+4
                MemWrite  = 1'b0;
                Jump      = 1'b1;
                Branch    = 1'b0;
                ALUOpCtrl = 4'b0000;  // ADD  (target = PC + imm)
                ALUSrc    = 2'b11;    // [0]=1 ? Imm; [1]=1 ? PC
                ImmSrc    = 3'b100;   // J-type
                excep         = 1'b0;
            end

            // =================================================================
            // LUI  (0110111)
            // =================================================================
            OP_LUI: begin
                RegWrite  = 1'b1;
                ResultSrc = 3'b010;   // Immediate (pass-through)
                MemWrite  = 1'b0;
                Jump      = 1'b0;
                Branch    = 1'b0;
                ALUOpCtrl = 4'b0000;  // don't care
                ALUSrc    = 2'b00;    // don't care
                ImmSrc    = 3'b011;   // U-type
                excep         = 1'b0;

            end

            // =================================================================
            // AUIPC  (0010111)
            // =================================================================
            OP_AUIPC: begin
                RegWrite  = 1'b1;
                ResultSrc = 3'b000;   // ALU result (PC + imm)
                MemWrite  = 1'b0;
                Jump      = 1'b0;
                Branch    = 1'b0;
                ALUOpCtrl = 4'b0000;  // ADD
                ALUSrc    = 2'b11;    // [0]=1 ? Imm; [1]=1 ? PC
                ImmSrc    = 3'b011;   // U-type
                excep         = 1'b0;

            end

            // =================================================================
            // SYSTEM / CSR  (1110011)
            // =================================================================
            OP_SYSTEM: begin
                RegWrite      = 1'b1;
                ResultSrc     = 3'b100;   // CSR_rdata ? rd
                MemWrite      = 1'b0;
                Jump          = 1'b0;
                Branch        = 1'b0;
                ALUOpCtrl     = 4'b0000;  // don't care
                ALUSrc        = 2'b00;    // don't care
                ImmSrc        = 3'b000;   // don't care
                csr_wen       = 1'b1;
                instr_retired = 1'b1;
                excep         = 1'b0;
                case (funct3)
                    3'b001: csr_op = 2'b00; // CSRRW  - csr_wdata = rs1_data
                    3'b010: csr_op = 2'b01; // CSRRS  - csr_wdata = csr_rdata | rs1_data
                    3'b011: csr_op = 2'b10; // CSRRC  - csr_wdata = csr_rdata & ~rs1_data
                    default: begin
                        csr_wen = 1'b0;
                    end
                endcase
            end

            // =================================================================
            // Custom-0: q16.16 Fixed-Point Multiply  (0000001) - INM
            // =================================================================
            OP_CUSTOM0: begin
                RegWrite      = 1'b1;
                ResultSrc     = 3'b000;   // ALU/multiplier result
                MemWrite      = 1'b0;
                Jump          = 1'b0;
                Branch        = 1'b0;
                ALUOpCtrl     = 4'b0000;  // don't care - fixed_pMUX selects unit
                ALUSrc        = 2'b00;    // Rs1 / Rs2
                ImmSrc        = 3'b000;   // don't care
                fixed_pMUX    = 1'b1;     // select fixed-point multiplier output
                instr_retired = 1'b1;
                excep         = 1'b0;
            end

            OP_LOAD_PERI: begin
                RegWrite  = 1'b1;
                ResultSrc = 3'b001;   // Memory data
                processor_request = 1'b1; 
                peripheral_load = 1'b1;
               

            end

            OP_STORE_PERI: begin
                ImmSrc    = 3'b101;   // New-type
                processor_request = 1'b1;
                processor_wen = 1'b1;


            end

            // =================================================================
            // Default / illegal instruction
            // =================================================================
            default: begin
                RegWrite      = 1'b0;
                MemWrite      = 1'b0;
                Jump          = 1'b0;
                Branch        = 1'b0;
                instr_retired = 1'b0;
                excep         = (opcode == 7'b0) ? 1'b0: 1'b1;   // signal illegal-instruction exception
            end

        endcase
    end

endmodule