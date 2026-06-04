module branch_fsm (
    input wire clk,
    input wire branch,          //input coming from controller that says the current instruction is branch
    input wire condition,       //input coming from the output of alu which says the condition has been met for taking the branch
    input wire reset_p,  

    //we have placed multiplexers which steer signals as needed for branch address calculation to happen
    output reg mux1_sel,       //select line for the mux that selects the alu scr for input1 (i.e either alu src from controller or from this fsm)
    output reg mux2_sel,       //select line for the mux that selects the alu scr for input2 (i.e either alu src from controller or from this fsm)
    output reg mux1_in,        // once the condition is evaluated and the fsm triggers this mux input tells the mux infront of the alu to choose PC as input 1 for the alu 
    output reg mux2_in,        // once the condition is evaluated and the fsm triggers this mux input tells the mux infront of the alu to choose Imm*4 as input 2 for the alu 
    output reg alu_mux_sel,    // the fsm also takes control of the kind of operation the alu must do, this select line is for that mux that shifts the alu op control from controller to what the fsm wants to do
    output reg [3:0] alu_mux_in, // usually the kind of alu operation to be done comes from the controller but here the FSM takes over and tells the alu to perform addition only (since we are doing effective address computation)
    output reg condition_mux_sel, //the condition bit has to be maintained at '1' as long as the address is computed and the pc is incremented this mux helps in doing that
    output reg branch_mux_sel,  //select line for the mux that changes the branch signal to '0' so that the alu performs addition as it does for any other arithmetic instruction

    output wire flush_allow
);

    parameter IDLE    = 1'b0;
    parameter ADD_CALC = 1'b1; 

    reg current_state;
    reg next_state;

    always @(posedge clk) begin
        if (reset_p)
            current_state <= IDLE;
        else 
            current_state <= next_state;
    end

    always @(*) begin
         next_state = current_state;

        case (current_state)

            IDLE: begin
                if (condition && branch)
                    next_state = ADD_CALC;
                else
                    next_state = IDLE;
            end

            ADD_CALC: begin
                next_state = IDLE;
            end

            default: next_state = IDLE;

        endcase
    end

    always @(*) begin

        // default outputs
        mux1_sel = 0;
        mux2_sel = 0;
        mux1_in = 0;
        mux2_in = 0;
        alu_mux_sel = 0;
        alu_mux_in = 4'b0001;
        condition_mux_sel = 0;
        branch_mux_sel = 0;
        
        
        case (current_state)

            ADD_CALC: begin
                mux1_sel = 1;                
                mux2_sel = 1;
                mux1_in = 1;
                mux2_in = 1;
                alu_mux_sel = 1;
                alu_mux_in = 4'b0000;
                condition_mux_sel = 1;
                branch_mux_sel = 1;    
            end

        endcase
    end

    assign flush_allow = (current_state == ADD_CALC);

endmodule