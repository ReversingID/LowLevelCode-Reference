# Low-Level Code Reference

Nasm Codes Repository

## Nasm Introduction

Nasm (Netwide Assembler) merupakan assembler lintas platform, dapat berjalan di berbagai operating system dan dapat menghasilkan binary untuk x86 dan x86-64.

Kami berusaha untuk membuat kode yang bersifat OS-agnostic. Meski demikian kami menyadari bahwa dalam beberapa hal kami merasa perlu untuk mendemonstrasikan kode yang spesifik terhadap platform.

## Nasm Installation

Kunjungi [nasm site](http://nasm.us) dan ikuti petunjuk instalasi yang ada.

## Linker

Nasm hanyalah sebuah assembler. Ia mengubah source code dalam bahasa assembly menjadi sebuah object code. Karena itu, diperlukan tool lain yang disebut `linker` untuk menggabungkan berbagai object code dan menghasilkan sebuah executable.

