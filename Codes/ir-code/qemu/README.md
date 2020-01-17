# Low-Level Code Reference

Introduction to Qemu Tiny Code Generator (TCG) Intermediate Representation (IR)

## Qemu TCG IR Introduction

TCG IR adalah Intermediate Representation yang digunakan oleh Qemu. `TCG (Tiny Code Generator)` adalah sebuah Code Generator, module yang digunakan oleh Qemu untuk menerjemahkan potongan kode (Basic Block) dari target ke host.

Qemu (Quick EMUlator) adalah hardware virtualization yang digunakan sebagai emulator untuk beragam processor, menjalankan dan monitor program yang berjalan untuk platform tertentu.

Sebagai emulator, Qemu melakukan penerjemahan berdasarkan potongan-potongan kode yang disebut sebagai Translation Block.