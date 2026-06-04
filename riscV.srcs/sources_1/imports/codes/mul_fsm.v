module mul_fsm (
    input  wire clk,
    input  wire [3:0] alu_op,
    input  wire reset_p,
    output reg mul_stall
             
    );

   parameter IDLE = 2'b00;
   parameter mul_stage_1 = 2'b01;
   parameter mul_stage_2 = 2'b10;


    reg [1:0] current_state;
    reg [1:0] next_state;

     // State Register

     always @(posedge clk) begin
     if (reset_p)
        current_state <= IDLE ;
     else
        current_state <= next_state;
    end

    // Next State Logic
    always @(*) begin
         next_state = current_state; // Default state
            mul_stall = 0; // Default: no stall

        case (current_state)

            IDLE: begin
                  if (alu_op == 4'b1010) begin
                     next_state = mul_stage_1;
                     mul_stall = 1;
                  end
             end

            mul_stage_1: begin
                next_state = mul_stage_2;
                mul_stall = 1; // Stall the pipeline 
            end

            mul_stage_2: begin
                next_state = IDLE;
                mul_stall = 0; // Stall the pipeline 
            end


            default: next_state = IDLE;

        endcase
    end


        
endmodule