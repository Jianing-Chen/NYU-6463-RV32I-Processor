`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2021 01:12:24 AM
// Design Name: 
// Module Name: nyu_Processor
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


module nyu_Processor(
        input clk, rst,
        output done
        //output 
        );
    wire Branch, memRead, memtoReg, ALUOp1, ALUOp0, MemWrite, ALUsrc, RegWitre, memOp1, memOp2;
    wire [6:0] op;
    wire [2:0] func3;
    wire [2:0] state;

    Datapath_Unit u1(
     .clk(clk),
     .rst(rst),
     .Branch(Branch),
     .memRead(memRead),
     .MemWrite(MemWrite),
     .ALUsrc(ALUsrc),
     .memtoReg(memtoReg),
     .RegWitre(RegWitre),
     .ALUOp1(ALUOp1),
     .ALUOp0(ALUOp0),
     .memOp1(memOp1),
     .memOp2(memOp2),
     .op(op),
     .func3(func3),
     .state_datapath(state),
     .done(done)
 );

      controller u2(
     .op(op),
     .clk(clk),
     .func3(func3),
     .memtoReg(memtoReg),
     .ALUOp1(ALUOp1),
     .ALUOp0(ALUOp0),
     .Branch(Branch),
     .memRead(memRead),
     .MemWrite(MemWrite),
     .ALUsrc(ALUsrc),
     .RegWitre(RegWitre),
     .memOp1(memOp1),
     .memOp2(memOp2),
     .state_FSM(state)
 );
 
endmodule
