`timescale 1ps/1ps

module fsm_traffic_tb;
    reg clk = 0;
    reg rst = 1;
    wire [1:0] state; // Ուղղեցինք չափը [1:0], որ համապատասխանի DUT-ին
    wire [1:0] light; // Ավելացրեցինք նաև light ելքը, որ հետևենք լուսացույցին

    // Միացնում ենք DUT-ին (Device Under Test)
    fsm_traffic dut(
        .clk(clk),
        .rst(rst),
        .light(light),
        .state(state)
    );

    // Clock-ի գեներացիա (ամեն 5նվ-ը մեկ փոխվում է)
    always #5 clk = ~clk;

    integer errors = 0;
    reg [1:0] expected;

    initial begin
        $dumpfile("fsm_traffic_tb.vcd");
        $dumpvars(0, fsm_traffic_tb);

        rst = 1;
        #15 rst = 0;
        expected = 2'b00;

        repeat (9) begin
            @(posedge clk);       // t = 25, 35, 45, ...
            #1;                   // թողնում ենք ելքերին կայունանալ
            case (expected)
                2'b00:   expected = 2'b01;
                2'b01:   expected = 2'b10;
                default: expected = 2'b00;
            endcase
            if (state !== expected) begin
                $display("FAIL t=%0t: state=%b expected=%b", $time, state, expected);
                errors = errors + 1;
            end
        end

        if (errors == 0) $display("PASS: sequence 01->10->00 repeats correctly");
        else             $display("FAIL: %0d mismatches", errors);
        $finish;
    end
endmodule