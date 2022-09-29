`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jianing Chen
// 
// Create Date: 2021/11/18 17:52:11
// Design Name: 
// Module Name: program_counter
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


module program_counter(
        input wire clk,
        input wire rst,
        input wire [31:0] pc_in,
        output reg [31:0] pc_out
    );

reg [3:0] cnt;


always @(posedge clk or negedge rst)
begin
    if (rst == 0)
        pc_out <= 32'h01000000;
    else //if(cnt == 4'b0100)
        pc_out <= pc_in;

end

//always @(posedge clk or negedge rst)
//begin
//if (rst == 0)
//    cnt <= 4'b0000;
//    else begin
//    if (cnt == 4'b0100)
//        cnt <= 4'b0000;
//    else 
//        cnt <= cnt + 4'b1;
//    end
//end  
    
    
endmodule
