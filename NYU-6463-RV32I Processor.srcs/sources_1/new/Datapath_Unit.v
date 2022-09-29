`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2021 07:53:26 PM
// Design Name: 
// Module Name: Datapath_Unit
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


module Datapath_Unit(
    input wire clk,rst,
    input wire Branch, memRead, memtoReg, ALUOp1, ALUOp0, MemWrite, ALUsrc, RegWitre, memOp1, memOp2, 
    input wire [2:0] state_datapath,
    output wire [6:0] op,
    output wire [2:0] func3,
    output wire done
    );

reg memRead1;
reg MemWrite1;

//u11: instruction_memory 
wire [31:0] instruction;

//u2: alu_ctrl
reg [6:0] fun7;

reg [2:0] fun3;

wire [3:0] opmode;

//u6: adder_4
wire [31:0] addr_out_4 ;

//u7: adder_branch
wire [31:0] addr_branch_out;

//u9: alu
wire [31:0] alu_out1;
wire zero;

//u4: branch_mux
wire and_gate;
assign and_gate = Branch & zero;
wire [31:0]outwire_branch_mux;

//u10: data_mem
wire [31:0] read_data;

//u8: imm_gen
wire [31:0] imm_out;

//u12: program_counter
wire [31:0] pc_out;

//u3: alusrc_mux
wire [31:0] outwire_alusrc_mux;

//u5: memtoreg_mux
wire [31:0] outwire_memtoreg_mux;

//u1: register
wire [4:0] rd_addr;
wire [4:0] rs1_addr;
wire [4:0] rs2_addr;
wire [31:0] rs1_data, rs2_data, rd_din;
reg swtich_instr;
reg switch_register;
reg switch_imm_gen;
reg switch_alu;


reg [31:0]instruction_read_address;

assign rd_addr = instruction[11:7];
assign rs1_addr = instruction[19:15];
assign rs2_addr = instruction[24:20]; 
reg[4:0]read_register1;
reg[4:0]read_register2;
reg[4:0]witre_register;
reg[31:0]write_data;
assign op = instruction[6:0];
assign func3 = instruction[14:12];


parameter state_IF = 3'b000;
parameter state_ID = 3'b001;
parameter state_EX = 3'b010;
parameter state_MEMread = 3'b011;
parameter state_MEMwrite = 3'b100;
parameter state_WB = 3'b101;
parameter state_WB_LUI = 3'b110;
parameter state_WB_J = 3'b111;

//    always @(posedge clk or negedge rst)begin
//        if (~rst) 
//            instruction_read_address <= 0;
//     end
     
    always @(posedge clk or negedge rst)begin
        if (~rst) 
            instruction_read_address <= 0;
            
        else if(state_datapath == state_IF)begin
           swtich_instr <= 1; instruction_read_address <= pc_out; 
           switch_alu<=0; switch_register<=0;memRead1 <= 0; MemWrite1 <= 0; end
        else if(state_datapath == state_ID)begin
             swtich_instr <= 0; 
             switch_alu<=0;
             switch_register<=1;
             read_register1 <= rs1_addr; 
             read_register2 <=rs2_addr; 
             memRead1 <= 0; MemWrite1 <= 0;end
         else if(state_datapath == state_EX)begin
         
         swtich_instr <= 0;switch_alu<=1; switch_register<=0; memRead1 <= 0; MemWrite1 <= 0;
         if (instruction[6:0] == 7'b0010011)
            begin
            fun7 <= 7'b0;
            fun3 <= instruction [14:12];
            end
          else 
          begin
          fun7 <= instruction [31:25]; 
          fun3 <= instruction [14:12];
          end
         end
         else if(state_datapath == state_MEMread)begin
         swtich_instr <= 0;switch_alu<=0; switch_register<=0; memRead1 <= 1; MemWrite1 <= 0;end
         else if(state_datapath == state_MEMwrite)begin
         swtich_instr <= 0;switch_alu<=0; switch_register<=0; memRead1 <= 0; MemWrite1 <= 1;end
         else if(state_datapath == state_WB)begin
         swtich_instr <= 0;switch_alu<=0; switch_register<=1;
             witre_register<=rd_addr;
             write_data <=outwire_memtoreg_mux;
             memRead1 <= 0; MemWrite1 <= 0;
             end
         else if (state_datapath == state_WB_LUI)
            begin
            swtich_instr <= 0;switch_alu<=0; switch_register<=1;
             witre_register<=rd_addr;
             write_data <= {instruction[31:12], 12'b0};
             memRead1 <= 0; MemWrite1 <= 0;
             end
          else if (state_datapath == state_WB_J)
            begin
            swtich_instr <= 0;switch_alu<=0; switch_register<=1;
             witre_register<=rd_addr;
             write_data <= pc_out;
             memRead1 <= 0; MemWrite1 <= 0;
         
            end
    end 

 //rgisters
 register u1( 
    .switch(switch_register),
    .control(RegWitre),   
    .rd_addr(witre_register),
    .rs1_addr(read_register1),
    .rs2_addr(read_register2),
    .rd_din(write_data),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data));
    
 // ALU control unit
 alu_ctrl u2(
    .opt0(ALUOp0),
    .opt1(ALUOp1),
    .fun7(fun7),
    .fun3(fun3),
    .opmode(opmode));
 
 // multiplexer alu_src
 alusrc_mux u3(    
    .control(ALUsrc),
    .input0(rs2_data),
    .input1(imm_out),
    .outwire(outwire_alusrc_mux));
 
 //multiplexer branch
 branch_mux u4(
    .control(and_gate),
    .input0(addr_out_4),
    .input1(addr_branch_out),
    .outwire(outwire_branch_mux));

 //mutiplexer memtoreg 
 memtoreg_mux u5(
    .control(memtoReg),
    .input0(alu_out1),
    .input1(read_data),
    .outwire(outwire_memtoreg_mux));
 
 //adder_4
 adder_4 u6(
    .addr_in(instruction_read_address),
    .addr_out(addr_out_4));
 
 //adder branch 
 adder_branch u7(    
    .addr_in_1(pc_out),
    .addr_in_2(imm_out),
    .addr_out(addr_branch_out));
 
 //imm generate
 imm_gen u8(
    .instruction(instruction),
    .imm_out(imm_out));
   
 // ALU 
 alu u9(
    .switch(switch_alu),
    .opmode(opmode),
    .in1(rs1_data),
    .in2(outwire_alusrc_mux),
    .zero(zero),
    .out1(alu_out1));
    
 // Data memory
 data_mem u10(
    .mem_write(MemWrite),
    .mem_read(memRead),
    .memOp1(memOp1),
    .memOp2(memOp2),
    .address(alu_out1),
    .write_data(rs2_data),
    .read_data(read_data),
    .clk(clk)
    );
 
 //instruction memory 
 instr_mem u11(
    .read_address(instruction_read_address),
    .instruction(instruction),
    .switch(swtich_instr),
    .done(done)
    );
 
 //program counter 
 program_counter u12(
    .clk(clk),
    .rst(rst),
    .pc_in(outwire_branch_mux),
    .pc_out(pc_out));
    

    
//    assign memRead=memRead1;
//    assign MemWrite=MemWrite1;
           
endmodule

