`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Siyuan Huang
// 
// Create Date: 11/02/2021 02:42:01 AM
// Design Name: riscv processor
// Module Name: memtoreg_mux
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


module memtoreg_mux(
    input wire control,
    input wire [31:0] input0,
    input wire [31:0] input1,
    output wire [31:0] outwire
    );
    reg [31:0] outwire1;
    //state machine that switch the output
    always @(*) begin
    if (control==0) outwire1<=input0;
    else if(control==1) outwire1<=input1;
    end
    assign outwire=outwire1;
endmodule
