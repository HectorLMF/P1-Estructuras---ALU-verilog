// Sumador alternativo de 4 bits usando asignación continua
// Suma dos operandos de 4 bits y un acarreo de entrada sin instancias de Full-Adder
module sum4_v2(
    output wire[3:0] S, // Salida: suma de 4 bits
    output wire c_out,  // Salida: acarreo final
    input wire[3:0] A,  // Operando A
    input wire[3:0] B,  // Operando B
    input wire c_in     // Acarreo de entrada
);
    assign {c_out, S} = A + B + c_in; // Suma y acarreo
endmodule