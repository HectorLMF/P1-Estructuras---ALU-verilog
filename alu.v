// Módulo principal ALU de 4 bits
module alu(
    output wire [3:0] R,
    output wire zero,
    output wire carry,
    output wire sign,
    input wire [3:0] A,
    input wire [3:0] B,
    input wire c_in,
    input wire [2:0] Op
);
    wire [3:0] AMod, BMod;
    wire [3:0] sum_out, logic_out;
    wire sum_carry;
    // Preprocesamiento de operandos
    preprocess pre(.AMod(AMod), .BMod(BMod), .A(A), .B(B), .Op(Op));
    // Sumador de 4 bits
    sum4 sumador(.S(sum_out), .c_out(sum_carry), .A(AMod), .B(BMod), .c_in(c_in));
    // Unidad lógica de 4 bits
    ul4 unidad_logica(.Out(logic_out), .A(A), .B(B), .S(Op[1:0]));
    // Multiplexor para seleccionar salida aritmética o lógica
    mux2_4 mux_final(.Out(R), .A(sum_out), .B(logic_out), .s(Op[2]));
    // Flags
    assign zero = (R == 4'b0000);
    assign sign = R[3];
    assign carry = sum_carry;
endmodule
