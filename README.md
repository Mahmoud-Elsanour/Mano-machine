# **Mano Basic Computer**
The Mano machine is a computer theoretically described by M. Morris Mano. It contains a central processing unit, random access memory, and an input-output bus.

We are a team of 5 students who worked on this project as part of our Microcontrollers Arcitechure Course:
- [Abdallah Adel](https://github.com/AbdallahAdelPro)
- [Hamdin Gamal](https://github.com/Hamdingamal)
- [Mahmoud El-Sanour](https://github.com/Mahmoud-Elsanour)
- [Ziad Mohamed](https://github.com/ziad232)
- [Ziad Sameh](https://github.com/ziad036)
  
We have implemented the Mano machine in Verilog and in Proteus 
***
## Mano-machine in Verilog
### **Verilog**
Verilog is a hardware description language (HDL) used to design and simulate digital systems. Verilog is similar to other HDLs, such as VHDL, but has a simpler syntax.

### **Verilog Implementation of the Mano Machine**
The Mano machine can be broken down into several modules, such as the ALU, memory, registers, flip-flops and I/O devices. Each module can be implemented in Verilog as a separate entity. The modules can then be interconnected to form the complete system.

### **Modules**
- The Verilog modules used are:
- Adder_And_Logic_Circuit.v
- D_Flip-Flop.v
- Decoder.v
- Mano_Basic_Computer.v
- Memory.v
- Register_12.v
- Register_16.v
- Selection_Line.v
- Sequence_Counter.v

### **Instructions Set** 
This implementation can excute all the instructions that was descriped by M. Morris Mano
| Instruction        |  Hexadecimal Code | Description  |
| :-------------: |:-------------:| :-----:|
|~~~~~~~~~~~~~~~~~~~~~~~~~~~|**Memorey Referrence Instructions**|~~~~~~~~~~~~~~~~~~~~~~~~~~~|
|AND|0XXX    8XXX|And memory word to AC|
|ADD|1XXX    9XXX|Add memory word to AC|
|LDA|2XXX    AXXX|Load AC from memory|
|STA|3XXX    BXXX|Store content of AC into memory|
|BUN|3XXX    CXXX|Branch unconditionally|
|BSA|6XXX    DXXX|Branch and save return address|
|ISZ|7XXX    EXXX|Increment and skip if zero|
|~~~~~~~~~~~~~~~~~~~~~~~~~~~|**Register Referrence Instructions**|~~~~~~~~~~~~~~~~~~~~~~~~~~~|
|CLA|7800|Clear AC|
|CLE|7400|Clear E|
|CMA|7200|Complement AC|
|CME|7100|Complement E|
|CIR|7080|Circulate right AC and E|
|CIL|7040|Circulate left AC and E|
|INC|7020|Increment AC|
|SPA|7010|Skip next instruction if AC is positive|
|SNA|7008|Skip next instruction if AC is negative|
|SZA|7004|Skip next instruction if AC is zero|
|SZE|7002|Skip next instruction if E is zero|
|HLT|7001|Halt the computer|
|~~~~~~~~~~~~~~~~~~~~~~~~~~~|**Input/Output Referrence Instructions**|~~~~~~~~~~~~~~~~~~~~~~~~~~~|
|INP|F800|Input character to AC|
|OUT|F400|Output character from AC|
|SKI|F200|Skip next instruction on Input Flag|
|SKO|F100|next instruction on Output Flag|
|ION|F080|Interrupt on|
|IOF|F040|Interrupt off|

### **Memory Program**
The program written in the memory can be found in [instructuin.v]() file
***
## Mano-machine in Proteus
### **Proteus**
[The Proteus Design Suite is a proprietary software tool suite used primarily for electronic design automation](https://en.wikipedia.org/wiki/Proteus_Design_Suite)
### **Proteus Implementation of the Mano Machine**
The Mano machine can be broken down into samller Units such as ALU, InOut registers, ir and sc, mem registers, and signal,. Each Unit is is a bunch of ICs that make part of the full the machine job. These units can then be interconnected to form the complete system.
***
### **Instructions Set** 
This implementation can excute most of the instructions that was descriped by M. Morris Mano as we used 4-bit register as the Address Register.
| Instruction        |  Hexadecimal Code | Description  |
| :-------------: |:-------------:| :-----:|
|~~~~~~~~~~~~~~~~~~~~~~~~~~~|**Memorey Referrence Instructions**|~~~~~~~~~~~~~~~~~~~~~~~~~~~|
|AND|0X    8X|And memory word to AC|
|ADD|1X    9X|Add memory word to AC|
|LDA|2X    AX|Load AC from memory|
|SUB|3X    BX|Subtracte memory word from AC|
|BUN|3X    CX|Branch unconditionally|
|XOR|6X    DX|Exclusively-OR memory word to AC|
|STA|7X    EX|Store content of AC into memory|
|~~~~~~~~~~~~~~~~~~~~~~~~~~~|**Register Referrence Instructions**|~~~~~~~~~~~~~~~~~~~~~~~~~~~|
|HLT|00|Halt the computer|
|CMA|01|Complement AC|
|SZA|02|Skip next instruction if AC is zero|
|CLA|03|Clear AC|
|CIR|04|Circulate right AC and E|
|CIL|05|Circulate left AC and E|
|CLE|06|Clear E|
|CME|07|Complement E|
|INP|08|Input character to AC|
|OUT|09|Output character from AC|
***
### **Memory Program**
To prpgram the memory do the following steops:
1. 'STOP' the machine
2. Turn on 'Programming'
3. Turn on 'Write'
4. Select 'Old' or 'New'
- Old:
5. Click on 'Next' and the program will be written automatically
- New:
5. Write the aaddress and the code
6. Turn 'write' to 'read'
7. Turn 'off' programing
8. Turn 'STOP' to 0
  
Note: the built-in program can be removed or changed as it's not part of the machine and it was made to ease the programming process
***
### **Useful Resources**
[Verilog Tutorial](https://www.chipverify.com/verilog/verilog-tutorial)

[Mano Machine](https://en.wikipedia.org/wiki/Mano_machine)
