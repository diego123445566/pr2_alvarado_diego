//Descripción de flujo de datos de un sumador de 4 bits
module ejer6(iA, iB, iCin, oSUM, oCout);
input [3:0] iA, iB;
input iCin;
output [3:0] oSUM;
output oCout;
assign {oCout , oSUM} = iA + iB + iCin;
endmodule 