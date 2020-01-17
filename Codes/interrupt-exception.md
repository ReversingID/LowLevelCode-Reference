# Low-Level Code Reference

Introduction to Interrupt & Exception

## Interrupt

Interrupt adalah signal dari perangkat eksternal (umumnya I/O) kepada processor sebagai pertanda bahwa terdapat suatu kejadian yang harus ditangani oleh processor.

Kemunculan Interrupt tidak mengubah flow eksekusi suatu program. 

Ketika processor mendapat Interrupt, processor akan menghentikan sementara semua eksekusi yang sedang terjadi kemudian mencari handler yang sesuai di Interrupt Table untuk menangani Interrupt tersebut. Selanjutnya, eksekusi normal akan dilanjutkan.

## Exception

Exception adalah signal yang dibangkitkan ketika suatu kesalahan atau kondisi anomali terjadi saat eksekusi instruksi. Beberapa kesalahan atau anomali yang umum antara lain pembagian dengan nol, akses memori secara ilegal, dsb 

Kemunculan Exception memiliki kemungkinan untuk mengubah flow eksekusi suatu program.

Exception terdiri atas tiga jenis: Fault, Trap, dan Abort.
