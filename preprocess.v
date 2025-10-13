module preprocess(output wire [3:0] AMod, output wire [3:0] BMod, input wire [3:0] A, input wire [3:0] B, input wire [2:0] Op);

    //Buses intermedios
    wire [3:0] muxAMuxB;
    wire [3:0] muxInputCPL;
    wire [3:0] muxInputA_CPL;

    //Señales de control (driven procedurally from Op)
    reg add1Signal;
    reg op1_ASignal;
    reg op2_BSignal;
    reg cplSignal;
    reg cplASignal;

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
        cplASignal = 1'b0;

        case (Op)
            3'b000: begin // B + 1 + cin : ADD1=1, OP1_A=1 (select B), OP2_B=0 (select 0001), CPL=0, CPLA=0
                add1Signal = 1'b1; op1_ASignal = 1'b1; op2_BSignal = 1'b0; cplSignal = 1'b0; cplASignal = 1'b0;
            end
            3'b001: begin // A + 1 + cin : ADD1=1, OP1_A=0 (select A), OP2_B=0 (select 0001), CPL=0, CPLA=0
                add1Signal = 1'b1; op1_ASignal = 1'b0; op2_BSignal = 1'b0; cplSignal = 1'b0; cplASignal = 1'b0;
            end
            3'b010: begin // -A = ~A + 1 + cin : ADD1=1, OP1_A=0 (select A), OP2_B=0 (select 0001), CPL=0, CPLA=1 (complement A)
                add1Signal = 1'b1; op1_ASignal = 1'b0; op2_BSignal = 1'b0; cplSignal = 1'b0; cplASignal = 1'b1;
            end
            3'b011: begin // -B = ~B + 1 + cin : ADD1=1, OP1_A=1 (select B), OP2_B=0 (select 0001), CPL=0, CPLA=1 (complement B)
                add1Signal = 1'b1; op1_ASignal = 1'b1; op2_BSignal = 1'b0; cplSignal = 1'b0; cplASignal = 1'b1;
            end
            3'b100: begin // A & B : ADD1=0, OP1_A=0 (select A), OP2_B=1 (select B), CPL=0, CPLA=0
                add1Signal = 1'b0; op1_ASignal = 1'b0; op2_BSignal = 1'b1; cplSignal = 1'b0; cplASignal = 1'b0;
            end
            3'b101: begin // A | B : ADD1=0, OP1_A=0 (select A), OP2_B=1 (select B), CPL=0, CPLA=0
                add1Signal = 1'b0; op1_ASignal = 1'b0; op2_BSignal = 1'b1; cplSignal = 1'b0; cplASignal = 1'b0;
            end
            3'b110: begin // A XOR B : ADD1=0, OP1_A=0 (select A), OP2_B=1 (select B), CPL=0, CPLA=0
                add1Signal = 1'b0; op1_ASignal = 1'b0; op2_BSignal = 1'b1; cplSignal = 1'b0; cplASignal = 1'b0;
            end
            3'b111: begin // ¬A : ADD1=0, OP1_A=0 (select A), OP2_B=0 (select 0000), CPL=0, CPLA=0
                add1Signal = 1'b0; op1_ASignal = 1'b0; op2_BSignal = 1'b0; cplSignal = 1'b0; cplASignal = 1'b0;
            end
            default: begin
                add1Signal = 1'b0; op1_ASignal = 1'b0; op2_BSignal = 1'b0; cplSignal = 1'b0; cplASignal = 1'b0;
            end
        endcase
    end


    //Modulos
    //module mux2_4(output wire [3:0] Out, input wire [3:0] A, input wire [3:0] B, input wire s);
    mux2_4 muxAdd(muxAMuxB, 4'b0000, 4'b0001, add1Signal);
    mux2_4 muxOutA(muxInputA_CPL, A, B, op1_ASignal);  // Select between A and B
    mux2_4 muxInputB(muxInputCPL, muxAMuxB, B, op2_BSignal);

    //module compl1(output wire [3:0] Out, input wire [3:0] Inp, input wire cpl);
    compl1 complA(AMod, muxInputA_CPL, cplASignal);  // Complement A if needed
    compl1 complB(BMod, muxInputCPL, cplSignal);
endmodule 