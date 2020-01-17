;   arithmetic.asm
;
;   Operasi pada register SIMD.
;   Operasi aritmetik secara paralel.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o arithmetic.o arithmetic.asm
;
;   (win32)
;   $ nasm -f win32 -o arithmetic.o arithmetic.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o arithmetic arithmetic.o
;
;   (windows)
;   $ ld -m i386pe -o arithmetic arithmetic.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

; Terdapat 8 register MMX 64-bit:
;   MM0, MM1, MM2, MM3, MM4, MM5, MM6, MM7

    global _start

section .data 
    dblock  dd 0xCAFE, 0xBABE
    qblock  dq 0xCAFEBABE, 0x13510030


section .text 
_start:
    mov         eax, dword [dblock]
    mov         ebx, dword [dblock]

; Addition

    ; paddx     mm, mm/m64
    ; tambahkan packed integers
    paddb       mm0, mm1                ; 8-bit / byte
    paddb       mm0, qword [qblock]
    paddw       mm0, mm1                ; 16-bit / word
    paddw       mm0, qword [qblock]
    paddd       mm0, mm1                ; 32-bit / double word
    paddd       mm0, qword [qblock]
    paddq       mm0, mm1                ; 64-bit / quad word
    paddq       mm0, qword [qblock]

    ; paddsx    mm, mm/m64
    ; tambahkan packed signed integers dan saturasi hasilnya
    paddsb      mm0, mm1                ; 8-bit / byte
    paddsb      mm0, qword [qblock]
    paddsw      mm0, mm1                ; 16-bit / word
    paddsw      mm0, qword [qblock]

    ; paddusx   mm, mm/mem64
    ; tambahkan packed unsigned integers dan saturasi hasilnya
    paddusb     mm0, mm1                ; 8-bit / byte
    paddusb     mm0, qword [qblock]
    paddusw     mm0, mm1                ; 16-bit / word
    paddusw     mm0, qword [qblock]


; Subtraction

    ; psubx     mm, mm/m64
    ; kurangkan packed integers
    psubb       mm0, mm1                ; 8-bit / byte
    psubb       mm0, qword [qblock]
    psubw       mm0, mm1                ; 16-bit / word
    psubw       mm0, qword [qblock]
    psubd       mm0, mm1                ; 32-bit / double word
    psubd       mm0, qword [qblock]
    psubq       mm0, mm1                ; 64-bit / quad word
    psubq       mm0, qword [qblock]

    ; psubsx    mm, mm/m64
    ; kurangkan packed signed integers dan saturasi hasilnya
    psubsb      mm0, mm1                ; 8-bit / byte
    psubsb      mm0, qword [qblock]
    psubsw      mm0, mm1                ; 16-bit / word
    psubsw      mm0, qword [qblock]

    ; psubusx   mm, mm
    ; kurangkan packed unsigned integers dan saturasi hasilnya
    psubusb     mm0, mm1                ; 8-bit / byte
    psubusb     mm0, qword [qblock]
    psubusw     mm0, mm1                ; 16-bit / word
    psubusw     mm0, qword [qblock]


; Multiplication

    ; pmadwd    mm, mm/m64
    ; kalikan packed words, tambahkan doubleword yang bertetangga sebagai hasil
    pmaddwd     mm1, mm0 
    pmaddwd     mm1, qword [qblock] 

    ; pmulhw    mm, mm/m64
    ; kalikan packed signed words integers, simpan 16-bits bagian atas dari hasil
    pmulhw      mm1, mm0 
    pmulhw      mm1, qword [qblock] 

    ; pmullw    mm, mm/m64
    ; kalikan packed signed words integers, simpan 16-bits bagian bawah dari hasil
    pmullw      mm1, mm0 
    pmullw      mm1, qword [qblock] 



    hlt         ; Hentikan eksekusi