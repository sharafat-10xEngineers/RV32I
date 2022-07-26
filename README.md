# RV32I

## RiscV Single Cycle Processor

[![N|RiscV](https://riscv.org/wp-content/uploads/2015/10/cropped-LI_profile.png)](https://riscv.org/wp-content/uploads/2015/10/cropped-LI_profile.png)

## Features
Currently this processor support following instruction.


- lb, lh, lw, lbu, lhu
- addi, slli, slti, xori, srli, srai, ori, andi, jalr
- sb, sh, sw
- add, sub, sll, slt, sltu, xor, srl, sra, or, and
- beq, bne, blt, bge, bltu, bgeu
- jal, lui
- aupic

## Simulation

simulate using icarus verilog. After Cloning repository run following command to simmulate.
```sh
cd tb
iverilog -o sim -c ../files.txt
vvp sim
```
To see the waveform use gtkwave after generate test.vcd file from previous commands.
```sh
gtkwave test.vcd
```

**Free Core Hell Yeah!**
