// Complementador a 1 de 4 bits
// Si cpl = 1, invierte todos los bits de Inp; si cpl = 0, deja Inp sin modificar
module compl1(
    output wire [3:0] Out, // Salida: complemento a 1 o dato original
    input wire [3:0] Inp,  // Entrada de 4 bits
    input wire cpl         // Control: 1 para invertir, 0 para dejar igual
);
    assign Out = cpl ? ~Inp : Inp; // Operación de complemento a 1
endmodule
