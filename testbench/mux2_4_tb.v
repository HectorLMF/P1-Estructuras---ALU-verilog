// Testbench para mux2_4
module mux2_4_tb;
    reg [3:0] A, B;
    reg s;
    wire [3:0] Out;
    mux2_4 uut(.Out(Out), .A(A), .B(B), .s(s));
    initial begin
        $display("A B s | Out");
        A = 4'b1010; B = 4'b0101; s = 0; #10;
        $display("%b %b %b | %b", A, B, s, Out);
        s = 1; #10;
        $display("%b %b %b | %b", A, B, s, Out);
        $finish;
    end
endmodule
