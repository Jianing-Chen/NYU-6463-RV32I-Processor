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


module adder_test();
    reg [31:0] addr_in;
    wire [31:0] addr_out;
    adder_4 dut1(
    .addr_in(addr_in),
    .addr_out(addr_out)
    );
    initial
    begin
    addr_in<=32'h01000000;
    #0.5;
    if(addr_out!=32'h01000004)begin
        $display("Test failed");
        $finish;
        end
    $display("Test passed");
    $finish;
    
    end
endmodule