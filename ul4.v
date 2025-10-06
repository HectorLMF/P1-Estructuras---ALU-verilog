// Unidad lógica de 4 bits
// Usa 4 instancias de la celda lógica cl para operar bit a bit
module ul4(
    output wire [3:0] Out, // Salida de 4 bits con el resultado lógico
    input wire [3:0] A,    // Operando A
    input wire [3:0] B,    // Operando B
    input wire [1:0] S     // Selector de operación lógica
);
    // Instancias de celdas lógicas para cada bit
    cl cl0(.out(Out[0]), .a(A[0]), .b(B[0]), .S(S));
    cl cl1(.out(Out[1]), .a(A[1]), .b(B[1]), .S(S));
    cl cl2(.out(Out[2]), .a(A[2]), .b(B[2]), .S(S));
    cl cl3(.out(Out[3]), .a(A[3]), .b(B[3]), .S(S));
endmodule
