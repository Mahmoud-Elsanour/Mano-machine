`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2023 02:03:42 AM
// Design Name: 
// Module Name: Memory_tb
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

module Memory_tb();
    reg [11:0] addr_tb;
    reg r_tb; 
    reg w_tb;
    reg [15:0] wdata_tb;
    wire [15:0] rdata_tb;
    Mem RAM (.r(r_tb), .w(w_tb), .wdata(wdata_tb), .addr(addr_tb), .rdata(rdata_tb));

    initial begin
        wdata_tb <= 0;
        addr_tb <= 0;
        r_tb <= 1;
        w_tb <= 0;
        
        #5 addr_tb <= 1;
       // $display (rdata_tb);
        #5 wdata_tb <= 'habcd;
        #5 r_tb <= 0;
        w_tb <= 1;
        
        #5 r_tb <= 1;
        w_tb <= 0;
       // $display (rdata_tb);
    end
    
    
endmodule
