# Low-Level Code Reference

Intermediate-Language and Process Virtual Machine

## Process Virtual-Machine

Process `Virtual Machine` (VM), mesin abstrak, disebut juga dengan Managed Runtime Environment (MRE) adalah lingkungan maya yang mengabstraksi lapisan hardware atau operating system di bawah dan memberikan mekanisme yang seragam untuk menjalankan aplikasi.

Sebagai abstraksi, Process VM meniru cara kerja mesin sederhana. Selama berjalan, Process VM akan mengeksekusi instruksi yang merepresentasikan program dan berinteraksi dengan lingkungan di bawahnya. Instruksi yang disediakan adalah instruksi yang terdefinisi khusus untuk berjalan di atas lingkungan VM.

Ketika VM berjalan, instruksi VM akan diterjemahkan menjadi instruksi sesuai yang didukung oleh hardware dan operating system di lapisan bawah. Penerjemahan dapat terjadi secara keseluruhan (semua instruksi diterjemakan di awal) ataupun sebagian (instruksi hanya diterjemahkan ketika akan dieksekusi).

## Stack-Based vs Register-Based

Terdapat dua tipe Process VM, yaitu: Stack-Based dan Register-Based.

Kedua VM memiliki karakteristik masing-masing. Tipe VM akan mempengaruhi instruksi yang disediakan oleh VM.

Lihat juga contoh implementasi Process Virtual Machine di [repository](https://github.com/ReversingID/ProcessVM).

Meskipun secara fundamental VM berbasis Stack dan Register berbeda, namun terdapat beberapa persamaan yang mendefinisikan sebuah VM secara umum:

- Bytecode, setiap VM memiliki instruksi dalam tata bahasa tersendiri.
- Call Stack, menyimpan inforamsi pemanggilan fungsi.
- Instruction Pointer, menunjuk instruksi berikutnya yang akan dieksekusi
- Virtual CPU, eksekusi instruksi.

`Call Stack` adalah Stack yang digunakan untuk menyimpan informasi fungsi-fungsi yang dieksekusi secara berurutan sehingga VM dapat mengetahui hubungan fungsi yang memanggil dan fungsi yang dipanggil. Ketika eksekusi suatu fungsi berakhir maka VM dapat mengembalikan alur eksekusi ke fungsi yang memanggil.

#### Stack-Based VM

Process Virtual Machine yang berorientasi kepada Stack. Sebagian besar operasi, jika tidak keseluruhan, menggunakan Stack.

Stack, struktur data yang memiliki karakteristik Last In First Out (LIFO) untuk penyimpanan data. Stack (tumpukan) mendefinisikan kumpulan elemen dengan urutan tertentu. Puncak Stack adalah elemen pertama yang akan dikeluarkan dari Stack. Elemen baru akan diletakkan di atas puncak Stack lama dan berakhir sebagai Puncak (Top) yang baru.

Karakteristik penting dari Stack-Based VM adalah kehadiran `Evaluation Stack`.

`Evaluation Stack` adalah Stack yang digunakan sebagai penyimpanan sementara untuk operan instruksi, argumen fungsi, hingga hasil operasi. Instruksi dapat memengaruhi Stack secara langsung maupun tidak langsung. Umumnya setiap elemen diimplementasikan sebagai Slot yang dapat menampung informasi apapun (tipe data primitif, objek, dsb) terlepas dari ukuran masing-masing item.

#### Register-Based VM

Process Virtual Machine yang berorientasi kepada Register. Register-Based VM merupakan VM dengan pendekatan yang lebih alamiah terhadap sebuah mesin, dimana umumnya sebuah mesin (processor) memanfaatkan Register dana operasinya.

Register adalah sebuah ruang yang digunakan untuk menyimpan data. Register memiliki ukuran tetap.