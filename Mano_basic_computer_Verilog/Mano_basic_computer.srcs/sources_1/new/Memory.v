`timescale 1ns / 1ps

/*
* Mem - A 4096-Bit SRAM module
*
* Inputs:
*         - addr -> 12-bit address
*         - r -> read signal
*         - w -> write signal
*         - wdata -> 16-bit input data
*
* Outputs:
*          - rdata -> 16-bit output data
*/

module mem ( input [11:0] addr,
             input r, 
             input w,
             input [15:0] wdata,
             output reg [15:0] rdata);

    reg [15:0] register [4095:0];

    initial begin
        $readmemh("C:/Users/ItShop/OneDrive/Documents/Vivado/Mano_basic_computer/memory.txt", register);
    end

    always @* begin
            if (w && ~r)
                register[addr] <= wdata;
            else if (~w && r)
                rdata = register[addr];
    end
endmodule