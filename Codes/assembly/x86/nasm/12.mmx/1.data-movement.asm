;   data-movement.asm
;
;   Operasi pada register SIMD.
;   Move data dari dan ke memory.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o data-movement.o data-movement.asm
;
;   (win32)
;   $ nasm -f win32 -o data-movement.o data-movement.asm
;
; Link:
;   (linux)
;   $ ld -m elf_i386 -o data-movement data-movement.o
;
;   (windows)
;   $ ld -m i386pe -o data-movement data-movement.o
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

; Move
; Operasi yang mungkin:
;   - MMX registers              ->   MMX registers
;   - general-purpose registers  ->   MMX registers
;   - MMX registers              ->   general-purpose registers
;   - memory                     ->   MMX registers
;   - MMX registers              ->   memory
;
; Tidak ada instruksi khusus untuk mengisi MMX register dengan immediate value.
; Opsi yang tersedia adalah mengisi General Purpose Register atau memory dengan
; immediate value kemudian memindahkannya ke MMX register.

    ; movd      mm, r/m32
    movd        mm0, eax
    movd        mm0, dword [dblock]
    ; movd      r/m32, mm
    movd        ebx, mm0  
    movd        dword [dblock], mm0 

    ; movq      mm, mm/r/m64
    movq        mm1, mm0 
    movq        mm1, rax    ; not supported in 32-bit CPU
    movq        mm1, qword [qblock]
    ; movq      r/m64, mm
    movq        rbx, mm1    ; not supported in 32-bit CPU
    movq        qword [qblock], mm0 


; Pack
; pack (membungkus) 128-bit word atau double-word menjadi 64-bit dengan memangkas
; paruh atas (top half) setiap unit dengan signed atau unsigned saturation.

    ; packssdw  mm1, mm2/m64
    ; pack double-words to words (signed with saturation)
    packssdw    mm1, mm0
    packssdw    mm1, qword [qblock]

    ; packssdb  mm1, mm2/m64
    ; pack words to byte (signed with saturation)
    packsswb    mm1, mm0 
    packsswb    mm1, qword [qblock]

    ; packuswb  mm1, mm2/m64
    ; pack words to byte (unsigned with saturation)
    packuswb    mm1, mm0
    packuswb    mm1, qword [qblock] 


; Unpack
; unpack (membongkar) 64-bit menjadi 128-bit word atau double-word ke paruh-atas
; ataupun paruh-bawa dari register tujuan.

    ; punpckhbw mm, mm/m64
    ; unpack and interleave high-order bytes
    punpckhbw   mm1, mm0
    punpckhbw   mm1, qword [qblock] 
    
    ; punpckhwd mm, mm/m64
    ; unpack and interleave high-order words
    punpckhwd   mm1, mm0
    punpckhwd   mm1, qword [qblock] 
    
    ; punpckhdq mm, m/m64
    ; unpack and interleave high-order double-words
    punpckhdq   mm1, mm0    
    punpckhdq   mm1, qword [qblock] 
    
    ; punpcklbw mm, mm/m32
    ; unpack and interleave low-order bytes
    punpcklbw   mm1, mm0
    punpcklbw   mm1, qword [qblock] 
    
    ; punpcklwd mm, mm/m32
    ; unpack and interleave low-order words
    punpcklwd   mm1, mm0
    punpcklwd   mm1, qword [qblock] 
    
    ; punpckldq mm, mm/m32
    ; unpack and interleave low-order double-words
    punpckldq   mm1, mm0
    punpckldq   mm1, qword [qblock] 


; Insertion
; menyisipkan ke lokasi tertentu di grup
    pinsrw      mm0, 
    pinsrq      mm0, 

; Clear MMX
    emms        ; clear / empty MMX state.