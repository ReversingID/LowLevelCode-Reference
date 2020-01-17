# Low-Level Code Reference

Introduction to Intermediate Representation.

## Intermediate Representation 

`Intermediate Representation` (IR) adalah representasi yang digunakan secara internal oleh compiler, virtual machine, atau tools analisis untuk mengabstraksi instruksi. 

Untuk merepresentasikan sebuah instruksi spesifik dari platform, IR mendekomposisi instruksi spesifik menjadi satu atau lebih instruksi generik yang ekivalen. IR tidak terikat ke platform tertentu.

## IR dan Compiler

IR digunakan secara intensif oleh infrastruktur compiler modern. Compiler dapat dibagi menjadi tiga komponen:

- Front End
- Middle End
- Back end

`Front End` melakukan parsing terhadap source code, melakukan translasi dan menghasilkan IR yang sesuai. Sebagai bentuk antara (intermediate), IR akan mengalami pemrosesan (analisis, optimisasi, transformasi, dan instrumentasi) oleh `Middle End` untuk menghasilkan kode IR yang efektif dan efisien. Terakhir, `Back End` akan menerjemahkan IR menjadi kode instruksi mesin.

Selain compiler, IR digunakan oleh beberapa tools untuk merepresentasikan instruksi, seperti emulator.

## IR dan Emulator

IR digunakan secara intensif oleh emulator.

## IR dan Decompiler

IR digunakan secara intensif oleh decompiler untuk membalikkan proses yang terjadi dalam tahap kompilasi. Decompiler dapat dibagi menjadi tiga komponen:

- Front End
- Middle End
- Back End

## Advantages

Memahami Intermediate Representation (dari sebuah platform) memberikan keuntungan bagi Reverse Engineer dan Developer. Penguasaan IR memberikan pemahaman terhadap transformasi yang terjadi di tools dan memberikan keleluasaan untuk melakukan analisis suatu komponen program secara terprogram.