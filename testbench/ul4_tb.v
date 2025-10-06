// Testbench para ul4
module ul4_tb;
    reg [3:0] A, B;
    reg [1:0] S;
    wire [3:0] Out;
    ul4 uut(.Out(Out), .A(A), .B(B), .S(S));
    initial begin
        $display("A B S | Out");
        A = 4'b1100; B = 4'b1010;
        S = 2'b00; #10; $display("AND: %b", Out);
        S = 2'b01; #10; $display("OR: %b", Out);
        S = 2'b10; #10; $display("XOR: %b", Out);
        S = 2'b11; #10; $display("NOT A: %b", Out);
        $finish;
    end
endmodule
