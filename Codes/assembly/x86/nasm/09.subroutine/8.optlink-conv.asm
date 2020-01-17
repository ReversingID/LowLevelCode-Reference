;   optlink-conv.asm
;
;   Fungsi dengan Optlink calling convention
;
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o optlink-conv.o optlink-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o optlink-conv.o optlink-conv.asm
;
; Link:
;   $ gcc -m32 -o optlink-conv optlink.o
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

; Optilink digunakan oleh compiler IBM VisualAge.
;
; Di optlink calling convention,
;   - tiga argumen awal akan disimpan di register, selebihnya akan disimpan ke stack
;     dengan urutan kanan-ke-kiri.
;   - pengembalian nilai bilangan bulat dengan meletakkan di register EAX atau ST0
;   - register EBP, EBX, ESI, dan EDI dipertahankan oleh Caller.
;   - Caller bertanggung jawab membersihkan stack.

section .text
_start:

    ; Argumen disimpan di register.
    ; Register paling umum yang digunakan adalah EAX, EDX, dan ECX untuk menyimpan
    ; arg1, arg2, dan arg3. Selebihnya (arg4 dst) akan disimpan di stack.
    ; Dalam kasus ini, urutan push ke stack perlu diperhatikan.

    ; Empat argumen dengan tipe floating point akan disimpan di ST0 hingga ST3

    push    4           ; arg4
    mov     ecx, 3      ; arg3
    mov     edx, 2      ; arg2
    mov     eax, 1      ; arg1

    call    func_optlink

    ; Caller bertanggung jawab membersihkan stack setelah pemanggilan fungsi.
    add     esp, 4      ; karena terjadi push 4 byte

    ; Pembersihan stack dapat dilakukan setiap kali selesai memanggil fungsi atau
    ; dilakukan menjelang akhir eksekusi fungsi caller.

    hlt         ; Hentikan eksekusi


;-----------------------------------------------------------------------------

; Deklarasi fungsi dengan Optlink.
;
; func_optlink(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_optlink:

    ; Function Prologue
    push    ebp
    mov     ebp, esp 

    ; Function Body
    mov     eax, edx                ; arg1 += arg2
    mov     eax, ecx                ; arg1 += arg3
    mov     eax, dword [ebp + 8]    ; arg1 += arg4

    ; Function Epilogue
    pop     ebp 

    ret