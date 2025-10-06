// Full-Adder de 1 bit usando concatenación
// Calcula la suma y el acarreo de tres bits de entrada
module fa(
    output wire c_out, // Salida: acarreo
    output wire sum,   // Salida: suma
    input wire a,      // Bit A
    input wire b,      // Bit B
    input wire c_in    // Acarreo de entrada
);
    assign {c_out, sum} = a + b + c_in; // Suma y acarreo
endmodule
