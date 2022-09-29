`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/19 00:16:11
// Design Name: 
// Module Name: tb_imm_gen
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


module tb_imm_gen(

    );
    reg [31:0] t_instruction;
    wire [31:0] t_imm_out;
    
    imm_gen dut(
        .instruction(t_instruction),
        .imm_out(t_imm_out)
    );
    
    initial begin: func_imm_gen
        //R-Type instruction		
		#5 t_instruction=32'b00000000000000000000000000110011; //AND
		#5 t_instruction=32'b01000000000000000000000000110011; //SUB
		#5 t_instruction=32'b01000000000000000010000000110011; //SLT
		#5 t_instruction=32'b00000000000000000110000000110011; //OR 
		#5 t_instruction=32'b00000000000000000111000000110011; //AND
																			  
		//I-Type instructions										  
		#5 t_instruction=32'b00010000010000000000000000010011; //ADDI
		#5 t_instruction=32'b10000000000100000011000000010011; //LD    
																		  
        //S-Type instructions									  
		#5 t_instruction=32'b10000000000000000011000010100011; //SD 
																		  
		//SB-Type instructions										  
		#5 t_instruction=32'b11010000000000000000001001100011; //BEQ
		
		//LUI
		#5 t_instruction=32'b00000000011001100001000100110111;
		
		//AUIPC
		#5 t_instruction=32'b00010010100010000101010100010111;
		
		//JAL
		#5 t_instruction=32'b01011010100110001101010101101111;
		
		//JALR
		#5 t_instruction=32'b00010110000000000000000001100111;
		
		#10 $finish;
    
    
    end
    
endmodule
