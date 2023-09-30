`timescale 1ns / 1ps

/*
* dff - a D flip-flop module
*
* Inputs:
*         - D -> input data
*         - NCLR -> reset signal (active low)
*         - CLK -> clock source
*         - LD -> load signal
*
* Outputs:
*          - Q -> output data
*/

module dff 	( input D,
              input NCLR,
              input CLK,
              input LD,
              output reg Q);
              
    initial Q = 0;

	always @ (posedge CLK)
       if (!NCLR)
          Q <= 0;
       else if (LD)
          Q <= D;
endmodule