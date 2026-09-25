// ============================================================================
// MÓDULO PRINCIPAL: ejer13 (Adaptado a los 10 switches SW0-SW9)
// ============================================================================
module ejer13 (
    input  wire [4:0] SW_A,       // Switches SW[4:0] -> Operando A (5 bits)
    input  wire [2:0] SW_Op,      // Switches SW[7:5] -> Opcode (3 bits)
    input  wire [1:0] SW_B_in,    // Switches SW[9:8] -> Entrada B (2 bits)
    output wire [4:0] LEDR_Y,     // LEDs LEDR[4:0] -> Resultado binario
    output wire       LEDR_Cout,  // LED LEDR9 -> Carry Out / Overflow
    output wire [6:0] HEX0,       // Display 0 (Unidades)
    output wire [6:0] HEX1        // Display 1 (Decenas)
);

    // Expandimos B a 5 bits completando los bits superiores con cero: B = {000, SW_B_in}
    wire [4:0] SW_B = {3'b000, SW_B_in};

    wire [4:0] result;
    wire       cout;
    wire [3:0] bcd_decenas;
    wire [3:0] bcd_unidades;

    // Instancia de la ALU
    ALU_Core u_alu (
        .A(SW_A),
        .B(SW_B),
        .opcode(SW_Op),
        .Y(result),
        .Cout(cout)
    );

    // Conversor Binario a BCD
    Bin5_to_BCD u_bcd (
        .bin(result),
        .decenas(bcd_decenas),
        .unidades(bcd_unidades)
    );

    // Decodificadores para 7 Segmentos (Ánodo Común)
    Hex_to_7Seg u_disp0 (
        .hex(bcd_unidades),
        .seg(HEX0)
    );

    Hex_to_7Seg u_disp1 (
        .hex(bcd_decenas),
        .seg(HEX1)
    );

    assign LEDR_Y    = result;
    assign LEDR_Cout = cout;

endmodule

// ============================================================================
// SUBMÓDULO: ALU_Core
// ============================================================================
module ALU_Core (
    input  wire [4:0] A,
    input  wire [4:0] B,
    input  wire [2:0] opcode,
    output wire [4:0] Y,
    output wire       Cout
);

    wire [5:0] sum_ext  = A + B;
    wire [5:0] diff_ext = A - B;

    assign Y = (opcode == 3'b000) ? sum_ext[4:0] :           // Suma: A + B
               (opcode == 3'b001) ? diff_ext[4:0] :          // Resta: A - B
               (opcode == 3'b010) ? (A & B) :                // AND
               (opcode == 3'b011) ? (A | B) :                // OR
               (opcode == 3'b100) ? (A ^ B) :                // XOR
               (opcode == 3'b101) ? (~A) :                   // NOT A
               (opcode == 3'b110) ? (A << 1) :               // Shift Left
               (A > B ? 5'b00001 : 5'b00000);                // Comparación (A > B)

    assign Cout = (opcode == 3'b000) ? sum_ext[5] :
                  (opcode == 3'b001) ? diff_ext[5] :
                  (opcode == 3'b110) ? A[4] : 1'b0;

endmodule

// ============================================================================
// SUBMÓDULO: Bin5_to_BCD
// ============================================================================
module Bin5_to_BCD (
    input  wire [4:0] bin,
    output wire [3:0] decenas,
    output wire [3:0] unidades
);
    assign decenas  = bin / 10;
    assign unidades = bin % 10;
endmodule

// ============================================================================
// SUBMÓDULO: Hex_to_7Seg
// ============================================================================
module Hex_to_7Seg (
    input  wire [3:0] hex,
    output wire [6:0] seg
);
    assign seg = (hex == 4'h0) ? 7'b1000000 :
                 (hex == 4'h1) ? 7'b1111001 :
                 (hex == 4'h2) ? 7'b0100100 :
                 (hex == 4'h3) ? 7'b0110000 :
                 (hex == 4'h4) ? 7'b0011001 :
                 (hex == 4'h5) ? 7'b0100010 :
                 (hex == 4'h6) ? 7'b0100001 :
                 (hex == 4'h7) ? 7'b1111000 :
                 (hex == 4'h8) ? 7'b0000000 :
                 (hex == 4'h9) ? 7'b0011000 : 7'b1111111;
endmodule 