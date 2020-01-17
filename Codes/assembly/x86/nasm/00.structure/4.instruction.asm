;   instruction.asm
;
;   Instruksi adalah statement yang memberitahu processor apa yang harus dilakukan.
;   Sebuah instruction memiliki format.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o instruction.o instruction.asm
;
;   (win32)
;   $ nasm -f win32 -o instruction.o instruction.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o instruction instruction.o
;
;   (windows)
;   $ ld -m i386pe -o instruction instruction.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

    global _start

section .data
    MEMVAR: dd 0


; Instruction adalah statement dalam satu baris tunggal.
; Setiap instruksi memiliki format berikut:
;
;   [label:] mnemonic [operands] [;comment]
;
; Field yang ada di dalam [] merupakan field opsional.
; 
; Umumnya instruction memiliki dua bagian.
; Bagian pertama adalah mnemonic atau nama instruksi yang akan dieksekusi.
; Bagian kedua adalah operand atau parameter dari instruksi.
;
; Tidak semua instruction memiliki operand. Beberapa instruksi memiliki lebih dari
; satu operand.
;
; Instruction sebaiknya dideklarasikan di dalam section code, meski bukan sebuah
; keharusan.

section .text
_start:

; Contoh Instructions
; Two Operand
;   Instruksi dengan dua operan melibatkan satu operan sebagai sumber dan operan lain
;   sebagai tujuan. NASM menggunakan Intel-style, dimana pada sebagian besar kasus
;   kita dapat menggeneralisir sebuah isntruksi sebagai:
;
;       INSTR   DST, SRC
;
;   Dengan INSTR merupakan instruction, SRC adalah operan source (sumber), dan DST
;   adalah operan destination (tujuan). DST adalah lokasi yang akan dirujuk untuk menyimpan
;   hasil operasi. DST dapat dianggap sebagai sisi kiri (LHS - Left-Hand Side) dari sebuah
;   rumus sementara SRC merupakan sisi kanan (RHS - Right-Hand Side).
;
;   Sehingga, sebuah instruksi dapat diterjemahkan sebagai:
;
;       DST INSTR SRC

    mov     ah, 10      ; assign AH dengan 10
                        ;   ah = 10
    add     ah, bh      ; tambahkan nilai BH ke AH
                        ;   ah = ah + bh

; One Operand
;   Instruksi dengan satu operan melibatkan operan sebagai source maupun destination, 
;   bergantung kepada instruction tersebut.

    inc     eax         ; tingkatkan nilai di register EAX sebanyak 1, 
    dec     bh          ; susutkan nilai di register BH sebanyak 1
    push    eax         ; push isi dari register EAX ke stack

; Tanpa Operan
    syscall             ; panggil OS syscall (tergantung OS)
    ret                 ; return dari function

; Jika perlu mengulang instruction, prefix 'times' dapat digunakan untuk mengindikasikan
; bahwa instruction berikutnya akan direplikasi sebanyak sekian salinan.
    times 100 movsb     ; the result code will have 100 instructions of movsb


    hlt         ; Hentikan eksekusi