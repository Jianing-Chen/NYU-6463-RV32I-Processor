`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 11:40:44 PM
// Design Name: 
// Module Name: adder_b_test
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


module adder_b_test(

    );
    
    reg [31:0] addr_in;
    wire [31:0] addr_out;
    reg [31:0] alu_ctrl;
    adder_branch dut1(
    .addr_in(addr_in),
    .addr_out(addr_out),
    .alu_ctrl(alu_ctrl)
    );
    initial
    begin
    addr_in<=32'h01000000;
    alu_ctrl<=32'h00000001;
    #0.5;
    if(addr_out!=32'h01000002)begin
        $display("Test failed");
        $finish;
        end
    $display("Test passed");
    $finish;
    
    end
endmodule
