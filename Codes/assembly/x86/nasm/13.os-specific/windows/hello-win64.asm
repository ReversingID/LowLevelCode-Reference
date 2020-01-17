;   hello-win64.asm
; 
; 	Cetak "Hello, World!" kemudian exit.
;   Kode ini menggunakan Windows API.
;
; Assemble:
;	$ nasm -fwin64 -o hello-win64.obj hello-win64.asm
;
; Link:
;   (ms link)
;   $ link /MACHINE:X64 /SUBSYSTEM:CONSOLE /OUT:hello-win64.exe /NODEFAULTLIB /ENTRY:main kernel32.lib hello-win64.obj
;
;   (golink)
;   $ golink /console /entry _main hello-win64.obj kernel32.dll
; 
;   (gcc)
;   $ gcc -o hello-win64.exe hello-win64.obj
;
;-----------------------------------------------------

; // Padanan di C program
; int main()
; {
;   HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
;   WriteFile(hStdOut, message, 13, 0, 0);
;   ExitProcess(0);
; }

    ; bits 64

    global  main
    extern  GetStdHandle
    extern  WriteFile
    extern  ExitProcess

section .data
    message db 'Hello, World!', 13, 10, 0
    msglen  equ $ - message
    STD_OUTPUT_HANDLE equ -11
    hFile   dd 0


section .text
main:
    ; DWORD  bytes;    
    mov     rbp, rsp
    sub     rsp, 30h

    ; hStdOut = GetstdHandle( STD_OUTPUT_HANDLE )
    mov     ecx, STD_OUTPUT_HANDLE
    call    GetStdHandle

    ; WriteFile( hstdOut, message, length(message), &bytes, 0 );
    mov     rcx, rax            ; HANDLE hFile 
    mov     rdx, message        ; LPVOID lpBuffer
    mov     r8d, dword msglen   ; DWORD nNumberOfBytesToWrite
    xor     r9, r9              ; LPDWORD lpNumberOfBytesWritten
    push    qword 0             ; LPOVERLAPPED lpOverlapped
    call    WriteFile

    ; ExitProcess( 0 )
    mov     rcx, 0
    call    ExitProcess

    ; never reach here
    ret