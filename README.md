# Mano-machine
The Mano machine is a computer theoretically described by M. Morris Mano. It contains a central processing unit, random access memory, and an input-output bus.

#**Instructions Set** 
| Instruction        |  Hexadecimal Code | Description  |
| :-------------: |:-------------:| :-----:|
|**Memorey Referrence Instructions**|
|AND|0XXX 8XXX|And memory word to AC|
|ADD|1XXX 9XXX|Add memory word to AC|
|LDA|2XXX AXXX|Load AC from memory|
|STA|3XXX BXXX|Store content of AC into memory|
|BUN|3XXX CXXX|Branch unconditionally|
|BSA|6XXX DXXX|Branch and save return address|
|ISZ|7XXX EXXX|Increment and skip if zero|
|**Register Referrence Instructions**|
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
|**Input/Output Referrence Instructions**|
|INP|F800|Input character to AC|
|OUT|F400|Output character from AC|
|SKI|F200|Skip next instruction on Input Flag|
|SKO|F100|next instruction on Output Flag|
|ION|F080|Interrupt on|
|IOF|F040|Interrupt off|
[cols="^,^,^"] \n|=== \n|Layer1 |Layer2 |Layer3 \n \n.4+.^|L1 Name .2+.^|L2 Name A |L3 Name A \n|L3 Name B \n.2+.^|L2 Name B |L3 Name C \n|L3 Name D \n \n|===. Replace all \n
