; 5. Design and develop an assembly language program to read the current time and Date from the
; system and display it in the standard format on the screen.

.model small
.stack
.data
        exit macro
            mov ah, 4ch
            int 21h
            endm

        disp macro
            mov ah, 02h
            int 21h
            endm

        disps macro msg
            mov ah, 09h
            lea dx, msg
            int 21h
            endm

        getTime macro
            mov ah, 2ch
            int 21h
            endm

        getDate macro
            mov ah, 2ah
            int 21h
            endm

        msg1 db "Current Time is: $"
        msg2 db "Current Date is: $"

.code
        mov ax, @data
        mov ds, ax
        disps msg1
        getTime
        
        mov al, ch
        call display
        
        mov dl, ':'
        disp
        
        mov al, cl
        call display
        
        mov dl, ':'
        disp

        mov al, dh
        call display

        disps msg2
        getDate

        mov al, dl
        call display

        mov dl, '/'
        disp

        mov al, dh
        call display

        mov dl, '/'
        disp

        mov ax, cx
        mov cx, 0
        mov dx, 0
        mov bx, 10

return:
        div bx
        push dx
        inc cx
        mov dx, 00
        cmp ax, 0
        jne return

back:
        pop dx
        add dl, 30h
        disp
        loop back
        exit

        display proc
            AAM
            add ax, 3030h
            mov bx, ax
            mov dl, bh
            disp
            mov dl, bl
            disp
            ret
        display endp
end