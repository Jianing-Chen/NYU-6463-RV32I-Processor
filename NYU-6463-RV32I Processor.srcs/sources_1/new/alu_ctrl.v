`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2021 09:46:34 PM
// Design Name: 
// Module Name: alu_ctrl
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


module alu_ctrl(
    input wire opt0,
    input wire opt1,
    input wire [6:0] fun7,
    input wire [2:0] fun3,
    output wire [3:0] opmode
    );
    wire [1:0] state; 
    wire [9:0] funcs;
    reg [3:0] opmode1;
    assign state={opt1, opt0};
    assign funcs={fun7, fun3};
    always @(*) begin
    case(state)
    2'b00:opmode1<=4'b0010;//add
    2'b01:opmode1<=4'b0110;//sub
    2'b10:if (funcs==10'b0000000000)opmode1<=4'b0010;//add
    else if(funcs==10'b0100000000)opmode1<=4'b0110;//sub
    else if(funcs==10'b0000000111)opmode1<=4'b0000;//and
    else if(funcs==10'b0000000110)opmode1<=4'b0001;//or
    else if(funcs==10'b0000000100)opmode1<=4'b0111;//xor
    else if(funcs==10'b0000000001)opmode1<=4'b1000;//sll
    else if(funcs==10'b0000000101)opmode1<=4'b1001;//srl
    else if(funcs==10'b0100000101)opmode1<=4'b1010;//sra
    else if(funcs==10'b0000000010)opmode1<=4'b1100;//slt
    else if(funcs==10'b0000000011)opmode1<=4'b1101;//sltu
    2'b11:opmode1<=4'b0011;
    //default:opmode1<="ZZZZ";
    endcase
    end
    assign opmode=opmode1;
endmodule
