// Full-Adder de 1 bit usando concatenación
module fa(
    output wire c_out,
    output wire sum,
    input wire a,
    input wire b,
    input wire c_in
);
    assign {c_out, sum} = a + b + c_in;
endmodule
