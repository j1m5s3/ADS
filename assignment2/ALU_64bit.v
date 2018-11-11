module ALU_64bit(
		input [63:0]x,
		input [63:0]y,
		input [1:0]bit_mode,//16bit,32bit,64bit
		input [1:0]op_select,//add,sub,x == y, x > y
		output [63:0]z,//Final output
		output carry_64bit);

reg [63:0]result;//Result from ALUs

wire [64:0]temp_64bit;
//wire [32:0]temp_32bit;
//wire [16:0]temp_16bit;

assign z = result;
assign temp_64bit = {1'b0,x} + {1'b0,y};
//assign temp_32bit = {1'b0,x} + {1'b0,y};
//assign temp_16bit = {1'b0,x} + {1'b0,y};

assign carry_64bit = temp_64bit[64];
//assign carry_32bit = temp_32bit[32];
//assign carr_16bit = temp_16bit[16];

always @(*) begin
	case(bit_mode) 
		2'b00: begin //16bit
			result[63:48] = x[63:48] + y[63:48];//add  x+y 
			result[47:32] = x[47:32] - y[47:32];//sub x-y 
			result[31:16] = (x[31:16] == y[31:16])?16'd1:16'd0;//Eq compare x==y 
			result[15:0] = (x[15:0] > y[15:0])?16'd1:16'd0;//Greater than compare
		end
		2'b01://32bit
			case(op_select) 
				2'b00: begin//add x+y and Eq compare
					result[63:32] = x[63:32] + y[63:32];
					result[31:0] = (x[31:0] == y[31:0])?32'd1:32'd0;
				end
				2'b01: begin//sub and Greater than compare
					result[63:32] = x[63:32] - y[63:32];
					result[31:0] = (x[31:0] > y[31:0])?32'd1:32'd0;
				end	
			endcase
		2'b10://64bit
			case(op_select) 
				2'b00: begin//add x+y
					result = x + y;
				end
				2'b01: begin//sub x-y
					result = x - y;
				end
				2'b10: begin//Eq compare x == y
					result = (x == y)?64'd1:64'd0;
				end
				2'b11: begin//Greater than compare
					result = (x > y)?64'd1:64'd0;
				end
			endcase
		default: result = x + y;
	endcase
end
endmodule

module ALU_64bit_tb();
	reg[63:0]x;
	reg[63:0]y;
	reg[1:0]bit_mode;
	reg[1:0]op_select;
	
	
	wire[63:0]z;
	wire carry_64bit;
	
	integer i;
	ALU_64bit test_unit(
		x,
		y,
		bit_mode,
		op_select,
		z,
		carry_64bit);

	initial 
	begin
		x = 64'h0A;
		y = 64'h02;
		bit_mode = 2'h00;//16bit
		op_select = 2'h00;	
		#10
		$display("x:%b, y:%b",x,y);
		$display("z=%b",z);
		x = 64'h0A;
		y = 64'h02;
		bit_mode = 2'h01;//32bit
		op_select = 2'h00;
		#10
		$display("x:%b, y:%b",x,y);
		$display("z=%b",z);
		x = 64'h0A;
		y = 64'h02;
		bit_mode = 2'h01;//32bit
		op_select = 2'h01;	
		#10
		$display("x:%b, y:%b",x,y);
		$display("z=%b",z);
		x = 64'h0A;
		y = 64'h02;
		bit_mode = 2'h10;//64bit
		op_select = 2'h00;	
		#10	
		$display("x:%b, y:%b",x,y);
		$display("z=%b",z);
		for(i = 0; i<2; i=i+1)
		begin
		op_select = op_select +2'h01;
		#10
		$display("x:%b, y:%b",x,y);
		$display("z=%b",z);
		end
	end
endmodule
	
			
					

			