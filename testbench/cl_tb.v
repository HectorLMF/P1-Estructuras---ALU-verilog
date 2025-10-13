`timescale 1 ns / 10 ps

module cl_tb;
    reg test_a, test_b;
    reg [1:0] test_S;
    wire test_out;

    // Instancia del módulo a testear
    cl uut(test_out, test_a, test_b, test_S);

    initial begin
        $monitor("tiempo=%0d a=%b b=%b S=%b out=%b", $time, test_a, test_b, test_S, test_out);
        $dumpfile("cl_tb.vcd");
        $dumpvars;

        // vector de test 0
        test_a = 0; test_b = 0; test_S = 2'b00;
        #20;
        // vector de test 1
        test_a = 1; test_b = 0; test_S = 2'b00;
        #20;
        // vector de test 2
        test_a = 0; test_b = 1; test_S = 2'b01;
        #20;
        // vector de test 3
        test_a = 1; test_b = 1; test_S = 2'b10;
        #20;
        // vector de test 4
        test_a = 1; test_b = 0; test_S = 2'b11;
        #20;
        // vector de test 5
        test_a = 0; test_b = 1; test_S = 2'b11;
        #20;
        // vector de test 6
        test_a = 1; test_b = 1; test_S = 2'b11;
        #20;
        $finish;
    end
endmodule
