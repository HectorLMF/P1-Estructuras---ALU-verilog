// Módulo de preprocesamiento de operandos para la ALU
module preprocess(
    output wire [3:0] AMod,
    output wire [3:0] BMod,
    input wire [3:0] A,
    input wire [3:0] B,
    input wire [2:0] Op
);
    wire cplA, cplB;
    wire [3:0] A_cpl, B_cpl;
    // Señales de control para cada operación
    assign cplA = (Op == 3'b010); // Negativo de A
    assign cplB = (Op == 3'b011); // Negativo de B
    compl1 complA(.Out(A_cpl), .Inp(A), .cpl(cplA));
    compl1 complB(.Out(B_cpl), .Inp(B), .cpl(cplB));
    // Selección de AMod y BMod según la operación
    assign AMod = (Op == 3'b010) ? A_cpl :
                  (Op == 3'b001) ? A :
                  (Op == 3'b111) ? A_cpl :
                  A;
    assign BMod = (Op == 3'b011) ? B_cpl :
                  (Op == 3'b001) ? 4'b0001 :
                  B;
endmodule
