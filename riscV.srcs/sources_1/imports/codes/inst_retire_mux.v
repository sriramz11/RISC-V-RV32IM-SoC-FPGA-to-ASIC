module instr_retire_mux (
    input wire instr_stalled,
    input wire instr_retired,
    output wire instr_retired_out
);

assign instr_retired_out = instr_stalled ? 1'b0 : instr_retired;

endmodule