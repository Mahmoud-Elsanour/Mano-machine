`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2023 11:19:34 PM
// Design Name: 
// Module Name: Sequence_Counter_tb
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


module Sequence_Counter_tb();

reg clk_tb;
reg rstn_tb;
wire [15:0] count_tb;
integer i;

sequence_counter sc (.clk(clk_tb), .rstn(rstn_tb), .count(count_tb));

always #5 clk_tb = ~clk_tb;

initial begin
    clk_tb <= 0;
    rstn_tb <= 1;

    for (i = 0; i < 16; i = i + 1) begin
        #10 $display ("T[%d] = %b", i, count_tb);
    end
end 

endmodule
