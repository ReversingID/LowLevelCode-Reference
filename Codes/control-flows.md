# Low-Level Code Reference

General Overview of Program Control Flow

## What is Control Flow?

`Control flow` atau flow of control adalah pengaturan urutan eksekusi atau evaluasi dari instruksi (statement).

## Categories

Secara umum, control-flow dapat dikategorikan berdasarkan efek:

- Meneruskan eksekusi instruksi ke lokasi berbeda (unconditional jump)
- Eksekusi sekelompok instruksi ketika sebuah kondisi terpenuhi (choice atau branch)
- Eksekusi sekelompok instruksi sebanyak nol kali atau lebih dalam kondisi tertentu (loop, modifikasi dari conditional jump).
- Eksekusi sekelompok instruksi sebagai satu kesatuan aksi (subroutine, function).
- Menghentikan program, mencegah adanya eksekusi selanjutnya. 

## Primitives

Untuk dapat mengubah alur eksekusi instruksi, terdapat setidaknya dua komponen dalam bahasa assembly (serta banyak low-level code lain), yaitu:

- *Jumps*: statement untuk berpindah posisi, baik berupa unconditional maupun conditional. 
- *Labels*: nama atau angka yang secara eksplisit diberikan kepada posisi tertentu dalam kode sehingga dapat digunakan sebagai acuan untuk berpindah sehingga eksekusi selanjutnya akan dimulai dari posisi tersebut.

## Branch

Percabangan (branch) adalah tindakan perubahan lokasi atau urutan ke barisan instruksi di lokasi lain sebagai hasil dari evaluasi kondisi. 

Jika dilihat dari sisi bahasa tingkat tinggi, terdapat beberapa model percabangan antara lain:

- If-Then-(Else)
- Switch-Case 

### If-Then-(Else) Statements

Percabangan yang mengarahkan ke sekelompok instruksi jika kondisi terpenuhi. Percabangan dapat pula terdiri dari beberapa alternatif aksi, masing-masing dengan kondisi yang saling komplemen.

### Switch-Case Statements

Percabangan dengan beragam kondisi alternatif berdasarkan nilai. Sebuah Jump Table digunakan untuk menentukan blok target yang akan dieksekusi ketika melompat.

## Loops

Perulangan (loop) adalah variasi dari percabangan. Loop adalah serangkaian instruksi yang ditulis sekali namun dapat dieksekusi berkali-kali secara berturut-turut.

Jika dilihat dari sisi bahasa tingkat tinggi, terdapat beberapa model perulangan antara lain:

- For (Count-Controlled Loop)
- While (Condition-Controlled Loop)

### Count-Controlled Loops

Perulangan yang dikendalikan menggunakan sebuah counter untuk mengeksekusi blok sebanyak sekian kali. Nilai counter berubah seiring waktu dengan setiap langkah perulangan membuat counter mendekati sebuah nilai ambang batas.

### Condition-Controlled Loops

Perulangan yang dikendalikan oleh evaluasi kondisi. Perulangan terjadi apabila suatu kondisi terpenuhi. Evaluasi kondisi dapat dilakukan di awal atau di akhir blok perulangan.