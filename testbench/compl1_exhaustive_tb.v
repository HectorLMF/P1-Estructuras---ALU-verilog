`timescale 1ns/1ps

module tb_compl1_exhaustive;
    reg [3:0] Inp;
    reg cpl;
    wire [3:0] Out;

    integer i;
    integer errors;
    integer checks;
    reg [3:0] expected;

    // Instantiate unit under test
    compl1 uut(.Out(Out), .Inp(Inp), .cpl(cpl));

    initial begin
    $dumpfile("vcd/compl1_exhaustive_tb.vcd");
    // Dump only the signals we care about to keep the VCD compact
    $dumpvars(0, tb_compl1_exhaustive.Inp, tb_compl1_exhaustive.cpl, tb_compl1_exhaustive.Out);

        errors = 0;
        checks = 0;

        for (i = 0; i < 16; i = i + 1) begin
            Inp = i[3:0];

            // cpl = 0 -> Out should equal Inp
            cpl = 0; #10;
            checks = checks + 1;
            if (Out !== Inp) begin
                $display("%0t ERROR: Inp=%b cpl=0 Out=%b expected=%b", $time, Inp, Out, Inp);
                errors = errors + 1;
            end else begin
                $display("%0t OK: Inp=%b cpl=0 Out=%b", $time, Inp, Out);
            end

            // cpl = 1 -> Out should be two's complement: (~Inp) + 1
            cpl = 1; #10;
            checks = checks + 1;
            // Module implements one's complement when cpl==1 (Out = ~Inp)
            expected = ~Inp;
            if (Out !== expected) begin
                $display("%0t ERROR: Inp=%b cpl=1 Out=%b expected=%b", $time, Inp, Out, expected);
                errors = errors + 1;
            end else begin
                $display("%0t OK: Inp=%b cpl=1 Out=%b (expected=%b)", $time, Inp, Out, expected);
            end
        end

        $display("Compl1 exhaustive test finished: %0d checks, %0d errors", checks, errors);
        $finish;
    end

endmodule
