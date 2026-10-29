module sky130_fd_sc_hd__dfrtp_1 (input CLK, input D, input RESET_B, output reg Q);
  always @(posedge CLK or negedge RESET_B)
    if (!RESET_B) Q <= 1'b0; else Q <= D;
endmodule

module sky130_fd_sc_hd__nor2_1 (input A, input B, output Y);
  assign Y = ~(A | B);
endmodule

module sky130_fd_sc_hd__nor2b_1 (input A, input B_N, output Y);
  assign Y = ~(A | ~B_N);
endmodule

module sky130_fd_sc_hd__clkinv_1 (input A, output Y);
  assign Y = ~A;
endmodule