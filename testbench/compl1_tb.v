// Testbench para compl1
module compl1_tb;
    reg [3:0] Inp;
    reg cpl;
    wire [3:0] Out;
    compl1 uut(.Out(Out), .Inp(Inp), .cpl(cpl));
    initial begin
        $display("Inp cpl | Out");
        Inp = 4'b1010; cpl = 0; #10; $display("%b %b | %b", Inp, cpl, Out);
        cpl = 1; #10; $display("%b %b | %b", Inp, cpl, Out);
        $finish;
    end
endmodule
