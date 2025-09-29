module mux4_1(output reg out, input wire a, b, c, d, input wire [1:0] S);

always @* begin
  if(S == 2'b00)
    out = a ;
  else if(S == 2'b01)
    out = b ;
  else if(S == 2'b10)
    out = c ;
  else
    out = d ;
end
endmodule
