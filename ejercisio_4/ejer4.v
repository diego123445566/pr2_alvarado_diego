//Descripción de un multiplexor 2 a 1 usando buffer de 3 estados
module ejer4(iA, iB, iSelector, oSalida);
input iA, iB, iSelector;
output oSalida;
tri oSalida;
bufif1 (oSalida, iA, iSelector);
bufif0 (oSalida, iB, iSelector);
endmodule 