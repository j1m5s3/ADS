module mc14585(input [3:0] A,B, input AlB_in,AgB_in,AeqB_in,output AlB_out,AgB_out,AeqB_out);
	wire[3:0] xxor,notA,notB,nand0,or0;
	wire notAlB_in,notAeqB_in,nand1,nor0;
	//assign AlB_in = 0;
//	assign AgB_in = 0;
//	assign AeqB_in = 1;
	
	not n0(notAlB_in,AlB_in);
	not n1(notAeqB_in,AeqB_in);
	not n2(notA[0],A[0]);
	not n3(notA[1],A[1]);
	not n4(notA[2],A[2]);
	not n5(notA[3],A[3]);
	not n6(notB[0],B[0]);
	not n7(notB[1],B[1]);
	not n8(notB[2],B[2]);
	not n9(notB[3],B[3]);

	xor x0(xxor[0],A[0],B[0]);
	xor x1(xxor[1],A[1],B[1]);
	xor x2(xxor[2],A[2],B[2]);
	xor x3(xxor[3],A[3],B[3]);
	
	nand na0(nand0[0],notA[0],B[0]);
	nand na1(nand0[1],notA[1],B[1]);
	nand na2(nand0[2],notA[2],B[2]);
	nand na3(nand0[3],notA[3],B[3]);

	or oR0(or0[0],xxor[3],xxor[2],xxor[1],xxor[0],notAlB_in);
	or oR1(or0[1],xxor[3],xxor[2],xxor[1],nand0[0]);
	or oR2(or0[2],xxor[3],xxor[2],nand0[1]);
	or oR3(or0[3],xxor[3],nand0[2]);

	nand na4(nand1,or0[0],or0[1],or0[2],or0[3],nand0[3]);
	nand na5(AlB_out,or0[0],or0[1],or0[2],or0[3],nand0[3]);//output A<B

	nor not_oR0(AeqB_out,xxor[0],xxor[1],xxor[2],xxor[3],notAeqB_in);//output A=B
	nor not_oR2(AgB_out,nand1,AeqB_out);//output A>B
endmodule		 