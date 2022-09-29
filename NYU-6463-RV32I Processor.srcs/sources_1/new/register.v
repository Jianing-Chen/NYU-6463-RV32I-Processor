`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2021 06:47:27 PM
// Design Name: 
// Module Name: register
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


module register(
    input wire control,
    input wire [4:0] rd_addr,
    input wire [4:0] rs1_addr,
    input wire [4:0] rs2_addr,
    input wire [31:0] rd_din,
    input wire switch,
    output wire [31:0] rs1_data, rs2_data
    );
    reg [31:0] rs1_data1;
    reg [31:0] rs2_data1;
    reg [31:0] reg_array [0:31];
    reg [1:0]nop; 
    integer i;
    
    initial begin
    reg_array[0] <= 32'b0;
    reg_array[1] <= 32'b0;
    reg_array[2] <= 32'b0;
    reg_array[3] <= 32'b0;
    reg_array[4] <= 32'b0;
    reg_array[5] <= 32'b0;
    reg_array[6] <= 32'b0;
    reg_array[7] <= 32'b0;
    reg_array[8] <= 32'b0;
    reg_array[9] <= 32'b0;
    reg_array[10] <= 32'b0;
    reg_array[11] <= 32'b0;
    reg_array[12] <= 32'b0;
    reg_array[13] <= 32'b0;
    reg_array[14] <= 32'b0;
    reg_array[15] <= 32'b0;
    reg_array[16] <= 32'b0;
    reg_array[17] <= 32'b0;
    reg_array[18] <= 32'b0;
    reg_array[19] <= 32'b0;
    reg_array[20] <= 32'b0;
    reg_array[21] <= 32'b0;
    reg_array[22] <= 32'b0;
    reg_array[23] <= 32'b0;
    reg_array[24] <= 32'b0;
    reg_array[25] <= 32'b0;
    reg_array[26] <= 32'b0;
    reg_array[27] <= 32'b0;
    reg_array[28] <= 32'b0;
    reg_array[29] <= 32'b0;
    reg_array[30] <= 32'b0;
    reg_array[31] <= 32'b0;
    end
    
    always@(posedge switch)begin
      //if(control == 0 )begin 
//          for(i=0;i<32;i=i+1)begin
//           reg_array[i] = i;
           //end
          rs1_data1 = reg_array[rs1_addr];
          rs2_data1 = reg_array[rs2_addr];
    //end
    end
    
    
    always @ (posedge switch)begin
       if(control == 1 & rd_addr!=5'b0) 
        reg_array[rd_addr] <= rd_din;
//       else
//        reg_array[rd_addr] <= reg_array[rd_addr];
    end
    assign rs1_data = rs1_data1;
    assign rs2_data = rs2_data1;
    
endmodule

