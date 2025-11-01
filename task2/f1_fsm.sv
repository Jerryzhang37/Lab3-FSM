module f1_fsm (
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    output  logic [7:0] data_out
);

//define states 
typedef enum {IDLE, S1, S2, S3, S4, S5, S6, S7, S8} my_state;
my_state current_state, next_state;
always_ff @(posedge clk, posedge rst)
    if(rst) current_state <= IDLE;
    else    current_state <= next_state;

always_comb 
    case(current_state)
        IDLE: if (en) next_state = S1;
        S1:   if (en) next_state = S2;
        S2:   if (en) next_state = S3;
        S3:   if (en) next_state = S4;
        S4:   if (en) next_state = S5;
        S5:   if (en) next_state = S6;
        S6:   if (en) next_state = S7;
        S7:   if (en) next_state = S8;
        S8:   if (en) next_state = IDLE;
    endcase

always_comb
    case(current_state)
        IDLE: data_out = 8'b0000_0000;
        S1:   data_out = 8'b0000_0001;
        S2:   data_out = 8'b0000_0011;
        S3:   data_out = 8'b0000_0111;
        S4:   data_out = 8'b0000_1111;
        S5:   data_out = 8'b0001_1111;
        S6:   data_out = 8'b0011_1111;
        S7:   data_out = 8'b0111_1111;
        S8:   data_out = 8'b1111_1111;
        default: data_out = 8'b0000_0000;
    endcase


endmodule
