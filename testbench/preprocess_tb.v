// Testbench para preprocess
module preprocess_tb;
    reg [3:0] A, B;
    reg [2:0] Op;
    wire [3:0] AMod, BMod;
    preprocess uut(.AMod(AMod), .BMod(BMod), .A(A), .B(B), .Op(Op));
    initial begin
        $display("A B Op | AMod BMod");
        A = 4'b0011; B = 4'b0101;
        Op = 3'b000; #10; $display("%b %b %b | %b %b", A, B, Op, AMod, BMod);
        Op = 3'b001; #10; $display("%b %b %b | %b %b", A, B, Op, AMod, BMod);
        Op = 3'b010; #10; $display("%b %b %b | %b %b", A, B, Op, AMod, BMod);
        Op = 3'b011; #10; $display("%b %b %b | %b %b", A, B, Op, AMod, BMod);
        $finish;
    end
endmodule
