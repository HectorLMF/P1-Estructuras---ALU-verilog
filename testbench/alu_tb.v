// Testbench para alu
module alu_tb;
    reg [3:0] A, B;
    reg c_in;
    reg [2:0] Op;
    wire [3:0] R;
    wire zero, carry, sign;
    alu uut(.R(R), .zero(zero), .carry(carry), .sign(sign), .A(A), .B(B), .c_in(c_in), .Op(Op));
    initial begin
        $display("A B c_in Op | R zero carry sign");
        A = 4'b0011; B = 4'b0101; c_in = 0;
        Op = 3'b000; #10; $display("SUMA: %b %b %b %b | %b %b %b %b", A, B, c_in, Op, R, zero, carry, sign);
        Op = 3'b001; #10; $display("INC A: %b", R);
        Op = 3'b010; #10; $display("NEG A: %b", R);
        Op = 3'b011; #10; $display("NEG B: %b", R);
        Op = 3'b100; #10; $display("AND: %b", R);
        Op = 3'b101; #10; $display("OR: %b", R);
        Op = 3'b110; #10; $display("XOR: %b", R);
        Op = 3'b111; #10; $display("NOT A: %b", R);
        $finish;
    end
endmodule
