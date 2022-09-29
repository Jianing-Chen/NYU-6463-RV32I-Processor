`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/18 19:57:35
// Design Name: 
// Module Name: imm_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imm_gen(
    input wire [31:0] instruction,
    output reg [31:0] imm_out
    );

wire [4:0] srai;
assign srai = instruction[24:20];

always @(*)
begin
    case (instruction [6:0])
        7'b0110111: //LUI
            imm_out <= {instruction[31:12], 12'b0};
        7'b0010111: //AUIPC
            imm_out <= {instruction[31:12], 12'b0};
        7'b1101111: //JAL
            imm_out <= {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
        7'b1100111: //JALR
            imm_out <= {{20{instruction[31]}}, instruction[31:20]};
        7'b1100011: //BEQ, BNE, BLT, BGE, BLUT, BGEU
            imm_out <= {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        7'b0000011: //LB, LH, LW, LBU, LHU
            imm_out <= {{20{instruction[31]}}, instruction[31:20]};
        7'b0100011: //SB, SH, SW
            imm_out <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        7'b0010011: //ADDI, SLTI, SLTIU, XORI, ORI, ANDI
            begin 
            if((instruction[31:25]==7'b0100000&&instruction[14:12]==3'b101)||(instruction[14:12]==3'b001)||instruction[14:12]==3'b101)
                imm_out = {{27{srai[4]}}, srai};
            else
                imm_out = {{20{instruction[31]}}, instruction[31:20]};
            end
        default
            imm_out <= {32'b0};

endcase
end

endmodule
