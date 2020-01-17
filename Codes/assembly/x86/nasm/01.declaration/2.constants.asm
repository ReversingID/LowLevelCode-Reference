;   constants.asm
;
;   Menciptakan konstanta.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o constants.o constants.asm
;
;   (win32)
;   $ nasm -f win32 -o constants.o constants.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o define-data define-data.o
;
;   (windows)
;   $ ld -m i386pe -o define-data define-data.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

    global _start

; Konstanta dapat dideklarasikan dengan instruksi 'equ' (equate). Instruksi ini
; tidak mengalokasikan ruang apapun. Simbol atau token akan dievaluasi kemudian
; dan segala kemunculan konstanta akan digantikan dengan nilai terkait.
;
; Karenanya, mendefinisikan konstanta hanyalah sebatas memberi nilai ke suatu nama
; dan berlaku saat kompilasi.

lenequ:  equ 4      ; kapanpun 'lenequ' ditemukan di source code, ia akan
                    ; diganti dengan 4

; Instruksi equ mirip dengan #define di C.
; #define lenequ 4

; Instruksi lain yang sepadan untuk mendeklarasikan konstanta adalah dengan %define
; Instruksi %define dapat diletakkan dimanapun, bahkan di dalam fungsi.

%define DLENEQU 10

section .data
; Bandingkan dengan 'db'
    lendb:   db 4   ; tulis 4 ke 1 byte memory 

section .text
_start:
; untuk mengilustrasikan memory layout, kode berikut akan digunakan
    mov     eax, lenequ
    mov     eax, dword [lendb]

; hasilnya akan serupa dengan ini, asumsi bahwa alamat kode berada tepat
; setelah section data.
;
; addr      code            label   instruction
;-------------------------------------------
; 402000                    lenequ  equ 4
; 402000    04              lendb   db  4
; 402001    b8 04 00 00 00          mov eax, lenequ
; 402006    a1 00 20 40 00          mov eax, [lendb]

    hlt         ; Hentikan eksekusi