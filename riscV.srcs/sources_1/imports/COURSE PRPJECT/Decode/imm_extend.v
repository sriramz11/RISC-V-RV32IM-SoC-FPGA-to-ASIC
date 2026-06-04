module imm_extend (
input [31:7]instr_in,
input [2:0]imm_type_in,
output reg[31:0]imm_out
);

always @(*) begin

case(imm_type_in)

3'b000 : imm_out = {{20{instr_in[31]}},instr_in[31:20]};  //i-type
3'b001 : imm_out = {{20{instr_in[31]}},instr_in[31:25],instr_in[11:7]}; //s-type
3'b010 : imm_out = {{19{instr_in[31]}},instr_in[7],instr_in[30:25],instr_in[11:8],1'b0}; //b-type
3'b011 : imm_out = {instr_in[31:12],12'h000};                                            //u-type
3'b100 : imm_out = {{11{instr_in[31]}},instr_in[19:12],instr_in[20],instr_in[30:21],1'b0}; //j-type
3'b101 : imm_out = {{17{1'b0}},instr_in[31:20],instr_in[14:12]};  //new type for peripheral access, zero-extended
default : imm_out = 32'b0; // default to zero for unsupported types

endcase
end
endmodule