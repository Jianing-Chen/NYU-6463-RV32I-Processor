`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 10:50:20 PM
// Design Name: 
// Module Name: tb_register
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


module tb_register(

    );
    wire [31:0] rs1_data, rs2_data, rd_din;
    reg[4:0]rd_addr, rs1_addr, rs2_addr;

    register dut(
    .rs1_data(rs1_data),
    .rs2_data(rs2_data),
    .rd_din(rd_din),
    .rd_addr(rd_addr),
    .rs1_addr(rs1_addr),
    .rs2_addr(rs2_addr)
    );
    assign rd_din = 32'b00000000000000010101000110010100;
    initial begin 
    rs1_addr <= 5'b00001;
    rs2_addr <= 5'b00001;
    rd_addr <= 5'b00001;
    
    end
   endmodule
