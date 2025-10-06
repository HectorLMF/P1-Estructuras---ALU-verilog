// Multiplexor 2 a 1 de 4 bits
// Selecciona entre las entradas A y B según el selector s
module mux2_4(
    output wire [3:0] Out, // Salida de 4 bits
    input wire [3:0] A,    // Entrada A
    input wire [3:0] B,    // Entrada B
    input wire s           // Selector: 0 para A, 1 para B
);
    assign Out = s ? B : A; // Selección de salida
endmodule