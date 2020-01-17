;   ms-x64-conv.asm
;
;   Fungsi dengan Microsoft x64 calling convention
;
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o ms-x64-conv.o ms-x64-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o ms-x64-conv.o ms-x64-conv.asm
;
; Link:
;   $ gcc -m32 -o ms-x64-conv ms-x64.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Calling convention ini spesifik untuk x64.
; Microsoft x64 calling convention digunakan oleh Windows dan pre-boot UEFI.

; Calling Convention, adalah konvensi (perjanjian) atau aturan yang mengendalikan 
; bagaimana pemanggilan fungsi dilakukan.
; Umumnya, sebuah calling convention mengatur:
;   - bagaimana argumen diberikan
;   - bagaimana nilai dikembalikan oleh fungsi
;   - bagaimana nilai register dipertahankan ketika pemanggilan fungsi
;   - siapa yang bertanggung jawab membersihkan stack (argumen) setelah pemanggilan.

; Ini adalah satu-satunya calling-convention untuk Windows x64.
;
; Di ms-x64 calling convention,
;   - empat argumen awal akan disimpan di register, selebihnya akan disimpan ke stack
;     dengan urutan kanan-ke-kiri.
;   - pengembalian nilai bilangan bulat dengan meletakkan di register RAX atau XMM0
;   - register EBP, EBX, ESI, dan EDI dipertahankan oleh Caller.
;   - Caller bertanggung jawab membersihkan stack.

section .text
_start:

    ; Argumen disimpan di register.
    ; Empat argumen awal untuk integer dan pointer disimpan di RCX, RDX, R8, dan R9. 
    ; Empat argumen awal untuk floating point disimpan di XMM0, XMM1, XMM2, dan XMM3.
    ; Selebihnya disimpan di Stack dengan urutan kanan-ke-kiri

    mov     rcx, 1      ; arg1
    mov     rdx, 2      ; arg2
    mov     r8,  3      ; arg3
    mov     r9,  4      ; arg4

    call    func_x64

    ; Caller bertanggung jawab membersihkan stack setelah pemanggilan fungsi.

    ; Pembersihan stack dapat dilakukan setiap kali selesai memanggil fungsi atau
    ; dilakukan menjelang akhir eksekusi fungsi caller.

    hlt         ; Hentikan eksekusi


;-----------------------------------------------------------------------------

; Deklarasi fungsi dengan ms-x64.
;
; func_x64(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_x64:

    ; Function Prologue
    push    rbp
    mov     rbp, rsp 

    ; Function Body
    add     rcx, rdx                ; arg1 += arg2 
    add     r8, r9                  ; arg3 += arg4
    add     rcx, r8 
    mov     rax, rcx 

    ; Function Epilogue
    pop     rbp 

    ret