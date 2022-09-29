`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/17 18:37:41
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input wire [31:0] address,
    input wire [31:0] write_data,
    input wire mem_write,
    input wire mem_read,
    input wire memOp1,
    input wire memOp2,
    input wire clk,
    //input wire [1:0] control,//0:SB; 1:SH; 2:SW
    output wire [31:0] read_data
    );
    wire [1:0] control;
    assign control = {memOp2, memOp1};
    
    //Memory address implementation:
    //Address= Valid RAM[31], tags[30:13], index[12:2], offset[1:0] 
    //8 byte a word, 4 word a block
    //Data stored: DMEM1:content, DMEM2 valid bit and tags. Same size,should be merged
    //Same tag, index, write will be overwrite offset part.
    //Different tag, write will be overwrite entire block.
    //Same tag, index, read data will be returned normally. 
    //Different tag, will not be read. 

    reg [10:0] index;
    reg [1:0] offset;
    reg [17:0] tag;
    reg [31:0] DMEM_1[2047:0];
    reg [31:0] DMEM_2[2047:0];
    reg [31:0] mem_buf;
    reg [31:0] tag_buf;
    reg [1:0] nothing;
    
    initial begin //read-only mem
    $readmemh("DMEM_1.mem", DMEM_1);
    $readmemh("DMEM_2.mem", DMEM_2);
    end
    
    always @(posedge clk) begin
    
    index <= address[12:2];
    offset <= address[1:0];
    tag <= address[30:13];
    mem_buf <= DMEM_1[index];
    tag_buf <= DMEM_2[index];
    //Certain tag will not be overwrite
    if(address[31]==1 & mem_write==1'b1 & tag_buf[17:0]!=18'b000000000010000000)begin
        if(tag==tag_buf[17:0])begin
            if(control==2'b00)begin
	           case(offset)
	               2'b00:mem_buf[7:0]<=write_data[7:0];
	               2'b01:mem_buf[15:8]<=write_data[7:0];
	               2'b10:mem_buf[23:16]<=write_data[7:0];
	               2'b11:mem_buf[31:24]<=write_data[7:0];
	               default:nothing<=0;
	           endcase
	       end 
	       else if(control==2'b01)begin
	           case(offset)
	               2'b00:mem_buf[15:0]<=write_data[15:0];
	               2'b10:mem_buf[31:16]<=write_data[15:0];
	               default:nothing<=0;
	           endcase
	       end 
	       else mem_buf<=write_data;
	       end
	
	//DMEM_1[index]<=mem_buf;
	//$writememh("DMEM_1.mem", DMEM_1);
	
	else begin
	if(control==2'b00)begin
	case(offset)
	   2'b00:mem_buf<={24'b0,write_data[7:0]};
	   2'b01:mem_buf<={16'b0,write_data[7:0],8'b0};
	   2'b10:mem_buf<={8'b0,write_data[7:0],16'b0};
	   2'b11:mem_buf<={write_data[7:0],24'b0};
	   default:nothing<=0;
	endcase
	end 
	else if(control==2'b01)begin
	case(offset)
	   2'b00:mem_buf<={16'b0,write_data[15:0]};
	   2'b10:mem_buf<={write_data[15:0],16'b0};
	   default:nothing<=0;
	endcase
	end 
	else mem_buf<=write_data;
	
	   tag_buf[18]<=1'b1;
	   tag_buf[17:0]<=tag;
	   DMEM_1[index]=mem_buf;
	   DMEM_2[index]=tag_buf;
	   nothing<=0;
	//Seems that those are system verilog feature
	
	end
	
	end
	else if (address[31]==1 & mem_read==1'b1)begin
	if(tag==tag_buf[17:0] & tag_buf[18]==1)begin
	case(control)
	   2'b00: begin
	       case(offset)
	           2'b00:mem_buf<={24'b0,mem_buf[7:0]};
	           2'b01:mem_buf<={24'b0,mem_buf[15:8]};
	           2'b10:mem_buf<={24'b0,mem_buf[23:16]};
	           2'b11:mem_buf<={24'b0,mem_buf[31:24]};
	endcase
	end
	   2'b01:begin 
	       case(offset)
	           2'b00:mem_buf<={16'b0,mem_buf[15:0]};
	           2'b10:mem_buf<={16'b0,mem_buf[31:16]};
	endcase
	end
	endcase
	end else if (tag!=tag_buf[17:0] | tag_buf[18]==0)begin
	   mem_buf <= "ZZZZZZZZ";
	end
	end 
	
	end
	assign read_data = mem_buf;
	
endmodule
