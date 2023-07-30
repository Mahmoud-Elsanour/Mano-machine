# Mano-machine
The Mano machine is a computer theoretically described by M. Morris Mano. It contains a central processing unit, random access memory, and an input-output bus.

#**Instructions Set** 
| Instruction        |  Hex Code  I=0 I=1  | Description  |
| :-------------: |:-------------:| :-----:|
|AND|0XXX 8XXX|And memory word to AC|
|ADD|1XXX 9XXX|Add memory word to AC|
|LDA|2XXX AXXX|Load AC from memory|
|STA|3XXX BXXX|Store content of AC into memory|
|BUN|3XXX CXXX|Branch unconditionally|
|BSA|6XXX XXX||
