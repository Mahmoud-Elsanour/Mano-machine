`timescale 1ns / 1ps

/*
* selection_line - the module where the register that puts its
*                  data on the comman bus is selected
*
* Inputs: 
*         - AR -> Address Register content
*         - PC -> Program Counter content
*         - DR -> Data Register content
*         - AC -> Accumulator content
*         - IR -> Instruction Register content
*         - TR -> Temporary Register content
*         - MEM -> Memory content
*
* Outputs:
*         - BUS -> 16-bit comman bus
*/

module selection_line ( input   [15:0] AR, [15:0] PC, [15:0] DR, [15:0] AC, [15:0] IR, [15:0] TR, [15:0] MEM, [7:0] sel,
				        output  reg [15:0] BUS);

    always@*
		case(sel)
		  0 : BUS = 0;
		  2 : BUS = AR;
		  4 : BUS = PC;
		  8 : BUS = DR;
		  16 : BUS = AC;
		  32 : BUS = IR;
		  64 : BUS = TR;
		  128 : BUS = MEM;
		  default : BUS = 0;
		endcase
endmodule
