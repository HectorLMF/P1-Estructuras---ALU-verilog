module alu(output wire [3:0] R, output wire zero, carry, sign, input wire [3:0] A, B, input wire c_in, input wire [2:0] Op);

//Wires intermedios
    wire [3:0] OP1, OP2, sum4_Mux, ul4_Mux;

//MODULOS
    //Preprocesador
    //module preprocess(output wire [3:0] AMod, output wire [3:0] BMod, input wire [3:0] A, input wire [3:0] B, input wire [2:0] Op);
    preprocess pre(OP1, OP2, A, B, Op);

    //Sumador
    //module sum4_v2(output wire[3:0] S, output wire c_out, input wire[3:0] A, input wire[3:0] B, input wire c_in);
    sum4_v2 sum(carry, sum4_Mux, OP1, OP2, c_in);

    //Unidad Logica
    //module ul4(output wire [3:0] Out, input wire [3:0] A, input wire [3:0] B, input wire [1:0] S);
    ul4 ul(ul4_Mux, OP1, OP2, Op[1:0]);

    //mux2_4
    //module mux2_4(output wire [3:0] Out, input wire [3:0] A, input wire [3:0] B, input wire s);
    mux2_4 mux(R, sum4_Mux, ul4_Mux, Op[2]);

//Flags
    assign zero = (R == 4'b0000) ? 1'b1 : 1'b0;
    assign sign = R[3];
    assign carry = carry;

endmodule