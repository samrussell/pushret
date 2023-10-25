section .data
    hello db 'Hello, world!',0
    hello_len equ $ - hello

    hello2 db 'Hello again, world!',0
    hello2_len equ $ - hello2


section .text
global _start

_start:
    ; sys_write (stdout, message, length)
    mov eax, 4             ; syscall number for sys_write
    mov ebx, 1             ; file descriptor 1 (stdout)
    mov ecx, hello         ; pointer to the message
    mov edx, hello_len     ; message length
    int 0x80               ; interrupt to invoke syscall

    push real_end
    ret

finally:
    xor eax, eax

real_end:
    ; sys_write (stdout, message, length)
    mov eax, 4             ; syscall number for sys_write
    mov ebx, 1             ; file descriptor 1 (stdout)
    mov ecx, hello2         ; pointer to the message
    mov edx, hello2_len     ; message length
    int 0x80               ; interrupt to invoke syscall

    ; sys_exit(status)
    mov eax, 1             ; syscall number for sys_exit
    xor ebx, ebx           ; exit status 0
    int 0x80               ; interrupt to invoke syscall