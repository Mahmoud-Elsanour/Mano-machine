`timescale 1ns / 1ps

/*
* adder_and_logic_circuit - the module that excutes the instruction
*                           and controls the increment process
*
* Inputs: 
*         - DR -> Data Register content
*         - in_AC -> Accumulator content (data from the accumulator)
*         - in_E -> Extended Flag content
*         - out_R -> Interrupt Flag input
*         - FGI -> current value in the Input Flag
*         - FGO -> current value in the Output Flag
*         - D -> decoder output of IR[14:12]
*         - out_IR -> current value in the Instruction Register
*         - T -> decoder output of SC[15:0]
*         
* Outputs:
*         - INR -> array of increment signals where
            ( [0]:AR, [1]:PC, [2]:DR, [3]:AC)
*         - out_E -> input of the Extended Flag
*         - S -> Stop Flag
*         - out_AC -> input of the Accumulator
*/

module adder_and_logic_circuit( input [15:0] DR, in_AC,
                                input [7:0] INPR,
                                input in_E,
                                input out_R,
                                input FGI,
                                input FGO,
                                input [7:0] D,
                                input [15:0] IR,
                                input [15:0] T,
                                output [3:0] INR,
                                output reg out_E,
                                output reg S,
                                output reg [15:0] out_AC);
    reg INR_CONDITIONS;

    assign INR[0] = (D[5] && T[4]); //AR
    assign INR[1] = (((~out_R) && T[1]) || (out_R && T[2]) || (D[7] && (~IR[15]) && T[3]/*r*/) && IR[4] && INR_CONDITIONS) || ((D[7] && (~IR[15]) && T[3]/*r*/) && IR[3] && INR_CONDITIONS) || ((D[7] && (~IR[15]) && T[3]/*r*/) && IR[2] && INR_CONDITIONS) || ((D[7] && (~IR[15]) && T[3]/*r*/ ) && IR[1] && INR_CONDITIONS) || (D[6] && T[6] && INR_CONDITIONS) || ((D[7] && (IR[15]) && T[3]/*p*/ ) && IR[9] && INR_CONDITIONS || ((D[7] && (IR[15]) && T[3]/*p*/ ) && IR[8] && INR_CONDITIONS)); //PC
    assign INR[2] = (D[6] && T[5]); //DR
    assign INR[3] = ((D[7] && (~IR[15]) && T[3]/*r*/) && IR[5]); //AC
    

    initial begin
        S = 1;
    end

    always @*
    if (~D[7])                                             /// Mem ref
      case (D)
           01 : out_AC = in_AC & DR;                                       //AND
           02 : {out_E,out_AC} = DR + in_AC;                               //ADD
           04 : out_AC = DR;                                               //LDA
           64 : INR_CONDITIONS = DR ? 0 : 1;
        endcase
    else
        if(~(IR[15]))                                      /// reg ref
            case (IR)
                16'h7200 :  out_AC = ~in_AC;                               //CMA
                16'h7100 :  out_E = ~in_E;                                 //CME
                16'h7080 :  begin  out_AC <= (in_AC >> 1);                 //CIR
                                   out_AC[15] <= in_E;
				                   out_E <= in_AC[0];  end 
				16'h7040 :  begin  out_AC <= (in_AC << 1);                 //CIL
					               out_AC[0] <= in_E;
					               out_E <= in_AC[15]; end
			    16'h7010 :  INR_CONDITIONS = in_AC[15] ? 0 : 1;            //SPA
			    16'h7008 :  INR_CONDITIONS = in_AC[15] ? 1 : 0;            //SNA
			    16'h7004 :  INR_CONDITIONS = in_AC ? 0 : 1;                //SZA
			    16'h7002 :  INR_CONDITIONS = in_E ? 0 : 1;                 //SZE
			    16'h7001 :  S = 0;                                         //HLT
            endcase
        else if(IR[15])                                   /// I/O ref
            case (IR)
                16'hf800 :  out_AC = INPR;
                16'hf200 :  INR_CONDITIONS = FGI ? 1:0;                    //SKI
                16'hf100 :  INR_CONDITIONS = FGO ? 1:0;                    //SKO
            endcase
        
endmodule