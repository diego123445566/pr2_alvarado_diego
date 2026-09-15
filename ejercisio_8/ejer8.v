//Descripción de flujo de datos del multiplexor 2 a 1 utilizando el operador condicional
module ejer8(iA, iB, iSelect, oSalida);
input iA,iB,iSelect;
output oSalida;
assign oSalida = iSelect ? iA : iB;
endmodule 