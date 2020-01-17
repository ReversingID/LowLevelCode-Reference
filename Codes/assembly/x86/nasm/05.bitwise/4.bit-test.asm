;   bit-test.asm
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o bit-test.o bit-test.asm
;
;   (win32)
;   $ nasm -f win32 -o bit-test.o bit-test.asm
;
; Link:
;   $ gcc -m32 -o bit-test bit-test.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Bit Test
; Serangkaian instruksi yang menguji nilai dari bit (set/clear - aktif/nonaktif).
; Hasil operasi akan mengubah EFLAGS, mengubah nilai CF menjadi nilai bit yang
; dituju.

section .bss
    wblock  resw    1
    dblock  resd    1
    qblock  resq    1

section .text
_start:

; BT (Bit Test)
    ; bt reg, imm
    bt       bx, 1                      ; 16-bit
    bt      ebx, 2                      ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bt      rbx, 3                      ; 32-bit
    
    ; bt reg, reg
    bt       bx, ax                     ; 16-bit
    bt      ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bt      rbx, rax                    ; 32-bit
    
    ; bt mem, imm
    bt      word  [wblock],   1         ; 16-bit
    bt      dword [dblock],   2         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bt      qword [qblock],   3         ; 64-bit
    
    ; bt mem, reg
    bt      word  [wblock],    ax       ; 16-bit
    bt      dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bt      qword [qblock],   rax       ; 64-bit

; BTS (Bit Test and Set)
    ; Lakukan pemeriksaan bit di lokasi tertentu kemudian aktifkan (set) bit
    ; bts reg, imm
    bts      bx, 1                      ; 16-bit
    bts     ebx, 2                      ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bts     rbx, 3                      ; 32-bit
    
    ; bts eg, reg
    bts      bx, ax                     ; 16-bit
    bts     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bts     rbx, rax                    ; 32-bit
    
    ; bts em, imm
    bts     word  [wblock],   1         ; 16-bit
    bts     dword [dblock],   2         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bts     qword [qblock],   3         ; 64-bit
    
    ; bts em, reg
    bts     word  [wblock],    ax       ; 16-bit
    bts     dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    bts     qword [qblock],   rax       ; 64-bit


; BTR (Bit Test and Reset)
    ; Lakukan pemeriksaan bit di lokasi tertentu kemudian reset bit
    ; btr reg, imm
    btr      bx, 1                      ; 16-bit
    btr     ebx, 2                      ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    btr     rbx, 3                      ; 32-bit
    
    ; btr reg, reg
    btr      bx, ax                     ; 16-bit
    btr     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    btr     rbx, rax                    ; 32-bit
    
    ; btr mem, imm
    btr     word  [wblock],   1         ; 16-bit
    btr     dword [dblock],   2         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    btr     qword [qblock],   3         ; 64-bit
    
    ; btr mem, reg
    btr     word  [wblock],    ax       ; 16-bit
    btr     dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    btr     qword [qblock],   rax       ; 64-bit
    

; BTC (Bit Test and Complement)
    ; Lakukan pemeriksaan bit di lokasi tertentu kemudian komplemen (kebalikan
    ; dari nilai bit)
    ; btc reg, imm
    btc      bx, 1                      ; 16-bit
    btc     ebx, 2                      ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    btc     rbx, 3                      ; 32-bit
    
    ; btc reg, reg
    btc      bx, ax                     ; 16-bit
    btc     ebx, eax                    ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    btc     rbx, rax                    ; 32-bit
    
    ; btc mem, imm
    btc     word  [wblock],   1         ; 16-bit
    btc     dword [dblock],   2         ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    btc     qword [qblock],   3         ; 64-bit
    
    ; btc mem, reg
    btc     word  [wblock],    ax       ; 16-bit
    btc     dword [dblock],   eax       ; 32-bit
    ; error jika dieksekusi pada program 32-bit
    btc     qword [qblock],   rax       ; 64-bit



    hlt         ; Hentikan eksekusi