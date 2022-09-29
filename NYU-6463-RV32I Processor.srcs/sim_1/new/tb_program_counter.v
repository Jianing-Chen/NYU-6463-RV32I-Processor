`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jianing Chen
// 
// Create Date: 2021/11/18 19:26:03
// Design Name: 
// Module Name: tb_program_counter
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


module tb_program_counter(

    );
    
    reg t_clk = 0;
    reg t_rst = 0;
    reg [31:0] t_pc_in;
    wire [31:0] t_pc_out;
    
    
    program_counter dut(
        .clk(t_clk),
        .rst(t_rst),
        .pc_in(t_pc_in),
        .pc_out(t_pc_out)
    );
    
    initial begin: clk_gen
        forever begin
            #1
            t_clk = 1;
            #1
            t_clk = 0;      
        end
    end
    
    initial begin: rst_gen
        begin
        #2
        t_rst = 1;
        end
    end
    
    initial begin: func_pc
        begin
        #8
        t_pc_in = 32'h01000004;
        #9
        t_pc_in = 32'h01000008;
        #10
        t_pc_in = 32'h0100000C;
        #11
        t_pc_in = 32'h0100001E;
        
        #20
        $finish;
        end
    end
    
endmodule
