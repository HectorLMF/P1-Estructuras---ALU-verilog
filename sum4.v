//Sumador de 4 bits 
module sum4(output wire[3:0] S, output wire c_out, input wire[3:0] A, input wire[3:0] B, input wire c_in);
	
	wire [3:0] carry;
 
	//module fa_v2(output wire sum, output wire c_out, input wire a, input wire b, input wire c_in);

	fa_v2 fa1 (S[0], carry[0], A[0], B[0], c_in);
	fa_v2 fa2 (S[1], carry[1], A[1], B[1], carry[0]);
	fa_v2 fa3 (S[2], carry[2], A[2], B[2], carry[1]);
	fa_v2 fa4 (S[3], c_out, A[3], B[3], carry[2]);

endmodule

