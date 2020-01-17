;   recursion.asm
;
;   Pemanggilan fungsi secara rekursif.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o recursion.o recursion.asm
;
;   (win32)
;   $ nasm -f win32 -o recursion.o recursion.asm
;
; Link:
;   $ gcc -m32 -o recursion recursion.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Rekursi adalah metode pemecahan masalah dengan solusi terkini bergantung kepada
; solusi untuk problem yang lebih kecil.

; Berdasarkan hal ini, fungsi rekursif adalah fungsi yang memanggil dirinya sendiri
; selama eksekusi hingga mencapai titik tertentu. Hal ini mengakibatkan fungsi 
; berulang beberapa kali dan membentuk siklus.

; Sebuah fungsi rekursi memiliki:
;   - satu atau lebih base case, dan
;   - satu atau lebih kasus rekurens.
;
; Base Case adalah kondisi dimana rekursi berakhir dan input dapat digunakan untuk 
; menghasilkan solusi secara langsung.
; Sementara rekurens adalah kondisi dimana input (problem) dipecah menjadi bagian kecil
; dan diselesaikan dengan memanggil fungsi diri sendiri untuk problem tersebut.


section .text
_start:
    push    5
    call    func_recursion
    
    pop     edx

    hlt     ; Hentikan eksekusi


;-----------------------------------------------------------------------------

; Deklarasi fungsi rekursif.
;
; func_recursion(X)
;   => 0                                , jika X <= 0
;   => X + func_recursion(X - 1)        , jika X > 0 

func_recursion:

    ; Function Prologue
    push    ebp 
    mov     ebp, esp

    ; Base Case,        jika X <= 0
    mov     edx, dword [ebp + 8]    ; arg1
    cmp     edx, 0
    jg      .recurrence
    mov     eax, 0
    jmp     .result

    ; Recurrence Case,  jika X > 0
.recurrence:
    dec     edx                     ; X - 1
    push    edx 
    call    func_recursion          ; func_recursion(X - 1)

    pop     edx
    add     eax, dword [ebp + 8]    ; X + func_recursion(X - 1)

.result: 
    ; function prologue
    pop     ebp
    ret 

    