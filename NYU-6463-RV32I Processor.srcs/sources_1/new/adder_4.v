`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Siyuan Huang
// 
// Create Date: 11/02/2021 02:47:54 AM
// Design Name: riscv processor
// Module Name: adder_4
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


module adder_4(
    input wire [31:0] addr_in,
    output wire [31:0] addr_out
    );
    //simply add 4
    assign addr_out=addr_in+4;
    
endmodule
