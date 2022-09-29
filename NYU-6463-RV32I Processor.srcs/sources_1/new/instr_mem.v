`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jianing Chen
// 
// Create Date: 2021/11/17 18:37:41
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(
        input wire [31:0] read_address,
        input wire switch,
        output wire [31:0] instruction,
        output wire done
    );
reg done1;   
reg [31:0] memory [0:1023]; 
reg [31:0]buffer;
reg [1:0]nop; 
initial begin
    $readmemh ("instruction.mem", memory);
    //$readmemb ("instruction.mem", memory);
end

always @(*)begin
case (switch)
    1'b0: nop <= nop + 0;
    1'b1: buffer <= memory[(read_address - 32'h01000000) >> 2];
    endcase 
end    

always @(*) begin

    if (buffer == 32'b0) 
        done1 <= 1;
    else done1 <= 0;

end

assign instruction = buffer;
assign done = done1;
    
endmodule

