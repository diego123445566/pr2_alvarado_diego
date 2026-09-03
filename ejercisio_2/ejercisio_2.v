module ejercisio_2(iA,iB,iE,oD);

input iA, iB, iE;
output [0:3] oD;

wire Anot, Bnot, Enot;

not g1(Anot,iA),
    g2(Bnot,iB),
    g3(Enot,iE);

nand g4(oD[0],Anot,Bnot,Enot),
     g5(oD[1],Anot,iB,Enot),
     g6(oD[2],iA,Bnot,Enot),
     g7(oD[3],iA,iB,Enot);

endmodule 