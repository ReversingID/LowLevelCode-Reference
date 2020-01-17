;   addressing-modes.asm
;
;   Beberapa instruksi memerlukan data yang disimpan di lokasi tertentu.
;   Addressing mode merujuk kepada penentuan lokasi data yang dibutuhkan.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o addressing-modes.o addressing-modes.asm
;
;   (win32)
;   $ nasm -f win32 -o addressing-modes.o addressing-modes.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o addressing-modes addressing-modes.o
;
;   (windows)
;   $ ld -m i386pe -o addressing-modes addressing-modes.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
;   Comment beberapa instruksi untuk menyesuaikan dengan target platform.
; 
;-----------------------------------------------------------------------------

    global _start

; Pada kebanyakan instruksi dengan operator ganda, satu operan bertindak sebagai
; sumber dan operan lain sebagai tujuan.
;
; operan yang berperan sebagai sumber dapat berupa:
;   - immediate (nilai yang tertulis secara hardcode)
;   - register
;   - alamat memory
;   - I/O port
;
; sementara operan yang menjadi tujuan dapat berupa:
;   - register
;   - alamat memory
;   - I/O port
;
; kebanyakan, instruksi yang valid dapat berupa:
;   inst reg, reg 
;   inst reg, mem 
;   inst reg, imm 
;   inst mem, reg 
;   inst mem, imm 


; Registers Operands menggunakan register yang valid, seperti
; General Purpose Register
;   - 64-bit GPR: RAX, RBX, RCX, RDX, RSI, RDI, RSP, RBP, R8-R15
;   - 32-bit GPR: EAX, EBX, ECX, EDX, ESI, EDI, ESP, EBP, R8D-R15D
;   - 16-bit GPR:  AX,  BX,  CX,  DX,  SI,  DI,  SP,  BP, R8W-R15W
;   -  8-bit GPR:  AL,  BL,  CL,  DL, SIL, DIL, SPL, BPL, R8L-R15L
; serta MMX Register (MM0 - MM7) dan XMM Register (XMM0 - XMM15)


; Immediate Operands adalah bilangan atau nilai yang tertulis secara hardcode di instruksi.
; Sebuah nilai dapat diekspresikan dalam berbagai cara:
;   200              (desimal)
;   0200             (tetap desimal, awalan 0 tidak membuatnya sebagai oktal)
;   0200d            (desimal dengan akhiran d untuk penegasan)
;   0d200            (desimal dengan awalan 0d untuk penegasan)
;   0c8h             (hex, akhiran h, butuh awalan 0 karena c8h dapat dianggap sebagai variabel)
;   0xc8             (hex, dengan awalan 0x)
;   0hc8             (hex, dengan awalan 0h)
;   310q             (octal, akhiran q)
;   0q310            (octal, awalan 0q)
;   11001000b        (binary, awalan b)
;   0b1100_1000      (binary, awalan 0b, underscore diperbolehkan)


; Memory operand adalah alamat memory.
; Operan ini memiliki pola sebagai berikut:
;   [ base + index * scale + displacement ]
;
; Base adalah nilai dasar dari sebuah alamat, dapat berupa General Purpose Register:
;   EAX, EBX, ECX, EDX, ESP, EBP, ESI, EDI
;   R8, R9, R10, R11, R12, R13, R14, R15
;
; Scale adalah skala, faktor pengali dari base.
;   Angka yang valid: 1, 2, 4, 8 
;
; Index adalah penanda potongan data ke-i (dengna ukuran potngan sebesar Scale).
; Dapat berupa General Purpose Register:
;   EAX, EBX, ECX, EDX, EBP, ESI, EDI
;   R8, R9, R10, R11, R12, R13, R14, R15
;
; Displacement adalah offset ke alamat. Dapat berupa immediate value.

section .data
    BYTE_VALUE: db 150                  ; Definidikan nilai bertipe byte
    WORD_VALUE: dw 300                  ; Definidikan nilai bertipe word
    BYTE_TABLE: db 14, 15, 22, 45       ; Tabel bertipe byte
    WORD_TABLE: dw 134, 345, 564, 123   ; Tabel bertipe word


section .text
_start:

; Berbagai kombinasi yang valid dapat menjadi referensi ke alamat memory

    ; [1] Displacement 
    ; Displacement saja dapat digunakan secara langsung untuk menunjuk alamat tetap.
    ; Disebut pula Absolute Address atau Static Address.

    mov     [BYTE_VALUE], dl
    mov     bx, [0x12345678]

    ; [2] Base
    ; Base saja merepresentasikan akses tak langsung ke alamat memory.
    ; Karena nilai di Base dapat berubah, pengalamatan ini dapat digunakan untuk 
    ; penyimpanan variabel dan struktur data secara dinamis.

    mov     eax, [eax]
    mov     ebx, [eax]

    ; [3] Base + Displacement
    ; Base Register dan Displacement dapat digunakan bersamaan untuk dua hal:
    ;   - mengakses field dari record / struktur
    ;   - mengakses elemen array dimana ukuran array bukan kelipatan 2 (2, 4, atau 8 byte).

    mov     ecx, [ecx + 4]
    mov     dword [edx + 6], 135

    ; [4] (Index * Scale) + Displacement
    ; Cara efisien untuk mengakses index tertentu pada static array dengan ukuran
    ; 2, 4, atau 8 byte.

    mov     ecx, [WORD_TABLE + eax*4]
    mov     dword [WORD_TABLE + eax*4], 10

    ; [5] Base + Index + Displacement
    ; Dua register digunakan bersama untuk mengakses elemen pada:
    ;   - array dua dimensi (Displacement menunjuk alamat awal array)
    ;   - array of record

    mov     edx, [WORD_TABLE + eax + 4]
    mov     [WORD_TABLE + eax + 4], edx

    ; [6] Base + Index * Scale + Displacement
    ; Menggunakan semua komponen untuk mengakses alamat

    mov     edx, [WORD_TABLE + eax * 4 + 4]
    mov     [WORD_TABLE + eax * 4 + 4], edx

; RIP Relative Addressing
; Pada mode 64-bit, bentuk pengalamatan baru tersedia untuk mengakses alamat yang bersifat
; Position-Independent Code (PIC). Semua memory reference relatif terhadap RIP.

    mov     rax, [rel BYTE_VALUE]
    mov     [rel BYTE_VALUE], rax

    ; Keenam mode pengalamatan sebelumnya dapat diekspresikan sebagai alamat absolut.
    mov     rax, [abs BYTE_VALUE]       ; [abs BYTE_VALUE] sepadan dengan [BYTE_VALUE]
    mov     [abs BYTE_VALUE], rax


    hlt         ; Hentikan eksekusi