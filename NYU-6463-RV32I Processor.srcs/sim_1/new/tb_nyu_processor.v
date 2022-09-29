`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2021 02:23:26 AM
// Design Name: 
// Module Name: tb_nyu_processor
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


module tb_nyu_processor(

    );
     // Inputs
     reg clk = 0;
     reg rst;
     // Instantiate the Unit Under Test (UUT)
     nyu_Processor dut (
      .clk(clk),
      .rst(rst)
     );
     
//  initial 
//  begin
//   clk <=0;
//   $finish;
//  end

//generate clock
    initial begin: clk_gen
        forever begin
            #10
            clk = 1;
            #10
            clk = 0;
            
        end
    end
     
     //generate reset signal
    initial begin: rst_gen
        begin
        rst = 0;
        #20
        rst = 1;
        end
    end
     
endmodule
