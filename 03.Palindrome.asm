; 3. Develop an assembly language program to reverse a given string and verify whether it is a
; palindrome or not. Display the appropriate message.

.model small
.stack
.data
        exit macro
            mov ah, 4ch
            int 21h
            endm

        disp macro msg
            mov ah, 09h
            lea dx, msg
            int 21h
            endm

        str db "madam"
        len equ $-str
        rstr db 10 dup ?

        msg1 db "Palindrome$"
        msg2 db "Not Palindrome$"

.code
        mov ax, @data
        mov ds, ax
        mov es, ax
        mov cx, len
        lea si, str
        lea di, rstr
        add di, cx
        dec di
back:
        mov al, [si]
        mov [di], al
        inc si
        dec di
        loop back

        mov cx, len
        lea si, str
        lea di, rstr

        cld
        repe cmpsb
        jz pal
        disp msg2
        exit
pal:
        disp msg1
        exit
end