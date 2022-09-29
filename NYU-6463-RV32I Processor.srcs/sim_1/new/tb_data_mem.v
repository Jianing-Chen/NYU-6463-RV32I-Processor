`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/19 03:09:51
// Design Name: 
// Module Name: tb_data_mem
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


module tb_data_mem(

    );
    
    reg [31:0] address;
    reg [31:0] write_data;
    reg mem_write;
    reg mem_read;
    reg [1:0] control;
    wire [31:0] read_data;
    
    data_mem dut(
        .control(control),
        .address(address),
        .write_data(write_data),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .read_data(read_data)
    
    );
    
    initial begin:func_data_mem
    begin
        #1000;
        control <= 2'b10;
		address <= 32'h80343ec0;
		write_data <= 32'hdeadbeef;
		mem_write<=1;
		mem_read<=0;
		#1000;
		control <= 2'b10;
		address <= 32'h80323ed0;
		write_data <= 32'hdead0000;
		mem_write<=1;
		mem_read<=0;
		#1000;
		address<=32'h80343ec0;
		mem_read<=1;
		mem_write<=0;
		#1000;//
		if(read_data!=32'hdeadbeef)begin
		  $display("Test failed");
		  $finish;
		end
		
		#1000;
		address<=32'h00100000;
		#1000;
		$display(read_data);
		#1000;
		address<=32'h00100004;
		#1000;
		$display(read_data);
		#1000;
		address<=32'h00100008;
		#1000;
		$display(read_data);
		$display("Test passed");
		$finish;
    
    end
    end
    
endmodule
