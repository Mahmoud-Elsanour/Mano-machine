`timescale 1ns / 1ps

/*
* sequence_counter - A 4-bit counter with range from 0 to 15
*                    and the output gets decoded 
*
* Inputs:
*         - clk -> clock source
*         - rstn -> reset signal (active low)
*
* Outputs:
*          - count -> decoded timer output
*/

module sequence_counter(    input clk,
                            input rstn,
                            output [15:0] count);
    reg [3:0] i = 0;
 
    always @ (posedge clk)
        if (!rstn)
            i <= 0;
        else
            i = i + 1;
    
    assign count = 1<< i;
endmodule
