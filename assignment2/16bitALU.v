module ALU_64bit(
	output reg overflow16_1,
	output reg overflow16_2,
	output reg overflow16_3,
	output reg overflow16_4,
	output reg overflow32_1,
	output reg overflow32_2,
	output reg overflow64,
	output reg[63:0]z,
	input  [63:0]x,
	input [63:0]y,
	input [1:0]ops
	input [2:0]mode,
	input clock);

always@(posedge(clock))
begin

case(mode)
	3'b000:
		case(ops)
			2'b00:
				{overflow64,z} = {1'b0,x} + {1'b0,y};
			2'b01:
				{overflow64,z} = {1'b0,x} - {1'b0,y};
			2'b10: 
				if(x<=y) 
					begin
					z = y;
					end
				else
					begin
					z = x;
					end
			default: $display("ERROR: UNABLE TO SELECT AN ALU OP");
		endcase
	3'b001:
		case(ops)
			2'b00:
				begin
				{overflow32_1,z[63:32]} = {1'b0,x[63:32]} + {1'b0,y[63:32]};
				{overflow32_2,z[31:0]} = {1'b0,x[31:0]} + {1'b0,y[31:0]};
				end
			2'b01:
				begin
				{overflow32_1,z[63:32]} = {1'b0,x[63:32]} - {1'b0,y[63:32]};
				{overflow32_2,z[31:0]} = {1'b0,x[31:0]} - {1'b0,y[31:0]};
				end
			2'b10:
				begin
				if(x[63:32] <= [63:32])
					begin
					z[63:32] = y[63:32];
					end
				else
					begin
					z[63:32] = x[63:32];
					end
				if(x[31:0] <= y[31:0])
					begin
					z[31:0] = y[31:0];
					end
				else
					begin
					z[31:0] = x[31:0];
					end
				end
				default: $display("ERROR: UNABLE TO SELECT ANF ALU OP")
		endcase
	3'b010:
		case(ops)
			2'b00:
				begin
				{overflow16_1,z[63:48]} = {1'b0,x[63,48]} + {1'b0,y[63:48]};
				{overflow16_2,z[47:32]} = {1'b0,x[47:32]} + {1'b0,y[47:32]};
				{overflow16_3,z[31:16]} = {1'b0,x[31:16]} + {1'b0,y[31:16]};
				{overflow16_4,z[15:0]} = {1'b0,x[15:0]} + {1'b0,y[15:0]};
				end
			2'b01
				begin
				{overflow16_1,z[63:48]} = {1'b0,x[63,48]} - {1'b0,y[63:48]};
				{overflow16_2,z[47:32]} = {1'b0,x[47:32]} - {1'b0,y[47:32]};
				{overflow16_3,z[31:16]} = {1'b0,x[31:16]} - {1'b0,y[31:16]};
				{overflow16_4,z[15:0]} = {1'b0,x[15:0]} - {1'b0,y[15:0]};
				end
			2'b10:
				begin
				if(x[63:48] <= y[63:48])
					begin
					z[63:48] = y[63:48];
					end
				else
					begin
					z[63:48] = x[63:48];
					end
				if(x[47:32] <= y[47:32])
					begin
					z[47:32] = y[47:32];
					end
				else
					begin
					z[47:32] = x[47:32];
					end
				if(x[31:16] <= y[31:16])
					begin
					z[31:16] = y[31:16];
					end
				else
					begin
					z[31:16] = x[31:16];
					end
				if(x[15:0] <= y[15:0])
					begin
					z[15:0] = y[15:0];
					end
				else
					begin
					z[15:0] = x[15:0];
					end
				end
				default: $display("ERROR: UNABLE TO SELECT AND ALU OP");
		endcase
endcase
endmodule
					
					
				
				




				
		
