# Low-Level Code Reference

Introduction to Assembly.

## Assembly 

`Assembly` adalah pemetaan kode-kode instruksi sebuah processor ke dalam representasi yang mudah dipahami oleh manusia.

Masing-masing processor menawarkan beragam teknologi yang dapat digunakan melalui instruksi-instruksi tertentu. Sekelompok instruksi (Instruction Set) dapat sangat spesifik dan berbeda dengan processor lain.

Assembly merupakan kumpulan kata-kata, disebut pula `Mnemonic`, yang merepresentasikan instruksi processor. Tidak ada aturan baku yang menyatakan penamaan sebuah Mnemonic sehingga jenis instruksi yang sama dapat direpresentasikan secara berbeda di Assembly untuk processor yang berbeda.

Singkatnya, assembly adalah low-level language yang didesain spesifik untuk keluarga processor tertentu yang merepresentasikan instruksi dengan kode simbolis.

## Advantages

Memahami bahasa assembly memberikan keuntungan, bukan hanya untuk Reverse Engineering tetapi juga Development. Penguasaan terhadap assembly memberikan pemahaman terhadap:

- bagaimana processor mengakses dan mengeksekusi instruksi
- bagaimana instruksi mengakses dan memproses data
- bagaimana data direpresentasikan di memori
- bagaimana program berinteraksi dengan OS, processor, dan perangkat lain.

Pemahaman terhadap instruksi Assembly dapat membantu dalam analisis kode yang kompleks dan menjebak (misal: obfuscation).

## Data Size

Processor beroperasi melakukan perhitungan terhadap data dengan ukuran tetap. Ukuran ini berbeda untuk setiap processor. Istilah seperti `64-bit processor` atau `32-bit processor` merujuk kepada ukuran data yang dapat dioperasikan oleh sebuah operasi.

Secara umum, terdapat beberapa istilah untuk menyebut potongan data.

- Byte: 8-bit
- Word: 2-byte, 16-bit
- Dword: double-word, 4-byte, 32-bit
- Qword: quadruple word, 8-byte, 64-bit

## Instruction Length

Tidak ada batasan terhadap panjang sebuah instruksi. Beberapa arsitektur memiliki instruksi dengan panjang tetap (sama untuk setiap instruksi lain). Sementara arsitektur lain menerapkan panjang instruksi yang bervariasi (variable-length instruction), dimana panjang sebuah instruksi bisa terdiri dari satu byte atau lebih.

## Execution Cycle

Eksekusi sebuah isntruksi yang tersimpan di memori membutuhkan beberapa tahapan (stages). Tahapan ini disebut sebagai `Execution Cycle`. Implementasi execution cycle dapat berbeda tergantung dari arsitektur tersebut. Umumnya terdapat 3 stages untuk mengeksekusi sebuah instruksi:

- *fetch*: mengambil instruksi dari memori dengan representasi untaian byte.
- *decode*: decode menerjemahkan code sebagai instruksi yang akan diterjemahkan oleh processor..
- *execute*: menjalankan instruksi dan memberikan hasil.

Para processor sederhana, eksekusi instruksi dilakukan secara sekuensial dengan satu Execution Cycle akan dilakukan setelah Execution Cycle sebelumnya telah selesai dilakukan. Pada kebanyakan processor modern, Execution Cycle dilakukan secara konkuren dan bahkan secara paralel, melalui `Instruction Pipeline`. Sebuah Execution Cycle dapat dimulai ketika Execution Cycle sebelumnya sedang diproses (tanpa menunggu selesai).