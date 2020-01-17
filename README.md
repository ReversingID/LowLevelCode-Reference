# Low-Level Code Reference

Open repository for learning low-level code.

### Selayang Pandang

Repositori ini menghimpun informasi pembelajaran low-level code (assembly, bytecode, immediate representation, dsb) untuk berbagai arsitektur, platform, dan dialek. Cakupan repositori ini tidak hanya terbatas kepada prosesor (hardware), namun juga meluas hingga mencakup berbagai process virtual machine seperti JVM (Java Bytecode), CLR (.Net CIL), LLVM IR, dsb.

Semua code yang disertakan dalam reposiotry ini memberikan instruksi untuk melakukan kompilasi.

### Tentang Low-Level Code

`Low-level code` (kode tingkat rendah) adalah abstraksi sekelompok instruksi dari sebuah processor untuk memberikan perintah dan memproses data sesuai dengan kemampuan yang diberikan oleh masing-masing processor. Kata "low" (rendah) merujuk kepada tingkat abstraksi yang minimalistik antara bahasa dan instruksi asli dari processor.

Istilah `processor` di repositori ini merujuk ke sebuah istilah umum untuk menyebut perangkat keras (microprocessor, microcontroller) maupun perangkat lunak (interpreter, process virtual machine, p-code machine) yang mengeksekusi kode tertentu untuk memproses data. 

Instruksi yang dibahas adalah instruksi level rendah yang dipahami masing-masing processor dengan cakupan instruksi untuk melakukan pemindahan data, operasi aritmetik, pengecekan kondisi, dsb. 

Low-Level Code (Assembly, IR, IL dsb) adalah bahasa kunci dalam Reverse Engineering.

### Disclaimer

Repositori ini merupakan inisiatif dari komunitas Reversing.ID untuk memperkenalkan dan mendalami low-level code.

Reversing.ID tidak berafiliasi dengna vendor atau manufaktur device manapun. Repository ini memiliki tujuan utama sebagai bahan belajar low-level code dan assembly.

### Struktur dan Konten

Repositori ini terbagi menjadi beberapa bagian dengan direktori berbeda.

- Codes
- References
- Tools

_Codes_ adalah koleksi potongan kode spesifik terhadap masing-masing low-level code. Direktori ini memberikan pandangan secara bottom-up terhadap bahasa assembly dimana assembly dilihat sebagai building block. Pembagian kode direktori didasarkan kepada platform (processor, VM, dsb). Setiap platform akan memiliki satu atau lebih varian atau dialek yang bisa dikompilasi.

_References_ adalah himpunan referensi berupa artikel, tulisan, jurnal, dsb yang memberikan pemahaman terhadap sebuah low-level code. Direktori ini umumnya berisi referensi utama yang dikeluarkan oleh masing-masing vendor.

_Tools_ adalah bagian yang secara khusus merangkum daftar peralatan (tools) yang digunakan untuk analisis low-level code atau memanfaatkan low-level code untuk analisis lain. Meski tidak membahas detail penggunaan masing-masing tools, direktori ini menjelaskan secara garis besar kemampuan dan potensi dari setiap tools.

### How to Download?

Repository dapat diunduh secara keseluruhan atau kode dapat diunduh secara terpisah. 

### How to Contribute?

Ini adalah projek terbuka.

Kamu bisa memberikan sumbangsih berupa kode untuk arsitektur yang belum terdaftar, menambah atau memodifikasi kode yang sudah ada untuk memberikan informasi yang lebih baik.

Yang harus kamu lakukan:

- melakukan pull request.
- mengirimkan email ke pengurus [at] reversing.id
- memberi tahu di telegram @ReversingID
