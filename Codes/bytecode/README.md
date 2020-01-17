# Low-Level Code Reference

Introduction to Bytecode.

## Bytecode

`Bytecode,` atau disebut juga `P-Code` (Portable Code), adalah instruction set yang didesain untuk secara efisien dijalankan oleh sebuah interpreter atau `abstract machine`. Bytecode merepresentasikan instruksi dan operasi yang valid, namun tidak terikat pada platform fisik. Pada konteks tertentu, Bytecode dapat disebut sebagai `Assembly` bagi sebuah platform virtual.

Bytecode termasuk ke dalam `Intermediate-Language` yang umumnya dihasilkan oleh sebuah compiler untuk dijalankan di atas sebuah interpreter.

Karena terikat dengan interpreter, gaya bahasa sebuah Bytecode akan menyesuaikan dengan tipe dari interpreter tersebut. Sebuah interpreter merupakan mesin virtual yang berbasis `Register` maupun `Stack`.

## Advantages

Pemahaman Bytecode dari sebuah platform memberikan keuntungan bagi Reverse Engineer dan Developer. Penguasaan Bytecode dapat memberikan pemahaman terhadap:

- bagaimana instruksi mengakses dan memproses data
- bagaimana sebuah interpreter bekerja secara internal.

Pemahaman terhadap instruksi Bytecode dapat membantu dalam analisis kode yang kompleks dan menjebak (misal: obfuscation).