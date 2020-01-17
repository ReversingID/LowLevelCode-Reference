;   fastcall-conv.asm
;
;   Fungsi dengan Fastcall calling convention.
;
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o fastcall-conv.o fastcall-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o fastcall-conv.o fastcall-conv.asm
;
; Link:
;   $ gcc -m32 -o fastcall-conv fastcall-conv.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Calling Convention, adalah konvensi (perjanjian) atau aturan yang mengendalikan 
; bagaimana pemanggilan fungsi dilakukan.
; Umumnya, sebuah calling convention mengatur:
;   - bagaimana argumen diberikan
;   - bagaimana nilai dikembalikan oleh fungsi
;   - bagaimana nilai register dipertahankan ketika pemanggilan fungsi
;   - siapa yang bertanggung jawab membersihkan stack (argumen) setelah pemanggilan.

; Di Fastcall Calling Convention, 
;   - dua argumen awal akan disimpan di register, selebihnya akan disimpan ke stack
;     dengan urutan kanan-ke-kiri.
;   - pengembalian nilai bilangan bulat dengan meletakkan di register EAX
;   - Callee bertanggung jawab membersihkan stack.
;
; Karena ambiguitasnya, direkomendasikan hanya menggunakan Fastcall di situasi dimana
; fungsi hanya memiliki 1, 2, atau 3 argumen saja dan ketika kecepatan sangat penting.


section .text
_start:

    ; Argumen disimpan di register.
    ; Dua argumen awal untuk integer dan pointer disimpan di ECX, EDX.
    ; Selebihnya (arg3 dst) akan disimpan di stack.
    ; Dalam kasus ini, urutan push ke stack perlu diperhatikan.

    push    4           ; arg4
    push    3           ; arg3
    mov     edx, 2      ; arg2
    mov     ecx, 1      ; arg1

    call    func_fastcall


    hlt         ; Hentikan eksekusi


;-----------------------------------------------------------------------------

; Deklarasi fungsi dengan Fastcall
;
; func_fastcall(arg1, arg2, arg3 arg4)
;   => arg1 + arg2 + arg3 + arg4

func_fastcall:

    ; Function Prologue
    push    ebp 
    mov     ebp, esp 

    ; Function Body
    ; ECX dan EDX digunakan sebagai argumen pertama dan kedua.
    add     ecx, edx                ; arg1 += arg2
    add     ecx, dword [ebp + 8]    ; arg1 += arg3
    add     eax, dword [ebp + 16]   ; arg1 += arg4
    mov     eax, ecx

    ; Function Epilogue
    pop     ebp 

    ; Callee bertanggung jawab membersihkan stack.
    ; Fungsi ini membutuhkan 4 byte data di stack.
    ret     8