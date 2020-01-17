;   multi.asm
;
;   NASM Macro Preprocessing.
;   Single-Line atau Multiline
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o multi.o multi.asm
;
;   (win32)
;   $ nasm -f win32 -o multi.o multi.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o multi multi.o
;
;   (windows)
;   $ ld -m i386pe -o multi multi.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

    global _start

; Semua multiline macro harus didefinisikan di dalam directive %macro dan %endmacro.
; Struktur umum sebuah macro adalah:
;
;   %macro      macro_name      number_of_parameters
;       instruction
;       instruction
;       ...
;   %endmacro

%macro prologue 1
    push    ebp
    mov     ebp, esp
; parameter dirujuk sebagai angka (urutan), contoh %1, %2, dst
    sub     esp, %1
%endmacro


; Macro dapat memiliki label lokal
; Setiap pemanggilan terhadap label akan menginstansiasi label unik.
%macro retz 0
    jnz     %%skip
    ret 
%%skip:
%endmacro


; Macro akan dikembangkan menjadi instruksi yang sesuai.
; Ketika ekspansi, single-line macro yang mengandung token macro lain akan
; menyebabkan ekspansi dilakukan secara rekursif.
; Ekspansi dilakukan saat pemanggilan terjadi, bukan saat definisi.

; seluruh label yang didefinisikan di dalam macro diawali %%
%macro PRINT 1
    jmp %%astr
%%str      db %1, 0
%%strlen   equ $ - %%str 
%%astr: _syscall_write %%str, %%strlen 
%endmacro 

%macro _syscall_write 2
    mov     eax, 1
    mov     edi, 1
    mov     esi, %1
    mov     edx, %2
    syscall
%endmacro 



section .text 
_start:
    ; ekspansi macro terjadi ketika digunakan

    ; ekspansi prologue menjadi tiga instruksi
    prologue 12
    ; push    ebp
    ; mov     ebp, esp
    ; sub     esp, 12


    ; gunakan macro PRINT
label: PRINT "Hello World!"  

    hlt