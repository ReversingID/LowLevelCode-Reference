# Low-Level Code Reference

Introduction to Valgrind VEX Intermediate Representation (IR)

## Valgrind IR Introduction

Valgrind VEX IR adalah Intermediate Representation yang digunakan oleh Valgrind framework. VEX adalah Binary Translation layer yang digunakan Valgrind untuk menerjemahkan potongan kode dari target ke host.

Valgrind adalah framework untuk Dynamic Analysis (Memory Debugging, Memory Leak Detection, Checker, Profiling, dsb). Secara arsitektur, Valgrind adalah Virtual Machine dengan teknik kompilasi JIT (Just-In-Time). Tidak ada bagian binary yang akan berjalan di host processor secara langsung. Valgrind menerjemahkan kode program menjadi IR yang independen, SSA-based. 

