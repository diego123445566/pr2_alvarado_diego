//Descripción de comportamiento del multiplexor 4 a 1
module ejer10(iI0, iI1, iI2, iI3, iSelect, oY);
input iI0, iI1, iI2, iI3;
input [1:0] iSelect;
output reg oY;
always @ (iI0 or iI1 or iI2 or iI3 or iSelect)
case (iSelect)
2'b00 : oY = iI0;
2'b01 : oY = iI1;
2'b10 : oY = iI2;
2'b11 : oY = iI3;
endcase
endmodule 