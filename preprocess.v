module preprocess(output wire [3:0] AMod, output wire [3:0] BMod, input wire [3:0] A, input wire [3:0] B, input wire [2:0] Op);

    //Buses intermedios
    wire [3:0] muxAMuxB;
    wire [3:0] muxInputCPL;

    //Señales de control
    wire add1Signal;
    wire op1_ASignal;
    wire op2_BSignal;
    wire cplSignal;

    //Modulos
    //module mux2_4(output wire [3:0] Out, input wire [3:0] A, input wire [3:0] B, input wire s);
    mux2_4 muxAdd(muxAMuxB, 4'b0000, 4'b1111, add1Signal);
    mux2_4 muxOut(AMod, muxAMuxB, A, op1_ASignal);
    mux2_4 muxInput(muxInputCPL, A, B, op2_BSignal)

    //module compl1(output wire [3:0] Out, input wire [3:0] Inp, input wire cpl);
    compl1 complB(BMod, muxInputCPL, cplSignal);

endmodule 