`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 07:06:23 AM
// Design Name: 
// Module Name: decoder_tb
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


module decoder_tb();

reg [2:0] input_tb;
wire [7:0] D_tb;

decoder d (.in_d(input_tb), .out_d(D_tb));

    initial begin

        for (input_tb = 0; input_tb < 7; input_tb = input_tb  + 1) begin
            #10 $display ("D[%d] = %b", input_tb , D_tb);
        end
    end 
 
endmodule
