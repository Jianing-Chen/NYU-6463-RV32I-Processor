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

module alu_ctrl_test ();
    reg opt0;
    reg opt1;
    reg [6:0] fun7;
    reg [2:0] fun3;
    wire [3:0] opmode;
    
    alu_ctrl dut1(
    .opt0(opt0),
    .opt1(opt1),
    .fun7(fun7),
    .fun3(fun3),
    .opmode(opmode)
    
    );
    
    initial begin
    opt0<=1;
    opt1<=0;
    #0.5;
    if(opmode!=4'b0110)begin
        $display("Test failed");
        $finish;
        end
        
    opt0<=0;
    opt1<=0;
    #0.5;
    if(opmode!=4'b0010)begin
        $display("Test failed");
        $finish;
        end
    opt0<=0;
    opt1<=1;
    fun3<=3'b000;
    fun7<=7'b0;
    #0.5;
    if(opmode!=4'b0010)begin
        $display("Test failed");
        $finish;
        end
    #0.5;
    fun3<=3'b110;
    fun7<=7'b0;
    #0.5;
    if(opmode!=4'b0001)begin
        $display("Test failed");
        $finish;
        end
    #0.5;
    fun3<=3'b101;
    fun7<=7'b0;
    #0.5;
    if(opmode!=4'b1001)begin
        $display("Test failed");
        $finish;
        end
    #0.5;
    fun3<=3'b000;
    fun7<=7'b0100000;
    #0.5;
    if(opmode!=4'b0110)begin
        $display("Test failed");
        $finish;
        end
        
    #0.5;
    fun3<=3'b101;
    fun7<=7'b0100000;
    #0.5;
    if(opmode!=4'b1010)begin
        $display("Test failed");
        $finish;
        end
    $display("Test passed");
    $finish;
    
    end
endmodule