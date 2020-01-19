# Low-Level Code Reference

Dynamic Binary Instrumentation based on LLVM

* Github: https://github.com/QBDI/QBDI
* Site: https://qbdi.quarkslab.com

Category:

- dynamic binary instrumentation
- executable
- scripting

## Introduction

QBDI (QuarkslaB Dynamic binary Instrumentation) adalah framework Dynamic Binary Instrumentation yang bersifat modular, Cross-Platform dan Cross-Architecture.

#### Targets

- Architecture:
    - 32 bit: x86, ARM
    - 64-bit: x86-64, AArch64
- Operating System: Linux, MacOS, iOS, Windows

#### Notes

- kode instrumentasi menggunakan API C/C++
- kode instrumentasi akan dikompilasi menjadi Dynamic Library, yang akan dimuat oleh process dengan beragam tools injection.
- menggunakan Python sebagai loader
- dapat diintegrasikan dengan [Frida](https://github.com/frida/frida)

## Reference

- [User Documentation](https://qbdi.readthedocs.io/en/stable/user.html)