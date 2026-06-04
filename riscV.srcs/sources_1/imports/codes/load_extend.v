module load_extend (

    input [31:0] mem_data ,
    input [2:0] load_src_M,
    output reg [31:0] read_data_M
    );

always@(*) begin
case(load_src_M)

3'b000 : read_data_M = mem_data[31:0];                       // load word
3'b001 : read_data_M = {{16{mem_data[15]}},mem_data[15:0]};  //load half signed
3'b010 : read_data_M = {{16{1'b0}},mem_data[15:0]};          // load half unsigned
3'b011 : read_data_M = {{24{mem_data[7]}},mem_data[7:0]};    // load byte
3'b100 : read_data_M = {{24{1'b0}},mem_data[7:0]};           // load byte unsigned
default : read_data_M = mem_data[31:0];                      // default to word load (no extension)

endcase
end

endmodule