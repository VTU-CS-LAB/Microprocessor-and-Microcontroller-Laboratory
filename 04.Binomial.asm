; 4. Develop an assembly language program to compute nCr using recursive procedure. Assume
; that ‘n’ and ‘r’ are non-negative integers.

.model small
.stack
.data
        exit macro
            mov ah, 4ch
            int 21h
            endm

        n dw 5
        r dw 3
        ncr dw 0

.code
        mov ax, @data
        mov ds, ax
        mov ax, n
        mov bx, r
        call ncrp
        exit

        ncrp proc
            cmp ax, bx
            je ret_1
            
            cmp bx, 0
            je ret_1
            
            cmp bx, 1
            je ret_n

            dec ax
            cmp ax, bx
            inc_1

            push ax
            push bx
            call ncrp
            pop bx
            pop ax
            
            dec bx
            call ncrp
            ret

ret_1:
            inc ncr
            ret
inc_1:
            inc ncr
ret_n:
            add ncr, ax
            ret
            ncrp endp
end