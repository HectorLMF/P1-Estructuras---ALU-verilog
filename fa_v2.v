//Sumador completo (full-adder) de tres entradas de 1 bit realizado a partir de puertas l�gicas 
module fa_v2(output wire sum, output wire c_out, input wire a, input wire b, input wire c_in);

    wire sum1;
    wire c1;
    wire c2;

    //Half adder 1 module ha_v1(output wire sum, output wire carry, input wire a, input wire b);

    ha_v1 halfAdder1 (sum1,c1,a,b);

    //Half adder 2

    ha_v1 halfAdder2 (sum,c2,c_in,sum1);

    //Puerta or para el carry.
    or outputOr (c_out,c1,c2);

endmodule
