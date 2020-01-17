;   declare.asm
;
;   Deklarasi dan implementasi fungsi.
;
; Assemble:
;   (linux)
;   $ nasm -f elf32 -o declare.o declare.asm
;
;   (win32)
;   $ nasm -f win32 -o declare.o declare.asm
;
; Link:
;   $ gcc -m32 -o declare declare.o
;
; Note:
;   Jalankan di lingkungan debugging atau emulator.
; 
;-----------------------------------------------------------------------------

    global _start

; Function (fungsi) adalah blok instruksi yang diidentifikasi dengan nama (label), dan
; menyelesaikan tugas tertentu. Fungsi dapat menerima sejumlah data, memprosesnya, dan
; mengembalikan hasil. Ketika sebuah fungsi didefinisikan, ia dapat dipanggil 
; berkali-kali dari sembarang lokasi.

section .text
_start:
    
    ; Ketika fungsi dipanggil, eksekusi akan ditransfer ke blok tersebut.
    ; Hal ini akan terjadi:
    ;   - Jika fungsi membutuhkan argument, stack (atau register) akan menampung
    ;     argumen
    ;   - Stack mengembang dengan puncak stack menyimpan Return Address
    ;     atau alamat memory yang akan dieksekusi ketika fungsi selesai bertugas.
    ;   - EIP/RIP akan menunjuk alamat memori tempat instruksi pertama fungsi tersebut,
    ;     diindikasikan oleh label

    ; Terdapat beberapa call-convention (perjanjian) yang harus diperhatikan.
    ; Modul ini tidak akan membahas salah satu dari call-convention yang ada.
    ; Lihat masing-masing topik yang ada untuk mempelajari lebih lanjut.
    ;   - cdecl
    ;   - stdcall
    ;   - fastcall
    ;   - thiscall
    ; 
    ; Call-convention membahas tentang cara transfer argumen ke fungsi. Namun di luar 
    ; itu semua, pemanggilan fungsi menggunakan instruksi yang sama.
    
    ; pemanggilan fungsi secara langsung yang diindikasikan dengan label
    call    func_empty 
    call    func_retval 
    call    func_complete

    ; pemanggilan fungsi tak langsung, dengan cara memanggil alamat yang ditunjuk register.
    mov     eax, func_empty 
    call    eax



    hlt         ; Hentikan eksekusi


;-----------------------------------------------------------------------------

; Deklarasi fungsi kosong
; Hanya terdapat satu instruksi yaitu return ke caller.
; Fungsi ini akan seketika mengembalikan eksekusi ke pemanggil.

func_empty:
    ; return to the caller
    ret 


;-----------------------------------------------------------------------------

; Deklarasi fungsi yang mengembalikan nilai
; Fungsi ini mengembalikan bilangan bulat 135

func_retval:

    ; Sebagian besar convention menggunakan EAX untuk menampung nilai kembalian.
    ; Tidak ada larangan untuk menggunakan register lain, meskipun demikian EAX
    ; tetap menjadi alternatif utama.

    mov     eax, 135
    ret 


;-----------------------------------------------------------------------------

; Deklarasi fungsi sempurna dengan prolog dan epilog.

func_complete:

    ; Function Prologue adalah sekelompok instruksi di bagian awal fungsi.
    ; Tujuan prolog ini adalah untuk mempertahankan stack frame sebelumnya,
    ; menciptakan stack frame baru untuk fungsi saat ini, dan mengalokasikan space
    ; jika diperlukan.
    
    ; Lihat pula 'stack.asm'

    push    ebp         ; simpan referensi ke Stack Base sebelumnya
    mov     ebp, esp    ; EBP menunjuk ke alamat yang sama dengan ESP
    sub     esp, 30     ; kembangkan stack frame sesuai kebutuhan.


    ; Function Body
    ; Berikan instruksi di sini ...


    ; Function Epilogue adalah sekelompok instruksi di bagian akhir fungsi (sebelum return).
    ; Tujuan epilog adalah mengembalikan keadaan stack frame seperti semula dengan 
    ; mendealokasikan ruang jika perlu, menghancurkan stack frame saat ini, dan mengembalikan
    ; nilai ESP dan EBP.
    
    add     esp, 30     ; menyusutkan stack frame
    pop     ebp         ; mendapatkan nilai lama EBP

    ret 