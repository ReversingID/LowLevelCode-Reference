# Low-Level Code Reference

Retargetable Machine-Code Decompiler based on LLVM

* Github: https://github.com/avast/retdec
* Site: https://retdec.com/

Category:

- binary lifting
- decompiler
- static analysis

## Introduction

RetDec adalah decompiler yang tidak terbatas terhadap arsitektur, operating system, dan executable format tertentu.

#### Targets

- File formats: ELF, PE, MachO, COFF, AR (archive), Intel HEX, raw machine code
- Architecture: 
    - 32 bit: x86, ARM, MIPS, PIC32, PowerPC
    - 64 bit: x86-64, AArch64

#### Features

- static analysis
- compiler and packer detection
- OS loader simulation
- loading and instruction decoding
- signature based removal of statically linked library code
- extraction and utilizing debugging information (DWARF, PDB)
- reconstruction of instruction idioms
- detection and reconstruction of C++ class hierarchies (RTTI, vtables)
- symbol demangling (GCC, MSVC, Borland)
- reconstruction of functions, types, and high-level constructs
- integrated disassembler
- generate call graph, control-flow graph, and various statistic.

#### Notes

- RetDec menggunakan Python sebagai script pemanggilan.
- unpacking terbatas kepada beberapa packer populer (UPX, MPRESS)

## Reference

Talks:

- Botconf 2017: [slide](https://retdec.com/static/publications/retdec-slides-botconf-2017.pdf), [video](https://www.youtube.com/watch?v=HHFvtt5b6yY)
- REcon Montreal 2018: [slide](https://retdec.com/static/publications/retdec-slides-recon-2018.pdf)

Publications:

- [RetDec](https://retdec.com/publications/)