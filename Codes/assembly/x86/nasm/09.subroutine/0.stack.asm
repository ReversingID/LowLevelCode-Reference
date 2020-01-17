;   stack.asm
;
;   Akses dan modifikasi Stack.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o stack.o stack.asm
;
;   (win32)
;   $ nasm -f win32 -o stack.o stack.asm
;
; Link:
;   $ gcc -m32 -o stack stack.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Stack
; 
; Disebut pula dengan struktur data 'Last In First Out' (LIFO).
; Stack adalah segment di memory untuk menyimpan data secara terurut dengan
; dua operasi dasar: PUSH dan POP
; 
; Push adalah operasi meletakkan nilai ke puncak stack dan pop mengambil
; nilai dari puncak.
;
; Stack berukuran dinamis dan berkembang dari High-Memory ke Low-Memory.
; Artinya, elemen berikutnya dari stack akan berada di posisi alamat memory
; yang lebih rendah.
;
;
;        ----------------
;       |      TOP       |     <--- ESP
;       |----------------|
;       |      ....      |
;       |----------------|
;       |    <N data>    |
;       |----------------|
;       |     BOTTOM     |     <--- EBP
;       |----------------|
;       | Previous Frame |
;


section .bss
    dblock  resd    1
    qblock  resq    1


section .text
_start:

; Alokasi dan dealokasi ruang
    ; Alokasi ruang di stack dilakukan dengan memperluas stack.
    ; Secara teknis, hal ini dilakukan dengan mengurangi nilai ESP.

    sub     esp, 128                ; alokasi 128 byte di stack

    ; Dealokais ruang di stack dilakukan dengan menyusutkan stack.
    ; Secara teknis, hal ini dilakukan dengan menambah nilai ESP

    add     esp, 128                ; dealokasi 128 byte di stack

    ; Nilai ESP haruslah konsisten sehingga semua alokasi harus didealokasi.

; PUSH value
    ; Simpan nilai register ke stack (alamat yang ditunjuk oleh ESP/RSP).
    ; Stack harus selalu aligned, ukuran elemen sama dengan ukuran memory alignment.
    ; Dimana alignment selalu:
    ;   * 4-byte pada program 32-bit
    ;   * 8-byte pada program 64-bit

    ; push immediate value 
    push    135

    ; push register
    push    eax
    ; error jika dieksekusi pada program 32-bit
    push    rax

    ; push isi dari alamat memory
    push    dword [dblock]
    ; error jika dieksekusi pada program 32-bit
    push    qword [qblock]

    ; Ketika push nilai berhasil dilakukan, stack akan berkembang.
    ; Stack berkembang dari High-Memory ke Low-Memory, terindikasi dari
    ; nilai ESP register yang lebih kecil dari sebelumnya.
    

; Modifikasi stack entry
    ; Modifikasi stack, baik alamat maupun konten
    
    ; dapatkan alamat memory
    mov     eax, esp                ; alamat puncah stack (entry ke-0)
    lea     eax, [esp]
    lea     eax, [esp + 4]          ; dapatkan entry pertama (asumsi alignment 4-byte)

    ; dapatkan data dari posisi puncak
    mov     eax, dword [dblock]
    ; error jika dieksekusi pada program 32-bit
    mov     rax, qword [qblock]

    ; modifikasi stack entry
    mov     dword [esp], eax
    ; error jika dieksekusi pada program 32-bit
    mov     qword [rsp], rax

    ; Stack digunakan untuk menyimpan variabel lokal, argumen ke fungsi, hingga
    ; penyimpanan informasi penting lain terkait eksekusi.
    ; Umumnya, variabel lokal dirujuk sebagai offset positif terhadap ESP,
    ; atau offset negatif terhadap EBP.
    ; Sementara argumen fungsi dirujuk sebagai offset positif terhadap EBP.

; POP value
    ; Memuat nilai dari posisi puncak stack ke register dan menghapus posisi puncak.
    ; Stack harus selalu aligned, ukuran elemen sama dengan ukuran memory alignment.
    ; Dimana alignment selalu:
    ;   * 4-byte pada program 32-bit
    ;   * 8-byte pada program 64-bit

    ; pop register
    pop     eax
    ; error jika dieksekusi pada program 32-bit
    pop     rax

    ; pop ke alamat memory
    pop     dword [dblock]
    ; error jika dieksekusi pada program 32-bit
    pop     qword [qblock]


    hlt         ; Hentikan eksekusi