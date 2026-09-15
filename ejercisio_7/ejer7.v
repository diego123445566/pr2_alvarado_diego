//Descripción de flujo de datos de un comparador de 4 bits
module ejer7(iA, iB, oAmenorB, oAmayorB, oAigualB);
input [3:0] iA, iB;
output oAmenorB, oAmayorB, oAigualB;
assign oAmenorB = (iA < iB),
oAmayorB = (iA > iB),
oAigualB = (iA == iB);
endmodule 