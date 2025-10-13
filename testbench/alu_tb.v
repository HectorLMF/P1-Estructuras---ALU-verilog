`timescale 1ns/1ps

module tb_alu;
    reg [3:0] A;
    reg [3:0] B;
    reg c_in;
    reg [2:0] Op;
    wire [3:0] R;
    wire zero;
    wire carry;
    wire sign;

    integer i,j,k,l;
    integer errors;
    integer checks;

    // Instantiate ALU
    alu uut(.R(R), .zero(zero), .carry(carry), .sign(sign), .A(A), .B(B), .c_in(c_in), .Op(Op));

    initial begin
        $dumpfile("vcd/alu_tb.vcd");
        // dump top-level I/O and result flags
        $dumpvars(0, tb_alu.A, tb_alu.B, tb_alu.c_in, tb_alu.Op, tb_alu.R, tb_alu.zero, tb_alu.sign, tb_alu.carry);

        errors = 0;
        checks = 0;

        // Exhaustive sweep: A=0..15, B=0..15, Op=0..7, c_in=0..1
        for (i = 0; i < 16; i = i + 1) begin
            A = i[3:0];
            for (j = 0; j < 16; j = j + 1) begin
                B = j[3:0];
                for (k = 0; k < 8; k = k + 1) begin
                    Op = k[2:0];
                    for (l = 0; l < 2; l = l + 1) begin
                        c_in = l[0];

                        #1; // let DUT settle

                        // Basic checks
                        checks = checks + 1;
                        // zero flag should be 1 if R == 0
                        if (zero !== (R == 4'b0000)) begin
                            $display("%0t ERROR: zero flag mismatch: Op=%b A=%b B=%b c_in=%b R=%b zero=%b expected=%b", $time, Op, A, B, c_in, R, zero, (R == 4'b0000));
                            errors = errors + 1;
                        end
                        // sign flag should be MSB of R
                        if (sign !== R[3]) begin
                            $display("%0t ERROR: sign flag mismatch: Op=%b A=%b B=%b c_in=%b R=%b sign=%b expected=%b", $time, Op, A, B, c_in, R, sign, R[3]);
                            errors = errors + 1;
                        end

                    end
                end
            end
        end

        $display("ALU test finished: %0d checks, %0d errors", checks, errors);
        $finish;
    end

endmodule
