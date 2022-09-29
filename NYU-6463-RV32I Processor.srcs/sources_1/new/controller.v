`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2021 11:44:30 AM
// Design Name: 
// Module Name: controller
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


module controller(
    input wire [6:0] op,
    input wire [2:0] func3,
    //input wire rst,
    input wire clk,
    output reg Branch, memRead, memtoReg, ALUOp1, ALUOp0, MemWrite, ALUsrc, RegWitre, memOp1, memOp2,
    output wire [2:0] state_FSM
    );
    
reg [2:0] state;
parameter state_IF = 3'b000;
parameter state_ID = 3'b001;
parameter state_EX = 3'b010;
parameter state_MEMread = 3'b011;
parameter state_MEMwrite = 3'b100;
parameter state_WB = 3'b101;
parameter state_WB_LUI = 3'b110;
parameter state_WB_J = 3'b111;
    
always @ (*)
    case(op)
            7'b0110011: begin ALUsrc <= 0; memtoReg <= 0; RegWitre <= 1; memRead <= 0; MemWrite <= 0; Branch <= 0; ALUOp1 <= 1; ALUOp0 <= 0; end //R_type
            7'b1100011: begin ALUsrc <= 0; memtoReg <= 0; RegWitre <= 0; memRead <= 0; MemWrite <= 0; Branch <= 1; ALUOp1 <= 0; ALUOp0 <= 1; end //Branch_type
            7'b0000011: begin 
                case(func3)
                    3'b000: begin ALUsrc <= 1; memtoReg <= 1; RegWitre <= 1; memRead <= 1; MemWrite <= 0; Branch <= 0; ALUOp1 <= 0; ALUOp0 <= 0; memOp1 <= 0; memOp2 <= 0; end //lb
                    3'b001: begin ALUsrc <= 1; memtoReg <= 1; RegWitre <= 1; memRead <= 1; MemWrite <= 0; Branch <= 0; ALUOp1 <= 0; ALUOp0 <= 0; memOp1 <= 1; memOp2 <= 0; end //lh
                    3'b010: begin ALUsrc <= 1; memtoReg <= 1; RegWitre <= 1; memRead <= 1; MemWrite <= 0; Branch <= 0; ALUOp1 <= 0; ALUOp0 <= 0; memOp1 <= 0; memOp2 <= 1; end //lw
                endcase
                end
            7'b0100011: begin 
                case(func3)
                    3'b000: begin ALUsrc <= 1; memtoReg <= 0; RegWitre <= 0; memRead <= 0; MemWrite <= 1; Branch <= 0; ALUOp1 <= 0; ALUOp0 <= 0; memOp1 <= 0; memOp2 <= 0; end //sb
                    3'b001: begin ALUsrc <= 1; memtoReg <= 0; RegWitre <= 0; memRead <= 0; MemWrite <= 1; Branch <= 0; ALUOp1 <= 0; ALUOp0 <= 0; memOp1 <= 1; memOp2 <= 0; end //sh
                    3'b010: begin ALUsrc <= 1; memtoReg <= 0; RegWitre <= 0; memRead <= 0; MemWrite <= 1; Branch <= 0; ALUOp1 <= 0; ALUOp0 <= 0; memOp1 <= 0; memOp2 <= 1; end //sw
                endcase
                end
            7'b0010011: begin ALUsrc <= 1; memtoReg <= 0; RegWitre <= 1; memRead <= 0; MemWrite <= 0; Branch <= 0; ALUOp1 <= 1; ALUOp0 <= 0;end //I_type
            7'b1100111: begin ALUsrc <= 0; memtoReg <= 0; RegWitre <= 1; memRead <= 0; MemWrite <= 0; Branch <= 1; ALUOp1 <= 1; ALUOp0 <= 1;end //jalr
            7'b1101111: begin ALUsrc <= 0; memtoReg <= 0; RegWitre <= 1; memRead <= 0; MemWrite <= 0; Branch <= 1; ALUOp1 <= 1; ALUOp0 <= 1;end //JAL
            7'b1110011: begin ALUsrc <= 0; memtoReg <= 0; RegWitre <= 1; memRead <= 0; MemWrite <= 0; Branch <= 0; ALUOp1 <= 1; ALUOp0 <= 1;end //ECALL
            7'b0001111: begin ALUsrc <= 0; memtoReg <= 0; RegWitre <= 0; memRead <= 0; MemWrite <= 0; Branch <= 0; ALUOp1 <= 1; ALUOp0 <= 1;end //fence
            7'b0110111: begin ALUsrc <= 0; memtoReg <= 0; RegWitre <= 1; memRead <= 0; MemWrite <= 0; Branch <= 0; ALUOp1 <= 1; ALUOp0 <= 1;end //LUI
            7'b0010111: begin ALUsrc <= 0; memtoReg <= 1; RegWitre <= 1; memRead <= 0; MemWrite <= 1; Branch <= 0; ALUOp1 <= 1; ALUOp0 <= 1;end //AUIPC
        endcase  
        
        
always @ (posedge clk)
begin
        state <= state_IF;
        case(state)
        state_IF:
            state <= state_ID;
        state_ID:
            case(op)
                7'b0110011: state <= state_EX;
                7'b1100011: state <= state_EX;
                7'b0000011: state <= state_EX;
                7'b0100011: state <= state_EX;
                7'b0010011: state <= state_EX;
                7'b1100111: state <= state_EX;
                7'b1101111: state <= state_EX;
                7'b0110111: state <= state_WB_LUI;
             endcase
         state_EX:
            case(op)
                7'b0110011: state <= state_WB;
                7'b1100011: state <= state_IF;
                7'b0000011: state <= state_MEMread;
                7'b0100011: state <= state_MEMwrite;
                7'b0010011: state <= state_WB; 
                7'b1100111: state <= state_WB_J;
                7'b1101111: state <= state_WB_J;
            endcase
         state_MEMread:
            state <= state_WB;
         state_MEMwrite:
            state <= state_IF;
         state_WB:
            state <= state_IF;
         state_WB_LUI:
            state <= state_IF;
         state_WB_J:
            state <= state_IF;
               
         default: state <= state_IF;
         endcase
         
      end      
              assign state_FSM = state;  
  
endmodule
