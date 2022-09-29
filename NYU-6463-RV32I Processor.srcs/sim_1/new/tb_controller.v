`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 06:31:38 PM
// Design Name: 
// Module Name: tb_controller
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


module tb_controller(

    );
    reg [6:0]op;
    wire Branch, memRead, memtoReg, ALUOp1, ALUOp0,MemWrite, ALUsrc, RegWitre;
    controller dut(
    .op(op),
    .Branch(Branch),
    .memRead(memRead),
    .memtoReg(memtoReg),
    .ALUOp1(ALUOp1),
    .ALUOp0(ALUOp0),
    .MemWrite(MemWrite),
    .ALUsrc(ALUsrc),
    .RegWitre(RegWitre)
    );
    
    initial begin
       op <= 7'b0110011;
       #10
       op <= 7'b1100011;
       #10
       op <= 7'b0000011;
       #10
       op <= 7'b0100011;
       #10
       op <= 7'b0010011;
       #10
       op <= 7'b1100111;
       #10
       op <= 7'b1101111;
       #10
       op <= 7'b1110011;
       #10
       op <= 7'b0001111;
       #10
       op <= 7'b0110111;
       #10
       op <= 7'b0010111;
   end 
endmodule
