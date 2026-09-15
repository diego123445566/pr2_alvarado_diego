//Descripción de flujo de datos del multiplexor 2 a 1 utilizando el operador if-else
module ejer9(iA,iB,iSelect,oSalida);
input iA,iB,iSelect;
output oSalida;
reg oSalida;
always @ (iSelect or iA or iB)
if (iSelect == 1)
oSalida = iA;
else
oSalida = iB;
endmodule 