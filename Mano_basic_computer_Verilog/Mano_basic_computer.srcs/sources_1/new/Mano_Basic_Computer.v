`timescale 1ns / 1ps

/*
* mano_basic_computer - This is the module where all the parts are connected
*                       and LD and CLR logic is written.
*                       (INR is written in the adder_and_logic_circuit module)
*
* Inputs: 
*         - clk_master -> master clock source
*         - IN_DATA -> input device data
*         - IN_CLK -> input device clock
*         - OUT_CLK -> output device clock
*         
* Outputs:
*         - T -> decoder output of SC[15:0]
*         - out_AR -> current value in the Address Register
*         - out_PC -> current value in the Program Counter
*         - out_DR -> current value in the Data Register
*         - out_AC -> current value in the Accumulator
*         - out_E -> current value in the Extended Flag
*         - out_IR -> current value in the Instruction Register
*         - D -> decoder output of IR[14:12]
*         - out_TR -> current value in the Temporary Register
*         - out_INPR -> current value in the Input Register
*         - out_OUTR -> the current value in the Output Register
*         - out_R -> current value in the Interrupt Flag
*         - out_IEN -> current value in the Interrupt Enable Flag
*         - out_FGI -> current value in the Input Flag
*         - out_FGO -> current value in the Output Flag
*/

module mano_basic_computer ( input clk_master,
                             output [15:0] T,
                             output wire [11:0] out_AR,
                             output wire [11:0] out_PC,
                             output wire [15:0] out_DR,
                             output wire [15:0] out_AC,
                             output wire out_E,
                             output wire [15:0] out_IR,
                             output wire [7:0] D,
                             output wire [15:0] out_TR,
                             output wire [7:0] out_INPR,
                             input [7:0] IN_DATA,
                             input IN_CLK,
                             output wire [7:0] out_OUTR,
                             input OUT_CLK,
                             output wire out_R,
                             output wire out_IEN,
                             output wire out_FGI,
                             output wire out_FGO);
    
    ////////////////////////-[MANO STUFF]-////////////////////////
    wire [15:0] common_bus;     // the Comman Bus
    wire [3:0] INR;             // increment output from adder_and_logic_circuit module
    wire [15:0] B = out_IR;     // equals the IR output (used in Register and I/O Reference)
    
    ////////////////////////-[Flip Flops]-////////////////////////
    wire I = out_IR[15];        // Indirect Flag
    wire S;                     // Stop Flag
    
    ////////////////////////-[ADDRESS REGISTER]-////////////////////////
    wire [11:0] in_AR = common_bus;
    wire clk_AR = clk_master;
    wire inr_AR = INR[0];
    wire ld_AR = ((~out_R) && T[0]) || ((~out_R) && T[2]) || ((~D[7]) && I && T[3]);
    wire nclr_AR = ~(out_R && T[0]);
    reg_12 AddressRegister(.D(in_AR), .CLK(clk_AR), .NCLR(nclr_AR), .Q(out_AR), .LD(ld_AR), .INR(inr_AR));
    
    ////////////////////////-[PROGRAM COUNTER]-////////////////////////
    wire [11:0] in_PC = common_bus;
    wire clk_PC = clk_master;
    wire inr_PC = INR[1];
    wire ld_PC = (D[4] && T[4]) || (D[5] && T[5]);
    wire nclr_PC = ~(out_R && T[1]);
    reg_12 ProgramCounter (.D(in_PC), .CLK(clk_PC), .NCLR(nclr_PC), .Q(out_PC), .LD(ld_PC), .INR(inr_PC));
    
    ////////////////////////-[DATA REGISTER]-////////////////////////
    wire [15:0] in_DR = common_bus;
    wire clk_DR = clk_master;
    wire inr_DR = INR[2];
    wire ld_DR = (D[0] && T[4]) || (D[1] && T[4]) || (D[2] && T[4]) || (D[6] && T[4]);
    reg nclr_DR = 1;
    reg_16 DataRegister (.D(in_DR), .CLK(clk_DR), .NCLR(nclr_DR), .Q(out_DR), .LD(ld_DR), .INR(inr_DR));
    
    ////////////////////////-[ACCUMULATOR]-////////////////////////
    wire [15:0] in_AC;
    wire clk_AC = clk_master;
    wire inr_AC = INR[3];
    wire ld_AC = (D[0] && T[5]) || (D[1] && T[5]) || (D[2] && T[5]) || ((D[7] && (~I) && T[3]/*r*/) && B[9]) || ((D[7] && (~I) && T[3]/*r*/) && B[7]) || ((D[7] && (~I) && T[3]/*r*/) && B[6] || ((D[7] && (I) && T[3]/*p*/) && B[11]));
    wire nclr_AC = ~((D[7] && (~I) && T[3]) && B[11]);
    reg_16 Accumulator (.D(in_AC), .CLK(clk_AC), .NCLR(nclr_AC), .Q(out_AC), .LD(ld_AC), .INR(inr_AC));

    ////////////////////////-[EXTENDED FLAG]-////////////////////////
    wire in_E;
    wire clk_E = clk_master;
    wire ld_E = (D[1] && T[5]) || ((D[7] && (~I) && T[3]/*r*/) && B[7]) || ((D[7] && (~I) && T[3]/*r*/) && B[6]) || ((D[7] && (~I) && T[3]/*r*/) && B[8]);
    wire nclr_E = ~(((D[7] && (~I) && T[3]/*r*/) && B[10]));
    dff E (.D(in_E), .CLK(clk_E), .NCLR(nclr_E), .Q(out_E), .LD(ld_E));
    
    ////////////////////////-[INSTRUCTION REGISTER]-////////////////////////
    wire [15:0] in_IR = common_bus;
    wire clk_IR = clk_master;
    wire inr_IR = 0;
    wire ld_IR = (~(out_R) && T[1]);
    reg nclr_IR = 1;
    reg_16 InstructionRegister (.D(in_IR), .CLK(clk_IR), .NCLR(nclr_IR), .Q(out_IR), .LD(ld_IR), .INR(inr_IR));

    ////////////////////////-[DECODER]-////////////////////////
    decoder d (.in_d(out_IR[14:12]), .out_d(D));
     
    ////////////////////////-[TEMPORAY REGISTER]-////////////////////////
    wire [15:0] in_TR = common_bus;
    wire clk_TR = clk_master;
    wire inr_TR = 0;
    wire ld_TR = out_R && T[0];
    wire nclr_TR = 1;
    reg_16 TemporaryRegister (.D(in_TR), .CLK(clk_TR), .NCLR(nclr_TR), .Q(out_TR), .LD(ld_TR), .INR(inr_TR));

    ////////////////////////-[MEMORY]-///////////////////////
    wire r_M =  ((~out_R) && T[1]) || ((~D[7]) && I && T[3]) || (D[0] && T[4]) || (D[1] && T[4]) || (D[2] && T[4]) || (D[6] && T[4]);
    wire w_M = ((out_R && T[1]) || D[3] && T[4]) || (D[5] && T[4]) || (D[6] && T[6]);
    wire [15:0] in_data_M = common_bus;
    wire [15:0] out_data_M;
    mem RAM (.addr(out_AR), .r(r_M), .w(w_M), .wdata(in_data_M), .rdata(out_data_M));
    
    ////////////////////////-[INPUT REGISTER]-////////////////////////
    wire [7:0] in_INPR = IN_DATA;
    wire clk_INPR = out_INPR ? clk_master : IN_CLK;
    wire inr_INPR = 0;
    wire ld_INPR = ~(out_FGI);
    wire nclr_INPR = ~(out_FGI & clk_master & ((D[7] && (I) && T[3]/*p*/) && B[11]));
    assign out_FGI = out_INPR ? 1 : 0;
    reg_16 InputRegister (.D(in_INPR), .CLK(clk_INPR), .NCLR(nclr_INPR), .Q(out_INPR), .LD(ld_INPR), .INR(inr_INPR));

    ////////////////////////-[OUTPUT REGISTER]-////////////////////////
    wire [7:0] in_OUTR = common_bus;
    wire clk_OUTR = out_OUTR ? OUT_CLK : clk_master;
    wire inr_OUTR = 0;
    wire ld_OUTR = ((D[7] && (I) && T[3]/*p*/) && B[10]);
    wire nclr_OUTR = ~(~(out_FGO) & OUT_CLK);
    assign out_FGO = out_OUTR ? 0 : 1;
    reg_16 OutputRegister (.D(in_OUTR), .CLK(clk_OUTR), .NCLR(nclr_OUTR), .Q(out_OUTR), .LD(ld_OUTR), .INR(inr_OUTR));
    
    ////////////////////////-[INTERRUPT ENABLE FLAG]-////////////////////////
    wire in_IEN = 1;
    wire clk_IEN = clk_master;
    wire ld_IEN = (D[7] && (I) && T[3]/*P*/) && B[7];
    wire nclr_IEN = ~((out_R && T[2]) || (D[7] && (I) && T[3]/*P*/) && B[6]);
    dff IEN (.D(in_IEN), .CLK(clk_IEN), .NCLR(nclr_IEN), .Q(out_IEN), .LD(ld_IEN));
        
    ////////////////////////-[INTERRUPT FLAG]-////////////////////////
    wire in_R = 1;
    wire clk_R = clk_master;
    wire ld_R = (~(T[0] || T[1] || T[2]) && out_IEN && (out_FGI || out_FGO));
    wire nclr_R = ~(out_R && T[2]);
    dff R (.D(in_R), .CLK(clk_R), .NCLR(nclr_R), .Q(out_R), .LD(ld_R));

    ////////////////////////-[SELECTION LINE]-////////////////////////
    wire [7:0] en;
    assign en [0] = 0;                                                      // Adder & Logic
    assign en [1] = (D[4] && T[4]) || (D[5] && T[5]);                       // AR
    assign en [2] = T[0] || (D[5] && T[4]);                                 // PC
    assign en [3] = (D[2] && T[5]) || (D[6] && T[6]);                       // DR
    assign en [4] = (D[3] && T[4]) || (D[7] && (I) && T[3]/*p*/) && B[10];  // AC
    assign en [5] = ((~out_R) && T[2]);                                     // IR
    assign en [6] = out_R && T[1];                                          // TR
    assign en [7] = r_M;                                                    // Mem
    selection_line SelelctionLine ( .AR({4'b0000, out_AR}), .PC({4'b0000, out_PC}), .DR(out_DR), .AC(out_AC), .IR(out_IR), .TR(out_TR), .MEM(out_data_M), .sel(en), .BUS(common_bus));
     
    ////////////////////////-[ADDER & LOGIC UNIT]-////////////////////
    adder_and_logic_circuit AdderAndLogic (.DR(out_DR), .out_AC(in_AC), .INPR(out_INPR), .D(D), .in_E(out_E), .out_R(out_R), .FGO(out_FGO), .FGI(out_FGI), .out_E(in_E), .S(S), .IR(out_IR), .T(T), .INR(INR), .in_AC(out_AC));
     
    ////////////////////////-[SEQUENCE COUNTER]-////////////////////////
    wire clk_SC = S & clk_master;
    wire rstn_SC = ~((out_R && T[2]) || (T[5] && (D[0] || D[1] || D[2] || D[5])) || (T[4] && (D[3] || D[4])) || (D[6] && T[6]) || (D[7] && T[3]));
    sequence_counter SequenceCounter (.clk(clk_SC), .rstn(rstn_SC), .count(T));

endmodule