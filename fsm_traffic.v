module fsm_traffic (
    input clk,
    input rst,
    output reg [1:0] light, // 00=Red, 01=Yellow, 10=Green
    output reg [1:0] state  // Ուղղեցինք [1:0], որ համապատասխանի վիճակներին
);

    // Վիճակների հայտարարում
    parameter S_RED    = 2'b00;
    parameter S_GREEN  = 2'b01;
    parameter S_YELLOW = 2'b10;

    reg [1:0] next_state;

    // 1. Հիշողության բլոկ (Sequential Block - State Register)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S_RED; // Անմիջապես փոխանցում ենք ելքային state-ին
        end else begin
            state <= next_state;
        end
    end

    // 2. Հաջորդ վիճակի տրամաբանություն (Combinational Block - Next State Logic)
    always @(*) begin
        case (state)
            S_RED:    next_state = S_GREEN;
            S_GREEN:  next_state = S_YELLOW;
            S_YELLOW: next_state = S_RED;
            default:  next_state = S_RED;
        endcase
    end

    // 3. Ելքերի տրամաբանություն (Output Logic)
    always @(*) begin
        case (state)
            S_RED:    light = 2'b00;
            S_GREEN:  light = 2'b10;
            S_YELLOW: light = 2'b01;
            default:  light = 2'b00;
        endcase
    end

endmodule