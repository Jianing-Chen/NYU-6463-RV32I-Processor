`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jianing Chen
// 
// Create Date: 2021/11/18 22:53:00
// Design Name: 
// Module Name: tb_instr_mem
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


module tb_instr_mem(

    );
    
    reg [31:0] t_read_address;
    wire [31:0] t_instruction;
    
    instr_mem dut(
        .read_address(t_read_address),
        .instruction(t_instruction)
    );
    
    initial begin: func_im
        begin
        t_read_address = 32'h01000000;
        #10
        t_read_address = 32'h01000004;
        #10
        t_read_address = 32'h01000008;
        #10
        t_read_address = 32'h0100000C;
        #10
        t_read_address = 32'h01000010;
        #10
        t_read_address = 32'h01000014;
        #10
        t_read_address = 32'h01000018;
        #10
        t_read_address = 32'h0100001C;
        #20
        $finish;
        end
    end
    
    
endmodule
