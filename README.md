# Pipelined-microprocessor
This repository contains the design of a pipelined microprocessor with shared memories
Design Throughts:
Operations:
In terms of data:
   Load to register file from memory
   Store to memory from register file
   Computation source 1 from register file, source 2 from register file
   Computation source 1 from register file, source 2 from immediate
   Computation source 1 from immediate, source 2 from register file
   Computation source 1 from immediate, source 2 from immediate
In terms of numerical operations:
   Plus, signed, 16 bits long
   Minus, signed, 16 bits long
   Multiplication, signed, 16 bits long
   Division, signed, 16 bits long
   Comparison, signed, 16 bits long
In terms of programme counter:
   Branch if equal
   Branch if larger
   Branch if smaller
   Branch unconditionally


Instruction set design:
There will be a digit specifying load or store: 01= load, 10= store, 00= reset the register file, 11= reset the memory
There will be a digit specifying source 1 of computation: 1= register file, 0= immediate
There will be a digit specifying source 2 of computation: 1= register file, 0= immediate
There will be a digit specifying major computation type: 00= plus or minus, 01= multiplication or division, 10= comparison source 1 than 2, 11= comparison source 2 than 1
There will be a digit specifying branch if condition: 00= beq, 01= bel, 10= bes, 11= beu


Improvements:
The 2 digits specifying the sources would be better to be adjacent to digits specifying the operations.
The 2 digits specifying the branch if conditions would be better to be adjacent to digits specifying the operations.


Design:
There will be 2 digits for load or store, 2 for sources, 2 for computation type, and 2 for branching conditions.
Position	rules
0,1	01load, 10store, 00resetRF, 11resetMEM
2	Src1, 1=RF, 0=Imme
3	Src2, 1=RF, 0=Imme
4,5	00= plus 01- minus, 11- multiplication, 10= comparison source 1 than 2, 01=not load or store or reset rams 
6,7	00= beq, 01= bel, 10= bes, 11= not jump


It needs 3 types of instructions, one is load or storage 01, one is computation 10, one is jump 11
In load or storage type,
[][][][][][][][]operations(8)
[][][][][][][][]to(8)
[][][][][][][][]from(8)
[][][][][][][][]zeros(8)
[][][][][][][][][][][][][][][][]zeros(32)
In computation type,
[][][][][][][][]operations
[][][][][][][][]target address in register file
[][][][][][][][]source 1 address in register file
[][][][][][][][]source 2 address in register file
[][][][][][][][][][][][][][][][]immediate if any
In jump type,
[][][][][][][][]operations,
[][][][][][][][]zeros,
[][][][][][][][]source1,
[][][][][][][][]source2,
[][][][][][]][][][][][][][][][]jump to

