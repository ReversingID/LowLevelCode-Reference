;   hello-win32.asm
; 
; 	Cetak "Hello, World!" kemudian exit.
;   Kode ini menggunakan Windows API.
;
; Assemble:
;	$ nasm -fwin32 hello-win32.asm -o hello-win32.obj
;
; Link:
;   (ms link)
;   $ link /MACHINE:X86 /SUBSYSTEM:CONSOLE /OUT:hello-win32.exe /NODEFAULTLIB /ENTRY:main kernel32.lib hello-win32.obj
;
;   (golink)
;   $ golink /console /entry _main hello-win32.obj kernel32.dll
;
;   (gcc)
;   $ gcc -m32 -o hello-win32.exe hello-win32.obj
;
;-----------------------------------------------------

; // Padanan di C program
; int main()
; {
;   HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
;   WriteFile(hStdOut, message, 13, 0, 0);
;   ExitProcess(0);
; }

    global  _main
    extern  _GetStdHandle@4
    extern  _WriteFile@20
    extern  _ExitProcess@4

section .data
    message db 'Hello, World!', 10
    msglen  equ $ - message
    STD_OUTPUT_HANDLE equ -11


section .text
_main:
    ; DWORD  bytes;    
    mov     ebp, esp
    sub     esp, 4

    ; hStdOut = GetstdHandle( STD_OUTPUT_HANDLE )
    push    STD_OUTPUT_HANDLE
    call    _GetStdHandle@4
    mov     ebx, eax    

    ; WriteFile( hstdOut, message, length(message), &bytes, 0 );
    push    0
    lea     eax, [ebp-4]
    push    eax
    push    msglen
    push    message
    push    ebx
    call    _WriteFile@20

    ; ExitProcess( 0 )
    push    0
    call    _ExitProcess@4

    ; never reach here
    ret