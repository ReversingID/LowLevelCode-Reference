# Low-Level Code Repository

Introduction to Radare2 Evaluable Strings Intermediate Language (ESIL).

## Radare2 ESIL Introduction

`ESIL (Evaluable Strings Intermediate Language)` adalah Intermediate Language yang digunakan oleh Radare2 untuk mendeskripsikan aksi yang dilakukan oleh setiap instruksi dari setiap CPU.

Radare2 adalah framework dengan fokus terhadap Reverse Engineering dan analisis binary. Radare2 dapat melakukan Static Analysis dan Dynamic Analysis (debugging) terhadap beragam format binary.

ESIL digunakan secara luas di Radare2 sebagai:

- Code Emulation: emulate block code 
- Branch Prediction
- Assisted Debugging: mengimplementasikan Software Watchpoints.
- VM Emulation
- Code Analysis
- Decompilation: menciptakan AST dari ESIL
- dsb