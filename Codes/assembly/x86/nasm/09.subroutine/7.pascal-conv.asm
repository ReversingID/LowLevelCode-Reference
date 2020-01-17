;   pascal-conv.asm
;
;   Fungsi dengan Pascal calling convention.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o pascal-conv.o pascal-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o pascal-conv.o pascal-conv.asm
;
; Link:
;   $ gcc -m32 -o pascal-conv pascal-conv.o
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

; Calling Convention ini berdasarkan Calling Convention yang dipakai Borland Pascal
;
; Di Pascal, 
;   - argumen diberikan melalui push ke stack dengan urutan kiri-ke-kanan.
;   - pengembalian nilai dengan aturan
;       - EAX menyimpan 'Ordinal' dan pointer
;       - DX:BX:AX untuk 'Real'
;       - ST0 untuk floating point.
;       - string diletakkan di lokasi temporer yang ditunjuk @Result
;   - Callee bertanggung jawab membersihkan stack.

section .text
_start:

    ; Argumen di-push ke stack
    push    1       ; arg1
    push    2       ; arg2
    push    3       ; arg3
    push    4       ; arg4

    call    func_pascal


    hlt         ; Hentikan eksekusi


;-----------------------------------------------------------------------------

; Deklarasi fungsi dengan Pascal
;
; func_pascal(arg1, arg2, arg3 arg4)
;   => arg1 + arg2 + arg3 + arg4

func_pascal:

    ; Function Prologue
    push    ebp 
    mov     ebp, esp 

    ; Function Body
    mov     eax, dword [ebp + 8]
    add     eax, dword [ebp + 12]
    add     eax, dword [ebp + 16]
    add     eax, dword [ebp + 20]

    ; Function Epilogue
    pop     ebp 

    ; Callee bertanggung jawab membersihkan stack.
    ; Fungsi ini membutuhkan 16 byte data di stack.
    ret     16