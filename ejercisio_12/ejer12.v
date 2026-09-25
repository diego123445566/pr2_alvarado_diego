module ejer12 (
    input  wire [3:0] A,          // Entrada de 4 bits (0 a 15)
    output wire [3:0] Leds_BCD,   // Salida para LEDs segun codigo
    output wire [6:0] Display_Seg // Salida a-g para Display de 7 segmentos
);

    // 1. Deteccion de condicion de Error (Valores de 10 a 15)
    wire error;
    assign error = (A[3] & A[2]) | (A[3] & A[1]);

    // 2. Logica del Decodificador BCD a 7 Segmentos (Cátodo Común: 1 encendido)
    // Patron 'E': g=1, f=1, e=1, d=1, c=0, b=0, a=1 -> 7'b1001111 (0x4F)
    wire [6:0] seg_num;
    wire [6:0] seg_error;
    
    assign seg_error = 7'b1001111; // Muestra 'E'
    
    // Decodificacion directa BCD (0-9) a 7 segmentos {g,f,e,d,c,b,a}
    assign seg_num[0] = (~A[3] & ~A[2] & ~A[1] & A[0]) | (~A[3] & A[2] & ~A[1] & ~A[0]); // a
    assign seg_num[1] = (~A[3] & A[2] & ~A[1] & A[0])  | (~A[3] & A[2] & A[1] & ~A[0]);  // b
    assign seg_num[2] = (~A[3] & ~A[2] & A[1] & ~A[0]);                                  // c
    assign seg_num[3] = (~A[3] & ~A[2] & ~A[1] & A[0]) | (~A[3] & A[2] & ~A[1] & ~A[0]) | (~A[3] & A[2] & A[1] & A[0]); // d
    assign seg_num[4] = (~A[3] & A[0]) | (~A[2] & ~A[1] & A[0]) | (~A[3] & A[2] & ~A[1]); // e
    assign seg_num[5] = (~A[3] & ~A[2] & A[0]) | (~A[3] & ~A[2] & A[1]) | (~A[3] & A[1] & A[0]); // f
    assign seg_num[6] = (~A[3] & ~A[2] & ~A[1]) | (~A[3] & A[2] & A[1] & A[0]);          // g

    // Multiplexor de Salida para el Display (Muestra 'E' si hay error)
    assign Display_Seg = error ? seg_error : ~seg_num; // Salida invertida si es Ánodo Común

    // 3. Conversor de Codigo para LEDs (Ejemplo: Codigo Gray para ID 1-2)
    wire [3:0] code_gray;
    assign code_gray[3] = A[3];
    assign code_gray[2] = A[3] ^ A[2];
    assign code_gray[1] = A[2] ^ A[1];
    assign code_gray[0] = A[1] ^ A[0];

    // Asignacion final a los LEDs
    assign Leds_BCD = code_gray;

endmodule 