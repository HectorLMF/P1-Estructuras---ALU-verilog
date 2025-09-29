//Sumador de 4 bits 
module sum4(output wire[3:0] S, output wire c_out, input wire[3:0] A, input wire[3:0] B, input wire c_in);
	
	wire [3:0] carry;
 
	//module fa_v2(output wire sum, output wire c_out, input wire a, input wire b, input wire c_in);

	fa_v2 fa1 (S[0],C[0],A[0],b[0],c_in);
	fa_v2 fa2 (S[1],C[1],A[1],b[1],C[0]);
	fa_v2 fa3 (S[2],C[2],A[2],b[2],C[1]);
	fa_v2 fa4 (S[3], c_out, A[3],b[3],C[2]);

endmodule

