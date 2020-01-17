# Low-Level Code Reference

x86 Platform Specific Information

## Data Size

Istilah yang digunakan untuk merujuk ukuran data yang dapat dioperasikan oleh processor dalam setiap cycle.

Secara umum, terdapat beberapa istilah di x86 untuk menyebut potongan data.

- Byte: 8-bit
- Word: 2-byte, 16-bit
- Dword: double-word, 4-byte, 32-bit
- Qword: quadruple word, 8-byte, 64-bit

## Registers

Sebuah register adalah suatu bagian di processor yang digunakan untuk menampung data sementara dalam proses perhitungan. Register adalah wadah khusus dan dapat diakses dengan sangat cepat oleh processor (lebih tepatnya komponen ALU di prosessor).

x86 memiliki beberapa register, antara lain:

* General Purposes Register (32-bit dan 64-bit)
    - Data Registers
        - EAX/RAX: Accumulator
        - EBX/RBX: Base address untuk memory access
        - ECX/RCX: Counter
        - EDX/RDX: Data
    - Pointer Registers
        - ESP/RSP: Stack Pointer
        - EBP/RBP: Base Pointer
    - Index Registers
        - ESI/RSI: Source Index
        - EDI/RDI: Destination Index
* Segment Registers (limited access)
    - CS: Code
    - DS: Data
    - SS: Stack
    - ES: Extra
    - FS: Extra
    - GS: Extra
* Status / Control Registers
    - Control Registers (limited access): CR0 hingga CR4
    - Debug Registers (limited access): DR0 hingga DR3
    - Other Registers (no direct access)
        - EIP: Instruction pointer
        - EFLAGS: Flags
* XMM Registers: XMM0 to XMM15

#### General Purpose Register

Arsitektur x86 memiliki beberapa register yang dibagi menjadi beberapa kategori. General Purpose Register adalah sekelompok register yang dapat digunakan untuk menyimpan apapun dan keperluan apapun. Meski demikian, masing-masing dari mereka awalnya memiliki tujuan / fungsi khusus tapi menjadi keharusan untuk ditaati. GPR dapat dibagi menjadi tiga kategori register: Data Register, Pointer Register, dan Index Register.

`EAX/RAX` disebut pula Accumulator. Sering digunakan untuk operasi terkait I/O, operasi matematka, dan interrupts. `EBX/RBX` merupakan Base address yang digunakan sebagai Base pointer untuk memory access. `ECX/RCX` adalah counter, sering digunakan dalam loop yang membutuhkan counter. `EDX/RDX` adalah Data, mirip dengan EAX/RAX dan digunakan sebagai ekstensi ketika operasi matematika.

Register 32-bit memiliki prefiks E, contohnya EAX. Sementara register 64-bit memiliki prefiks R, contohnya RAX. Untuk beberapa register (EAX, EBX, ECX, EDX), kita dapat mengakses bagian bawah dari register dengan menghilangkan prefiks. Sehingga:

- EAX (32-bit) -> AX (16-bit)
- EBX (32-bit) -> BX (16-bit)
- ECX (32-bit) -> CX (16-bit)
- EDX (32-bit) -> DX (16-bit)

Fungsi awal register

Lebih jauh lagi, kita dapat mengakses paruh atas dan paruh bawah dari AX/BX/CX/DX dengan mengganti X dengan H (Higher half) atau L (Lower half). Sehingga:

- AX (16-bit) = AH (8-bit) | AL (8-bit)
- BX (16-bit) = BH (8-bit) | BL (8-bit)
- CX (16-bit) = CH (8-bit) | CL (8-bit)
- DX (16-bit) = DH (8-bit) | DL (8-bit)

Kita dapat mengilustrasikannya seperti ini:

```
    RAX                  EAX        AX
    --------------------------------------------
    |                     |          | AH | AL |
    --------------------------------------------
    64                   32         16    8    0
```

Untuk x86-64 (atau x64), terdapat tambahan register dari R8 hingga R15. Register R0 hingga R7 memiliki identitas lain untuk nama register yang sudah ada, seperti:

- R0 = RAX
- R1 = RCX
- R2 = RDX
- R3 = RBX
- R4 = RSP
- R5 = RBP
- R6 = RSI
- R7 = RDI

Untuk mengakses paruh bawah (32-bit) dari register R-, kita dapat memberikan sufiks D (DWord). Paruh bawah lagi dapat diakses dengan sufiks W (Word). Ilustrasi dapat dilihat di bawah ini:

```
    R8                   R8D        R8W  R8B
    --------------------------------------------
    |                     |          |    |    |
    --------------------------------------------
    64                   32         16    8    0
```

#### Segment Registers

`Segment Register` adalah sekelompok register yang digunakan untuk mengakses segment memori. Segment sendiri adalah bagian dari memori yang berukuran kelipatan dari Page. Setiap segment memiliki fungsi tersendiri.

Segment yang ditunjuk oleh Segment Register bersifat penting selama aplikasi berjalan. `CS` berisi Code Segment, merujuk ke lokasi kode / instruksi program. `DS` berisi Data Segment, merujuk ke lokasi data yang diakses. `ES`, `FS`, `GS` adalah Segment Register tambahan yang umumnya digunakan oleh OS. Sebagai contoh, `GS` digunakan oleh Windows untuk menunjuk struktur data khusus (spesifik OS).

#### Control Registers

`Control Register` adalah sekelompok register yang dapat mengubah atau mengendalikan perilaku dari processor (core). Setiap control register memiliki tujuan spesifik. 

#### Debug Registers

`Debug Register` adalah sekelompok register yang digunakan oleh processor untuk melakukan hardware debugging. Sebenarnya terdapat enam debug register: DR0, DR1, DR2, DR3, DR4/DR6, DR5/DR7. Register debug akan berisi alamat yang diawasi sebagai breakpoint di sisi hardware.

#### Instruction Pointer

`Instruction Pointer Register` adalah register yang menunjuk ke alamat memori tempat instruksi berikutnya akan dieksekusi. Disebut pula dengan `Program Counter (PC)` pada beberapa arsitektur lain. Hanya ada satu register untuk ini yaitu EIP (atau RIP untuk 64-bit).

EIP (ataupun RIP) tidak dapat dimodifikasi secara langsung. Tidak ada instruksi yang dapat mengganti EIP.

#### EFLAGS

`EFLAGS` adalah register yang merupakan kumpulan big-bit flag. Banyak instruksi. seperti perbandingan dan perhitungan matematika, memiliki efek samping. Efek samping dari masing-masing operasi ini direpresentasikan oleh bit-bit flag. Perubahan bit tersebut dapat mempengaruhi instruksi lain seperti conditional test sebagai acuan untuk melakukan control-flow.

Flag yang umum antara lain:

```
    Flag:                              O    D    I    T    S    Z         A         P         C
                ---------------------------------------------------------------------------------
    Bit Flag    | 31 | 30 | 29 | 28 | 27 | 26 | 25 | 24 | 23 | 22 | 21 | 20 | 19 | 18 | 17 | 16 |
                ---------------------------------------------------------------------------------

    Flag:                              O    D    I    T    S    Z         A         P         C
                ---------------------------------------------------------------------------------
    Bit Flag    | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
                ---------------------------------------------------------------------------------
```

|--------|--------|------------------------------|
|  Bit   | FLAG   | Description                  |
|--------|--------|------------------------------|
|   0    |   CF   | Carry Flag                   |
|   2    |   PF   | Parity Flag                  |
|   4    |   AF   | Auxiliary Carry Flag         |
|   6    |   ZF   | Zero Flag                    |
|   7    |   SF   | Sign Flag                    |
|   8    |   TF   | Trap Flag                    |
|   9    |   IF   | Interrupt Flag               |
|  10    |   DF   | Direction Flag               |
|  11    |   OF   | Overflow Flag                |
| 12-13  |  IOPL  | I/O Priviledge Level         |
|  14    |   NT   | Nested Task Flag             |
|  16    |   RF   | Resume Flag                  |
|  17    |   VM   | Virtual 8086-mode Flag       |
|  18    |   AC   | Algignment Check             |
|  19    |  VIF   | Virtual Interrupt Flag       |
|  20    |  VIP   | Virtual Interrupt Pending    |
|  21    |   ID   | ID Flag                      |
|--------|--------|------------------------------|

#### MMX

Termasuk ke dalam Instruction Set tambahan yang tak ada di generasi awal x86. Kebanyakan instruksinya merupakan SIMD (Single Instruction Multiple Data), yang artinya satu instruksi dapat bekerja dengan beberapa data secara paralel.

Terdapat 8 MM register 64-bit, dari MM0 hingga MM7. Delapan register tersebut dibuat overlap dengan FPU register. Artinya, instruksi MMX dan FPU tidak dapat digunakan secara simultan.

Masing-masing register berukuran 64-bit namun dapat dipecah secara akses menjadi beberapa yaitu:

* 2x 32-bit value
* 4x 16-bit value
* 8x  8-bit value

MMX mengimplementasikan teknik *Saturation Arithmetic*. Pada teknik ini, nilai register tidak pernah melebihi 0 jika overflow terjadi. Nilai juga tidak akan berubah menjadi MAX value jika underflow terjadi. Dengan kata lain, keadaan ini akan terjadi:

```
255 | 100 = 255
200 | 100 = 255
0 - 100 = 0
99 - 100 = 0
```

Hal ini nampak aneh bagi sebagian orang yang terbiasa menggunakan General Purpose Register. Tapi untuk kasus tertentu, hal ini berguna. Misal, untuk membuat warna lebih terang, maka tak seharusnya overflow terjadi sehingga dapat mengubah warna terang jadi gelap seketika.

#### SSE (Streaming SIMD Extensions)

`SSE` adalah register untuk operasi pecahan (floating point). Ukuran register ini adlaah 128-bit. Tapi register ini tak terbatas hanya digunakan untuk operasi pecahan saja tapi juga bisa digunakan untuk beragam ukuran data dan tipe berbeda.

Terdapat 8 SSE register 128-bit, dari XMM0 hingga XMM7. Tak seperti MMX, SSE tidak overlap dengan floating point stack.

Register dengan ukuran 128-bit dapat dipecah menjadi beberapa bagian yaitu:

* 2x  64-bit floating points (double-precision)
* 2x  64-bit integers
* 4x  32-bit floating points (single-precision)
* 4x  32-bit integers
* 8x  16-bit integers
* 16x  8-bit characters (bytes)
