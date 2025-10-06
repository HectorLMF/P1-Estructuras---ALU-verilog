// Módulo de preprocesamiento de operandos para la ALU
// Modifica los operandos A y B según la operación seleccionada por Op
// Permite realizar incrementos, negaciones y operaciones lógicas/ariméticas avanzadas
module preprocess(
    output wire [3:0] AMod, // Operando A modificado
    output wire [3:0] BMod, // Operando B modificado
    input wire [3:0] A,     // Operando original A
    input wire [3:0] B,     // Operando original B
    input wire [2:0] Op     // Selector de operación
);
    wire cplA, cplB;        // Señales de control para complemento a 1
    wire [3:0] A_cpl, B_cpl;// Resultados de complemento a 1
    // Señales de control para cada operación
    assign cplA = (Op == 3'b010); // Negativo de A
    assign cplB = (Op == 3'b011); // Negativo de B
    // Instancias de complemento a 1
    compl1 complA(.Out(A_cpl), .Inp(A), .cpl(cplA));
    compl1 complB(.Out(B_cpl), .Inp(B), .cpl(cplB));
    // Selección de AMod y BMod según la operación
    assign AMod = (Op == 3'b010) ? A_cpl : // Negativo de A
                  (Op == 3'b001) ? A :    // Incremento de A
                  (Op == 3'b111) ? A_cpl :// Negación bit a bit de A
                  A;                      // Resto de operaciones
    assign BMod = (Op == 3'b011) ? B_cpl :// Negativo de B
                  (Op == 3'b001) ? 4'b0001 : // Incremento de A (sumar 1)
                  B;                      // Resto de operaciones
endmodule
