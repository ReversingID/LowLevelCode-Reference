;   stdcall-conv.asm
;
;   Fungsi dengan STDCALL calling convention.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o stdcall-conv.o stdcall-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o stdcall-conv.o stdcall-conv.asm
;
; Link:
;   $ gcc -m32 -o stdcall-conv stdcal-convl.o
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

; STDCALL umumnya merupakan standard yang digunakan Microsoft untuk Win32 API.
;
; Di STDCALL Calling Convention, 
;   - argumen diberikan melalui push ke stack dengan urutan kanan-ke-kiri.
;   - pengembalian nilai bilangan bulat dengan meletakkan di register EAX
;   - Callee bertanggung jawab membersihkan stack.
;
; STDCALL tidak mendukung argumen dengan panjang bervariasi.

section .text
_start:

    ; Argumen di-push ke stack.
    push    4       ; arg4
    push    3       ; arg3
    push    2       ; arg2
    push    1       ; arg1

    call    func_stdcall

    hlt         ; Hentikan eksekusi



;-----------------------------------------------------------------------------

; Deklarasi fungsi dengan STDCALL.
;
; func_stdcall(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_stdcall:

    ; Function Prologue
    push    ebp
    mov     ebp, esp 

    ; Function Body
    mov     eax, dword [ebp +  8]       ; eax  = arg1
    mov     eax, dword [ebp + 12]       ; eax += arg2
    mov     eax, dword [ebp + 16]       ; eax += arg3
    mov     eax, dword [ebp + 20]       ; eax += arg4

    ; Function Epilogue
    pop     ebp 

    ; Callee bertanggung jawab membersihkan stack.
    ; Fungsi ini membutuhkan 16 byte data di stack.
    ret     16