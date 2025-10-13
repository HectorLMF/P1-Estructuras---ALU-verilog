`timescale 1ns/1ps

module tb_ul4;
    reg [3:0] A;
    reg [3:0] B;
    reg [1:0] S;
    wire [3:0] Out;

    integer i,j,k;
    integer errors;
    integer checks;
    integer bit;

    // Instantiate unit under test
    ul4 uut(.Out(Out), .A(A), .B(B), .S(S));

    // function to compute expected bit result matching cl behavior
    function expected_cl_bit(input a, input b, input [1:0] s);
        reg o1, o2, o3, o4;
        begin
            o1 = a & b;
            o2 = a | b;
            o3 = a ^ b;
            o4 = ~a;
            case (s)
                2'b00: expected_cl_bit = o1;
                2'b01: expected_cl_bit = o2;
                2'b10: expected_cl_bit = o3;
                default: expected_cl_bit = o4;
            endcase
        end
    endfunction

    initial begin
        $dumpfile("vcd/ul4_tb.vcd");
        $dumpvars(0, tb_ul4);

        errors = 0;
        checks = 0;

        for (i = 0; i < 16; i = i + 1) begin
            A = i[3:0];
            for (j = 0; j < 16; j = j + 1) begin
                B = j[3:0];
                for (k = 0; k < 4; k = k + 1) begin
                    S = k[1:0];
                    #1;

                    // Check each bit
                    for (bit = 0; bit < 4; bit = bit + 1) begin
                        checks = checks + 1;
                        if (Out[bit] !== expected_cl_bit(A[bit], B[bit], S)) begin
                            $display("%0t ERROR: A=%b B=%b S=%b Out[%0d]=%b expected=%b", $time, A, B, S, bit, Out[bit], expected_cl_bit(A[bit], B[bit], S));
                            errors = errors + 1;
                        end
                    end
                end
            end
        end

        $display("ul4 test finished: %0d checks, %0d errors", checks, errors);
        $finish;
    end

endmodule
