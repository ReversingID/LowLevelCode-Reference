;   sysv-abi-conv.asm
;
;   Fungsi dengan Sys-V ABI x64 calling convention
;
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o sysv-abi-conv.o sysv-abi-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o sysv-abi-conv.o sysv-abi-conv.asm
;
; Link:
;   $ gcc -m32 -o sysv-abi-conv sysv-abi-conv.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Calling convention ini spesifik untuk x64.
; System-V AMD64 ABI digunakan oleh Solaris, Linux, FreeBSD, MacOS, dan secara 
; defacto oleh kebanyakan Operating System Unix (dan Unix-like).

; Calling Convention, adalah konvensi (perjanjian) atau aturan yang mengendalikan 
; bagaimana pemanggilan fungsi dilakukan.
; Umumnya, sebuah calling convention mengatur:
;   - bagaimana argumen diberikan
;   - bagaimana nilai dikembalikan oleh fungsi
;   - bagaimana nilai register dipertahankan ketika pemanggilan fungsi
;   - siapa yang bertanggung jawab membersihkan stack (argumen) setelah pemanggilan.

; Di Sys-V ABI calling convention,
;   - enam argumen awal akan disimpan di register, selebihnya akan disimpan ke stack dengan
;     urutan kanan ke kiri.
;   - pengembalian nilai bilangan bulat dengan meletakkan di register RAX atau RDX:RAX untuk
;     integer, dan XMM0 atau XMM1:XMM0 untuk floating point.
;   - register EBP, EBX, ESI, dan EDI dipertahankan oleh Caller.
;   - Caller bertanggung jawab membersihkan stack.

section .text
_start:

    ; Argumen disimpan di register.
    ; Enam argumen awal untuk integer dan pointer disimpan di RDI, RSI, RDX, RCX, R8, R9.
    ; Enam argumen awal untuk floating point disimpan di XMM0, XMM1, XMM2, XMM3, XMM4, XMM5.
    ; R10 digunakan sebagai static chain pointer untuk nested function.
    ; Selebihnya disimpan di Stack dengan urutan kanan-ke-kiri

    mov     rdi, 1      ; arg1
    mov     rsi, 2      ; arg2
    mov     rdx, 3      ; arg3
    mov     rcx, 4      ; arg4

    call    func_x64

    ; Caller bertanggung jawab membersihkan stack setelah pemanggilan fungsi.

    ; Pembersihan stack dapat dilakukan setiap kali selesai memanggil fungsi atau
    ; dilakukan menjelang akhir eksekusi fungsi caller.

    hlt         ; Hentikan eksekusi


;-----------------------------------------------------------------------------

; Deklarasi fungsi dengan Sys-V ABI.
;
; func_x64(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_x64:

    ; Function Prologue
    push    rbp
    mov     rbp, rsp 

    ; Function Body
    add     rdi, rsi                ; arg1 += arg2 
    add     rdx, rcx                ; arg3 += arg4
    add     rdi, rdx 
    mov     rax, rdi 

    ; Function Epilogue
    pop     rbp 

    ret