# Mano-machine
The Mano machine is a computer theoretically described by M. Morris Mano. It contains a central processing unit, random access memory, and an input-output bus.

{| class="wikitable"
|-
! Bit 15
! Bits 14-12
! Bits 11-0
! Mnemonic
! Description

|-
| 0
| 0
| (Direct address)
| AND
| And direct memory to accumulator

|-
| 0
| 1
| (Direct address)
| ADD
| Add direct memory to accumulator (affects carry bit)

|-
| 0
| 2
| (Direct address)
| LDA
| Load direct memory to accumulator

|-
| 0
| 3
| (Direct address)
| STA
| Store accumulator to direct memory

|-
| 0
| 4
| (Direct address)
| BUN
| Unconditionally branch to direct memory

|-
| 0
| 5
| (Direct address)
| BSA
| Store current program counter to direct memory and branch to following address

|-
| 0
| 6
| (Direct address)
| ISZ
| Increment value in direct memory and skip next instruction if the sum is zero

|-
| 1
| 0-6
| (Indirect address)
| 
| Indirect addressing versions of the above instructions

|-
| 0
| 7
| 800
| CLA
| Clear the accumulator

|-
| 0
| 7
| 400
| CLE
| Clear the carry bit

|-
| 0
| 7
| 200
| CMA
| Complement the accumulator

|-
| 0
| 7
| 100
| CME
| Complement the carry bit

|-
| 0
| 7
| 080
| CIR
| Circulate accumulator right (through carry bit)

|-
| 0
| 7
| 040
| CIL
| Circulate accumulator left (through carry bit)

|-
| 0
| 7
| 020
| INC
| Increment accumulator (does not affect carry bit)

|-
| 0
| 7
| 010
| SPA
| Skip next instruction if accumulator is positive

|-
| 0
| 7
| 008
| SNA
| Skip next instruction if accumulator is negative

|-
| 0
| 7
| 004
| SZA
| Skip next instruction if accumulator is zero

|-
| 0
| 7
| 002
| SZE
| Skip next instruction if carry bit is zero

|-
| 0
| 7
| 001
| HLT
| Halt computer by clearing the halt bit latch

|-
| 1
| 7
| 800
| INP
| Input from character bus to accumulator

|-
| 1
| 7
| 400
| OUT
| Output from accumulator to character bus

|-
| 1
| 7
| 200
| SKI
| Skip next instruction if input flag is set

|-
| 1
| 7
| 100
| SKO
| Skip next instruction if output flag is set

|-
| 1
| 7
| 080
| ION
| Enable interrupts

|-
| 1
| 7
| 040
| IOF
| Disable interrupts

|}
