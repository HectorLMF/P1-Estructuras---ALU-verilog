`timescale 1ns/1ps

module tb_preprocess;
    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] Op;
    wire [3:0] AMod;
    wire [3:0] BMod;

    integer i,j,k;
    integer errors;
    integer checks;
    // signal aliases and expected regs at module scope
    wire OP2;
    wire OP1;
    wire OP0;
    reg add1Signal;
    reg op1_ASignal;
    reg op2_BSignal;
    reg cplSignal;
    reg [3:0] muxAMuxB;
    reg [3:0] AMod_exp;
    reg [3:0] muxInputCPL;
    reg [3:0] BMod_exp;

    // Instantiate unit under test
    preprocess uut(.AMod(AMod), .BMod(BMod), .A(A), .B(B), .Op(Op));

    // helpers to compute expected values (must match preprocess.v logic)
    function [3:0] expected_muxAdd(input add1);
        expected_muxAdd = add1 ? 4'b1111 : 4'b0000;
    endfunction

    function [3:0] expected_muxOut(input [3:0] muxAMuxB, input [3:0] A_val, input op1);
        expected_muxOut = op1 ? A_val : muxAMuxB;
    endfunction

    function [3:0] expected_muxInput(input [3:0] A_val, input [3:0] B_val, input op2);
        expected_muxInput = op2 ? B_val : A_val;
    endfunction

    initial begin
        $dumpfile("vcd/preprocess_tb.vcd");
        // dump only top-level I/O and results
        $dumpvars(0, tb_preprocess.A, tb_preprocess.B, tb_preprocess.Op, tb_preprocess.AMod, tb_preprocess.BMod);

        errors = 0;
        checks = 0;

        // Simplified test: fix B and iterate Op and A only
        B = 4'b0000;
        for (i = 0; i < 8; i = i + 1) begin
            Op = i[2:0];
            add1Signal = Op[2] | (~Op[2] & ~Op[1] & ~Op[0]);
            op1_ASignal = add1Signal;
            op2_BSignal = Op[2] | (~Op[2] & ~(Op[1] ^ Op[0]));
            cplSignal = ~Op[2] & Op[1];

            for (j = 0; j < 16; j = j + 1) begin
                A = j[3:0];
                #1; // let signals propagate

                // compute expected values (use module-scope regs)
                muxAMuxB = expected_muxAdd(add1Signal);
                AMod_exp = expected_muxOut(muxAMuxB, A, op1_ASignal);
                muxInputCPL = expected_muxInput(A, B, op2_BSignal);
                BMod_exp = cplSignal ? ~muxInputCPL : muxInputCPL;

                checks = checks + 2;
                if (AMod !== AMod_exp) begin
                    $display("%0t ERROR: Op=%b A=%b B=%b AMod=%b expected=%b", $time, Op, A, B, AMod, AMod_exp);
                    errors = errors + 1;
                end
                if (BMod !== BMod_exp) begin
                    $display("%0t ERROR: Op=%b A=%b B=%b BMod=%b expected=%b", $time, Op, A, B, BMod, BMod_exp);
                    errors = errors + 1;
                end
            end
        end

        $display("Simplified preprocess test finished: %0d checks, %0d errors", checks, errors);
        $finish;
    end

endmodule
