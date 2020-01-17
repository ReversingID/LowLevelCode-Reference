;   jump-table.asm
;
;   Percabangan ke beragam alternatif berbeda berdasarkan Jump Table.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o jump-table.o jump-table.asm
;
;   (win32)
;   $ nasm -f win32 -o jump-table.o jump-table.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o jump-table jump-table.o
;
;   (windows)
;   $ ld -m i386pe -o jump-table jump-table.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start
 
; Branching (percabangan) adalah perpindahan eksekusi ke sekumpulan instruksi
; berbeda menggunakan satu atau lebih instruksi Jump.

; Instruksi percabangan dapat berupa Unconditional Jump (selalu berpindah)
; ataupun Conditional Jump (mungkin berpindah). Satu atau lebih instruksi Jump
; dapat dikombinasikan untuk mengevaluasi kondisi yang kompleks dan memastikan
; apakah block instruksi akan dieksekusi atau tidak.
;
; Tujuan:
;   Implementasi "Jump Table" atau "switch-case" di beberapa bahasa pemrograman.
;   Percabangan dengan beragam kondisi alternatif berdasarkan nilai.
;   Jump Table digunakan untuk menentukan blok target yang akan dieksekusi
;   ketika lompat.
;
; Bentuk umum:
;     switch (variable)
;     {
;         case val_1: do_action_1; break;
;         case val_2: do_action_2; break;
;         ...
;         default: do_alternative_action;
;     }
;
;
;     switch:  tes nilai variabel
;     case:    label lokasi dari target, bergantung dari nilai variabel.
;     break:   lompat ke akhir blok "switch"
;     default: aksi alternatif secara umum ketika tidak ada nilai terpenuhi.
;
; Padanan:
;     - untuk setiap statement break sepadan dengan Unconditional Jump ke akhir struktur.
;     - sebuah tabel menyimpan lokasi (absolut / relatif) dari label.

section .data
    var  dd 0

section .text

_start:

;-----------------------------------------------------------------------------
; One Layer Jump-Table

; Karakteristik:
; Label merupakan rangkaian nilai yang terurut atau memiliki gap yang minimum.

    ; switc(var)
    ; {
    ;     case 1: do_action_1; break;
    ;     case 2: do_action_2; break;
    ;     default: do_default_action;
    ; }

    mov     eax, dword [var]    ; isi nilai var ke EAX

    ; untuk efisiensi, tabel dimulai dari 0 sehingga
    ;   - index 0 akan mengarah ke alternatif pertama
    ;   - index 1 akan mengarah ke alternatif kedua

    ; periksa apakah nilai var melebihi 2.
    ; nilai 2 adalah nilai terendah yang berada di atas batas nilai tertinggi case.
    sub     eax, 1
    cmp     eax, 2
    jge     .default            ; menuju aksi default 

    ; lompat sesuai tabel
    ; tabel dapat dideklarsikan secara internal dalam fungsi, ataupun secara global
    jmp     dword [.table + eax * 4]

.action1:
    ; eksekusi aksi 1
    jmp     .end                ; lompat ke akhir switch

.action2:
    ; eksekusi aksi 2
    jmp     .end                ; lompat ke akhir switch

.default:
    ; eksekusi do_default_action ketika tidak ada kondisi terpenuhi
    ; jika default tak didefinisikan, maka switch dapat melompat ke .end
    jmp     .end 

    ; deklarasi tabel di dalam fungsi
.table:
    dd      .action1            ; asumsi panjang alamat memiliki alignment 4 byte
    dd      .action2 

.end:
    ; instruksi ini akan dieksekusi terlepas dari hasil percabangan.


    hlt         ; Hentikan eksekusi
