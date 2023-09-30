`timescale 1ns / 1ps

module mano_basic_computer_tb ();

    reg MASTER_CLOCK = 0;
    reg printer_clock = 0;
    reg keyboard_clock = 0;
    reg [7:0] keyboard = 0;
    reg [7:0] printer = 0;
    wire [11:0] AR, PC;
    wire [15:0] DR, AC, IR, TR, T;
    wire [7:0] D, OUTR, INPR;
    wire E, R, FGI, FGO, IEN;
 
    integer t = 0;
 
    mano_basic_computer ManoBasicComputer( .clk_master(MASTER_CLOCK), .out_IEN(IEN), .OUT_CLK(printer_clock), .IN_CLK(keyboard_clock), .IN_DATA(keyboard), .T(T), .D(D), .out_AR(AR), .out_PC(PC), .out_DR(DR), .out_AC(AC), .out_IR(IR), .out_TR(TR), .out_INPR(INPR), .out_OUTR(OUTR), .out_R(R), .out_FGI(FGI), .out_FGO(FGO), .out_E(E));
  
        always #5 MASTER_CLOCK = ~MASTER_CLOCK;
        always #15 printer_clock = ~printer_clock;
        always #15 keyboard_clock = ~keyboard_clock;

        always @ (posedge MASTER_CLOCK) begin
            if(T == 1)
                t = 0;
            #1
            $display ("+-------------+");
            if (!(t == 3 && D[7] == 1)) begin
                if (t >= 4 && D[7] == 0)
                    $write ("|    T%1d", t);
                else
                    $write ("|     T%1d      |", t);
                end
            if (t == 3 && D[7] == 1 && IR[15] == 0)
                $display ("|    rB%2d     |", $clog2(IR[11:0]));
            else if (t == 3 && D[7] == 1 && IR[15] == 1)
                $display ("|    pB%2d     |", $clog2(IR[11:0]));
            else if (t >= 4 && D[7] == 0)
                $display (" D%1d    |", $clog2(D));
            else 
                $display();
            $display ("+-------------+");
            $display ("|  AR  |  %h |", AR);
            $display ("|  PC  |  %h |", PC);
            $display ("|  DR  | %h |", DR);
            $display ("|  AC  | %h |", AC);
            $display ("|  IR  | %h |", IR);
            $display ("|  TR  | %h |", TR);
            $display ("| OUTR |   %h |", OUTR);
            $display ("| INPR |   %h |", INPR);
            $display ("|  E   |    %h |", E);
            $display ("|  R   |    %h |", R);
            $display ("|  FGI |    %h |", FGI);
            $display ("|  FGO |    %h |", FGO);
            $display ("|  pri |   %h |", printer);
            $display ("|  key |   %h |", keyboard);
            $display ("+-------------+");
            if (!(IR == 16'h7001 && t > 2))
                t = t + 1;
        end
        
        always @ (posedge printer_clock) begin
            if (FGO == 0)
                printer = OUTR;
        end
        always @ (posedge keyboard_clock) begin
            if (FGI == 0)
                keyboard = $urandom%100;
        end
        
endmodule