`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 11:40:44 PM
// Design Name: 
// Module Name: mux_2
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


module mux_2(

    );
    
    reg control;
    reg [31:0] input0;
    reg [31:0] input1;
    wire [31:0] outwire;
    
    branch_mux dut(
    .control(control),
    .input0(input0),
    .input1(input1),
    .outwire(outwire)
    );
    initial begin
    input0<=32'h01000000;
    input1<=32'h00000001;
    control<=0;
    #0.5;
    if(outwire!=32'h01000000)begin
        $display("Test failed");
        $finish;
        end
    #0.5;
    control<=1;
    #0.5;
        
    if(outwire!=32'h00000001)begin
        $display("Test failed");
        $finish;
        end
    $display("Test passed");
    $finish;
    end
endmodule
