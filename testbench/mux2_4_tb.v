`timescale 1ns/1ps

module tb_mux2_4;
    reg [3:0] A;
    reg [3:0] B;
    reg s;
    wire [3:0] Out;

    // Instantiate unit under test
    mux2_4 uut(.Out(Out), .A(A), .B(B), .s(s));

    initial begin
        // Write VCD into the local vcd/ directory of the project
        $dumpfile("vcd/mux2_4_tb.vcd");
        $dumpvars(0, tb_mux2_4);
        // Keep A and B constant: A = 0, B = all ones. Vary only 's'.
        A = 4'b0000; B = 4'b1111;

        // Start with s = 0 and check Out == A
        s = 0; #10;
        if (Out !== A) $display("%0t ERROR: s=0 but Out!=A (Out=%b A=%b)", $time, Out, A);
        else $display("%0t OK: s=0 Out==A (%b)", $time, Out);

        // Switch to s = 1 and check Out == B
        s = 1; #10;
        if (Out !== B) $display("%0t ERROR: s=1 but Out!=B (Out=%b B=%b)", $time, Out, B);
        else $display("%0t OK: s=1 Out==B (%b)", $time, Out);

        // Toggle s a few times to exercise switching (inline checks)
        repeat (8) begin
            #5 s = ~s; #5;
            if (s == 0) begin
                if (Out !== A) $display("%0t ERROR: s=0 but Out!=A (Out=%b A=%b)", $time, Out, A);
                else $display("%0t OK: s=0 Out==A (%b)", $time, Out);
            end else begin
                if (Out !== B) $display("%0t ERROR: s=1 but Out!=B (Out=%b B=%b)", $time, Out, B);
                else $display("%0t OK: s=1 Out==B (%b)", $time, Out);
            end
        end

        $display("[%0t] Testbench finished", $time);
        $finish;
    end

endmodule
