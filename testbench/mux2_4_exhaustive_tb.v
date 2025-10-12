`timescale 1ns/1ps

module tb_mux2_4_exhaustive;
    reg [3:0] A;
    reg [3:0] B;
    reg s;
    wire [3:0] Out;

    integer i;
    integer errors;
    integer checks;

    // Instantiate unit under test
    mux2_4 uut(.Out(Out), .A(A), .B(B), .s(s));

    initial begin
        $dumpfile("vcd/mux2_4_exhaustive_tb.vcd");
        $dumpvars(0, tb_mux2_4_exhaustive);

        errors = 0;
        checks = 0;

        // Iterate all 4-bit combinations for A
        for (i = 0; i < 16; i = i + 1) begin
            A = i[3:0];
            // B is ones' complement of A (invert all bits)
            B = ~A;

            // First, s = 0 -> Out should be A
            s = 0; #10;
            checks = checks + 1;
            if (Out !== A) begin
                $display("%0t ERROR: A=%b s=0 Out=%b expected=%b", $time, A, Out, A);
                errors = errors + 1;
            end else begin
                $display("%0t OK: A=%b s=0 Out=%b", $time, A, Out);
            end

            // Then, s = 1 -> Out should be B (ones' complement)
            s = 1; #10;
            checks = checks + 1;
            if (Out !== B) begin
                $display("%0t ERROR: A=%b s=1 Out=%b expected=%b", $time, A, Out, B);
                errors = errors + 1;
            end else begin
                $display("%0t OK: A=%b s=1 Out=%b (B=%b)", $time, A, Out, B);
            end
        end

        $display("Exhaustive test finished: %0d checks, %0d errors", checks, errors);
        $finish;
    end

endmodule
