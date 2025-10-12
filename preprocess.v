module preprocess(output wire [3:0] AMod, output wire [3:0] BMod, input wire [3:0] A, input wire [3:0] B, input wire [2:0] Op);

    //Buses intermedios
    wire [3:0] muxAMuxB;
    wire [3:0] muxInputCPL;

    //Señales de control (driven procedurally from Op)
    reg add1Signal;
    reg op1_ASignal;
    reg op2_BSignal;
    reg cplSignal;

    // Bits individuales de Op
    wire OP2 = Op[2];
    wire OP1 = Op[1];
    wire OP0 = Op[0];

    // Logica de control establecida por la tabla de verdad
    always @(*) begin
        // defaults
        add1Signal = 1'b0;
        op1_ASignal = 1'b0;
        op2_BSignal = 1'b0;
        cplSignal = 1'b0;

        case (Op)
            3'b000: begin // A + B  : ADD1=x -> choose 0, OP1_A=1, OP2_B=1, CPL=0
                add1Signal = 1'b0; op1_ASignal = 1'b1; op2_BSignal = 1'b1; cplSignal = 1'b0;
            end
            3'b001: begin // A + 1 : ADD1=1, OP1_A=0, OP2_B=0, CPL=0
                add1Signal = 1'b1; op1_ASignal = 1'b0; op2_BSignal = 1'b0; cplSignal = 1'b0;
            end
            3'b010: begin // -A : ADD1=1, OP1_A=0, OP2_B=0, CPL=1
                add1Signal = 1'b1; op1_ASignal = 1'b0; op2_BSignal = 1'b0; cplSignal = 1'b1;
            end
            3'b011: begin // -B : ADD1=1, OP1_A=0, OP2_B=1, CPL=1
                add1Signal = 1'b1; op1_ASignal = 1'b0; op2_BSignal = 1'b1; cplSignal = 1'b1;
            end
            3'b100: begin // A & C : ADD1=x -> choose 0, OP1_A=1, OP2_B=1, CPL=0
                add1Signal = 1'b0; op1_ASignal = 1'b1; op2_BSignal = 1'b1; cplSignal = 1'b0;
            end
            3'b101: begin // A | B : ADD1=x -> choose 0, OP1_A=1, OP2_B=1, CPL=0
                add1Signal = 1'b0; op1_ASignal = 1'b1; op2_BSignal = 1'b1; cplSignal = 1'b0;
            end
            3'b110: begin // A XOR B : ADD1=x -> choose 0, OP1_A=1, OP2_B=1, CPL=0
                add1Signal = 1'b0; op1_ASignal = 1'b1; op2_BSignal = 1'b1; cplSignal = 1'b0;
            end
            3'b111: begin // ¬A : ADD1=x -> choose 0, OP1_A=1, OP2_B=x -> choose 0, CPL=x -> choose 0
                add1Signal = 1'b0; op1_ASignal = 1'b1; op2_BSignal = 1'b0; cplSignal = 1'b0;
            end
            default: begin
                add1Signal = 1'b0; op1_ASignal = 1'b0; op2_BSignal = 1'b0; cplSignal = 1'b0;
            end
        endcase
    end


    //Modulos
    //module mux2_4(output wire [3:0] Out, input wire [3:0] A, input wire [3:0] B, input wire s);
    mux2_4 muxAdd(muxAMuxB, 4'b0000, 4'b0001, add1Signal);
    mux2_4 muxOut(AMod, muxAMuxB, A, op1_ASignal);
    mux2_4 muxInput(muxInputCPL, A, B, op2_BSignal);

    //module compl1(output wire [3:0] Out, input wire [3:0] Inp, input wire cpl);
    compl1 complB(BMod, muxInputCPL, cplSignal);
endmodule 