`timescale 1ns / 1ps

/*
* decoder - a decoder module
*
* Inputs:
*         - in_d -> 3-bit input data
*
* Outputs:
*          - out_d -> 3-bit output data
*/

module decoder( input [2:0] in_d,
                output [7:0] out_d);
    assign out_d =  1 << in_d; 
endmodule
