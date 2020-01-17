;   single.asm
;
;   NASM Macro Preprocessing.
;   Single-Line atau Multiline
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o single.o single.asm
;
;   (win32)
;   $ nasm -f win32 -o single.o single.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o single single.o
;
;   (windows)
;   $ ld -m i386pe -o single single.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

    global _start

; Semua single-line macro harus didefinisikan dengan directive %define
; Struktur umum sebuah macro adalah:
;
;   %define     macro_name(parameter)       value


; definisikan variabel
;           name    value
%define     argc    esp + 8
%define     ctrl    0x1F &

; definisikan "fungsi"
%define     param(a,b)      ((a)+(a)*(b))

; Macro akan dikembangkan menjadi instruksi yang sesuai.
; Ketika ekspansi, single-line macro yang mengandung token macro lain akan
; menyebabkan ekspansi dilakukan secara rekursif.
; Ekspansi dilakukan saat pemanggilan terjadi, bukan saat definisi.

%define     a(x)    1 + b(x)
%define     b(x)    2 * x

; Macro dapat di-overload sebanyak apapun

%define     foo(x)      1 + x
%define     foo(x,y)    1 + x * y



section .text 
_start:
    ; ekspansi macro terjadi ketika digunakan

    ; argc akan dievaluasi sebagai rsp + 8, sehingga menjadi:
    ;   mov eax, [rsp + 8]
    mov     eax, [argc]

    ; ekspansi menjadi
    ;   mov byte [(2)+(2)*(ebx)], 0x1F & 'D'
    mov     byte [param(2,ebx)], ctrl 'D'

    ; ekspansi menjadi
    ;   mov eax, 1 + 2 * 3 
    ; atau pada akhirnya menjadi
    ;   mov eax, 7
    mov     eax, a(3)

    ; ekspansi menjadi
    ;   mov eax, 1 + 2
    mov     eax, foo(2)

    ; ekspansi menjadi
    ;   mov eax, 1 + 2 + 3
    mov     eax, foo(2,3)

    hlt