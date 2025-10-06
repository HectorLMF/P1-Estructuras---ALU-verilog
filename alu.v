// Módulo principal ALU de 4 bits
// Realiza operaciones aritméticas y lógicas sobre dos operandos de 4 bits.
// Genera los flags zero, carry y sign según el resultado.
module alu(
    output wire [3:0] R, // Resultado de la operación seleccionada
    output wire zero,    // Flag: 1 si R == 0
    output wire carry,   // Flag: 1 si hay acarreo en la operación aritmética
    output wire sign,    // Flag: valor del bit más significativo de R
    input wire [3:0] A,  // Operando A
    input wire [3:0] B,  // Operando B
    input wire c_in,     // Acarreo de entrada
    input wire [2:0] Op  // Selector de operación
);
    wire [3:0] AMod, BMod;      // Operandos modificados por el preprocesador
    wire [3:0] sum_out, logic_out; // Resultados de la suma y la lógica
    wire sum_carry;             // Acarreo de la suma
    // Preprocesamiento de operandos según la operación
    preprocess pre(.AMod(AMod), .BMod(BMod), .A(A), .B(B), .Op(Op));
    // Sumador de 4 bits para operaciones aritméticas
    sum4 sumador(.S(sum_out), .c_out(sum_carry), .A(AMod), .B(BMod), .c_in(c_in));
    // Unidad lógica de 4 bits para operaciones lógicas
    ul4 unidad_logica(.Out(logic_out), .A(A), .B(B), .S(Op[1:0]));
    // Multiplexor para seleccionar entre resultado aritmético o lógico
    mux2_4 mux_final(.Out(R), .A(sum_out), .B(logic_out), .s(Op[2]));
    // Flags de resultado
    assign zero = (R == 4'b0000); // Flag de cero
    assign sign = R[3];           // Flag de signo
    assign carry = sum_carry;     // Flag de acarreo
endmodule
