module cl(output wire out, input wire a, b, input wire [1:0] S);

    wire o1, o2, o3, o4;
    //module and2(output wire out, input wire a, b);
    and and1 (o1, a, b);
    //module or2(output wire out, input wire a, b);
    or or1 (o2, a, b);
    //module xor2(output wire out, input wire a, b);
    xor xor1 (o3, a, b);               
    //module not1(output wire out, input wire a);
    not not1 (o4, a);

    //module mux4_1(output reg out, input wire a, b, c, d, input wire [1:0] S);
    mux4_1 mux1 (out, o1, o2, o3, o4, S);

endmodule