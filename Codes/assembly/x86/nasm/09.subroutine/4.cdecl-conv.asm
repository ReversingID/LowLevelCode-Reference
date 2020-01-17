;   cdecl-conv.asm
;
;   Fungsi dengan CDECL calling convention.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o cdecl-conv.o cdecl-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o cdecl-conv.o cdecl-conv.asm
;
; Link:
;   $ gcc -m32 -o cdecl-conv cdecl-conv.o
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

; CDECL adalah standard atau calling convention default di C.
;
; Di CDECL Calling Convention
;   - argumen diberikan melalui push ke stack dengan urutan kanan-ke-kiri.
;   - pengembalian nilai bilangan bulat dan alamat memory dengan meletakkan di register EAX,
;     floating point di ST0
;   - EAX, ECX, EDX adalah caller-saved dan selebihnya adalah callee-saved.
;   - Caller bertanggung jawab membersihkan stack.

section .text
_start:

    ; Argumen di-push ke stack
    push    4       ; arg4
    push    3       ; arg3
    push    2       ; arg2
    push    1       ; arg1

    call    func_cdecl

    ; Caller bertanggung jawab membersihkan stack setelah pemanggilan fungsi.
    add     esp, 16 ; karena terjadi push 16 byte

    ; Pembersihan stack dapat dilakukan setiap kali selesai memanggil fungsi atau
    ; dilakukan menjelang akhir eksekusi fungsi caller.

    hlt         ; Hentikan eksekusi


;-----------------------------------------------------------------------------

; Deklarasi fungsi dengan CDECL
;
; func_cdecl(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_cdecl:

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

    ret