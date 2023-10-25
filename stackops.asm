section .data
    hello db 'Hello, world!',0
    hello_len equ $ - hello

    hello2 db 'Hello again, world!',0
    hello2_len equ $ - hello2

    var1 dd 0x19283746
    random dd 0


section .text
global _start

_start:
    ; sys_write (stdout, message, length)
    mov eax, 4             ; syscall number for sys_write
    mov ebx, 1             ; file descriptor 1 (stdout)
    mov ecx, hello         ; pointer to the message
    mov edx, hello_len     ; message length
    int 0x80               ; interrupt to invoke syscall

    mov eax, 0x12345678
    push eax
    pop edx
    mov ecx, [var1]
    push ecx
    pop dword [var1]

    ; jump to a random destination

    ; sys_getrandom(buf, size, flags)
    mov eax, 318          ; syscall number for sys_getrandom
    mov edi, random          ; pointer to the buffer where the random number will be stored
    mov esi, 4            ; size of the buffer (4 bytes for a 32-bit random number)
    mov edx, 0            ; flags (0 for no special flags)
    syscall

    mov eax, [random]
    and eax, 1
    je pushfakeend
    pushrealend:
    mov eax, real_end
    jmp afterpush
    pushfakeend:
    mov eax, fake_end
    afterpush:
    push eax
    ret

finally:
    xor eax, eax

fake_end:
    xor ebx, ebx

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