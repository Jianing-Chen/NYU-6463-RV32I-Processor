`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2021 10:10:37 PM
// Design Name: 
// Module Name: alu_test
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


module alu_test(

    );
    
    reg [3:0] opmode;
    wire zero;
    reg [31:0] in1;
    reg [31:0] in2;
    wire [31:0] out1;
    
    alu dut1(
    .opmode(opmode),
    .zero(zero),
    .in1(in1),
    .in2(in2),
    .out1(out1)
    
    );
    
    initial begin
    opmode<=4'b0110;
    in1<=32'h00000008;
    in2<=32'h00000004;
    #0.5;
    if(out1!=32'h00000004)begin
        $display("Test failed1");
        $finish;
        end
    #0.5;
    in1<=32'h00000008;
    in2<=32'h00000004;
    opmode<=4'b0010;
    #0.5;
    if(out1!=32'h0000000c)begin
        $display("Test failed2");
        $finish;
        end
    #0.5;
    in1<=32'h00000001;
    in2<=32'h00000002;
    opmode<=4'b0001;
    #0.5;
    if(out1!=32'h00000003)begin
        $display("Test failed3");
        $finish;
        end
    #0.5;
    in1<=32'h00000001;
    in2<=32'h00000001;
    opmode<=4'b0000;
    #0.5;
    if(out1!=32'h00000001)begin
        $display("Test failed");
        $finish;
        end
    #0.5;
    in1<=32'h00000002;
    in2<=32'h00000001;
    opmode<=4'b1010;
    #0.5;
    if(out1!=32'h00000001)begin
        $display("Test failed");
        $finish;
        end
    #0.5;
    in1<=32'h00000002;
    in2<=32'h00000001;
    opmode<=4'b1001;
    #0.5;
    if(out1!=32'h00000001)begin
        $display("Test failed");
        $finish;
        end
    #0.5;
    in1<=32'h00000002;
    in2<=32'h00000001;
    opmode<=4'b1000;
    #0.5;
    if(out1!=32'h00000004)begin
        $display("Test failed");
        $finish;
        end
    #0.5;
    $display("Test passed");
    $finish;
    end
endmodule
