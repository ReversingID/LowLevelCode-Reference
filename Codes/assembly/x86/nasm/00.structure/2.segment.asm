;   segment.asm
;
;   Memory segmentation
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o segment.o segment.asm
;
;   (win32)
;   $ nasm -f win32 -o segment.o segment.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o segment segment.o
;
;   (windows)
;   $ ld -m i386pe -o segment segment.o
;
; Note:
;   Potongan kode ini tak lengkap dan tidak dimaksudkan untuk dijalankan
;   sebagai sebuah program.
; 
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; Segmented memory model membagi system memory ke beberapa bagian independen
; yang disebut sebagai segment. Segment dapat dirujuk (reference) melalui 
; segment register. Setiap segment digunakan untuk menyimpan komponen spesifik
; seperti data, kode, stack, dsb.
;
; Segment dan section saling berkaitan erat namun bukan merupakan istilah sama.
; Section mengindikasikan section di object file atau executable. Section merupakan
; petunjuk bagi OS untuk memuat (load) komponen penting ke posisi yang sesuai.
; Sementara segment adalah area memori yang tercipta saat runtime dan dipesan
; untuk kebutuhan khusus.
;
; Segmentation dapat diimplementasikan dengan atau tanpa paging.
;-----------------------------------------------------------------------------

    global _start

; Data segment
; Direpresentasikan dengan section .data dan .bss
; Lihat juga contoh deklarasi lainnya di 'declaration'

section .data
    immutable_data: db 10

section .bss 
    mutable_data: resb 1


; Code segment
; Direpresentasikan dengan section .text

section .text
_start:

    hlt         ; Hentikan eksekusi


; Stack segment
; Diciptakan oleh OS dan tidak direpresentasikan oleh section apapun.
; Segment ini berisi data temporer, nilai yang diberikan ke function atau procedure
; pada program.