//Sumador completo (full-adder) de tres entradas de 1 bit realizado a partir de puertas l�gicas 
module fa_v1(output wire sum, output wire c_out, input wire a, input wire b, input wire c_in);

    wire sum1;
    wire c1;
    wire c2;

    //Half adder 1
    xor xorHa1 (sum1,a,b);
    and andHa1 (c1,a,b);

    //Half adder 2

    xor xorHa2 (sum,c_in,sum1);
    and andHa2 (c2,c_in,sum1);

    or outputOr (c_out,c1,c2);

endmodule
