module alu(output wire [3:0] R, output wire zero, carry, sign, input wire [3:0] A, B, input wire c_in, input wire [2:0] Op);

    //MODULOS
    //Preprocesador
    //module preprocess(output wire [3:0] AMod, output wire [3:0] BMod, input wire [3:0] A, input wire [3:0] B, input wire [2:0] Op);
    preprocess pre(A_mod, B_mod, A, B, Op);

    //Sumador
    //module sum4_v2(output wire[3:0] S, output wire c_out, input wire[3:0] A, input wire[3:0] B, input wire c_in);
    sum4_v2 sum(R, carry, A_mod, B_mod, c_in);

    //

endmodule