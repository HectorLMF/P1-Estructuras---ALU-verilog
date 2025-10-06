// Sumador completo de 4 bits usando 4 Full-Adder de 1 bit
// Suma dos operandos de 4 bits y un acarreo de entrada
module sum4(
    output wire [3:0] S, // Salida: suma de 4 bits
    output wire c_out,   // Salida: acarreo final
    input wire [3:0] A,  // Operando A
    input wire [3:0] B,  // Operando B
    input wire c_in      // Acarreo de entrada
);
    wire c1, c2, c3;     // Acarreos intermedios
    // Instancias de Full-Adder para cada bit
    fa fa0(.c_out(c1), .sum(S[0]), .a(A[0]), .b(B[0]), .c_in(c_in));
    fa fa1(.c_out(c2), .sum(S[1]), .a(A[1]), .b(B[1]), .c_in(c1));
    fa fa2(.c_out(c3), .sum(S[2]), .a(A[2]), .b(B[2]), .c_in(c2));
    fa fa3(.c_out(c_out), .sum(S[3]), .a(A[3]), .b(B[3]), .c_in(c3));
endmodule

