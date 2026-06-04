module csr_mux (
    input wire interrupt,
    input wire exception,
    output wire csr_exc
);
    assign csr_exc = interrupt ? interrupt : exception;
endmodule