;   args.asm
;
;   Fungsi dan argumen.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o args.o args.asm
;
;   (win32)
;   $ nasm -f win32 -o args.o args.asm
;
; Link:
;   $ gcc -m32 -o args args.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Argumen fungsi adalah sejumlah data (tipe dasar maupun tipe bentukan) yang
; dilewatkan ke fungsi. Umumnya fungsi akan memproses argumen dan mengembalikan 
; nilai tertentu.
; Jumlah dan tipe argumen yang diberikan ke fungsi telah ditentukan sebelumnya.

; Umumnya argumen fungsi adalah serangkaian data yang diletakkan di stack, 
; dapat diakses oleh fungsi saat runtime. 


section .text
_start:

    ; Argumen diberikan ke fungsi dengan cara melakukan push dengan urutan tertentu.
    ; Dalam kasus ini, argumen di-push dalam urutan kanan-ke-kiri atau dari argumen
    ; terakhir ke argumen pertama.
    
    ; Jika, pemanggilan sebuah fungsi berbentuk seperti ini:
    ;       f (arg1, arg2, arg3, arg4)
    ; 
    ; maka argumen akan diberikan dengan urutan sebagai berikut:
    ;       arg4, arg3, arg2, arg1
    
    push    4
    push    3
    push    2
    push    1

    ; Hal ini mengakibatkan stack akan memiliki layout sebagai berikut sebelum pemanggilan.
    ;
    ;      ESP                                      EBP
    ;   | arg1 | arg2 | arg3 | arg4 | ... entry lain, tidak dipedulikan |

    call    func_arg4

    hlt         ; Hentikan eksekusi


;-----------------------------------------------------------------------------

; Deklarasi fungsi yang membutuhkan 4 argumen

func_arg4:

    ; Setelah di badan fungsi, layout stack akan menjadi seperti berikut:
    ;
    ;         ESP                                                 EBP
    ;   | Ret Address | arg1 | arg2 | arg3 | arg4 | ... entry lain, tidak dipedulikan |
    ; 
    ; Pada kebanyakan kasus, fungsi akan membangun stack frame baru melalui Function Prologue

    ; Function Prologue ---------------------
    push    ebp 
    mov     ebp, esp

    ; sehingga menyebabkan layout stack menjadi seperti ini:
    ;
    ;     ESP & EBP
    ;   | Saved EBP | Ret Address | arg1 | arg2 | arg3 | arg4 | ... entry lain, tidak dipedulikan |
    ; 
    ; Pada tahap ini, bisa diasumsikan bahwa argumen terletak di bawah EBP.
    

    ; Accessing the arguments ---------------

    ; Cara paling umum untuk mengakses argumen adalah menggunakan EBP.
    ; Jika Function Prologue bekerja, maka argumen pertama akan berada di dua entry
    ; di bawah EBP.

    ; 32-bit program
    mov     eax, dword [ebp +  8]       ; arg1
    mov     ebx, dword [ebp + 12]       ; arg2
    mov     ecx, dword [ebp + 16]       ; arg3
    mov     edx, dword [ebp + 20]       ; arg4

    ; 64-bit program
    mov     rax, qword [rbp + 16]       ; arg1
    mov     rbx, qword [rbp + 24]       ; arg2
    mov     rcx, qword [rbp + 32]       ; arg3
    mov     rdx, qword [rbp + 40]       ; arg4

    ; Jika tidak ada Function Prologue, maka argumen pertama terletak satu entry
    ; di bawah EBP.

    ; 32-bit program
    mov     eax, dword [ebp +  8]       ; arg1
    mov     ebx, dword [ebp + 12]       ; arg2
    mov     ecx, dword [ebp + 16]       ; arg3
    mov     edx, dword [ebp + 20]       ; arg4

    ; 64-bit program
    mov     rax, qword [rbp + 16]       ; arg1
    mov     rbx, qword [rbp + 24]       ; arg2
    mov     rcx, qword [rbp + 32]       ; arg3
    mov     rdx, qword [rbp + 40]       ; arg4

    ; Cara lain mengakses argumen adalah dengan ESP.
    ; Konsepnya serupa, tapi diperlukan kecermatan ekstra untuk menentukan lokasi
    ; tepat karena ESP dapat berubah secara dinamis.

    ; Function Epilogue ---------------------
    pop     ebp 

    ret