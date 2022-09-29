`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Siyuan Huang
// 
// Create Date: 11/02/2021 02:47:54 AM
// Design Name: riscv processor
// Module Name: adder_branch
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


module adder_branch(
    input [31:0] addr_in_1,
    input [31:0] addr_in_2,
    output [31:0] addr_out
    );
    //wire [31:0] shifted_1;
    
    //assign shifted_1={addr_in_2[30:0],1'b0};//shift left by 1
    assign addr_out=addr_in_1+addr_in_2;//add them together
    
    
    
endmodule
