//Descripción de flujo de datos de un decodificador de 2 a 4
module ejer5(iA,iB,iE,oD);
input iA,iB,iE;
output [0:3] oD;
assign oD[0] = ~((~iA) & (~iB) & (~iE)),
oD[1] = ~((~iA) & (iB) & (~iE)),
oD[2] = ~((iA) & (~iB) & (~iE)),
oD[3] = ~((iA) & (iB) & (~iE));
endmodule 