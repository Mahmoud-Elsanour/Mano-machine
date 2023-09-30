`timescale 1ns / 1ps

/*
* reg_12 - A 12-Bit parallel input parallel output register module
*
* Inputs:
*         - D -> 12-bit input data
*         - CLK -> clock source
*         - INR -> increment signal
*         - LD -> load signal
*         - NCLR -> reset signal (active low)
*
* Outputs:
*          - Q -> 12-bit output data
*/

module reg_12(  input [11:0] D,
                input CLK,
                input INR,
                input LD,
                input NCLR,
                output reg [11:0] Q);

    initial begin
        Q <= 0;
    end

    always @ (posedge CLK)
        if (!NCLR)
            Q <= 0;
        else begin
            if(LD)
                Q <= D;
            else if (INR)
                Q <= Q + 1;
    end
endmodule
