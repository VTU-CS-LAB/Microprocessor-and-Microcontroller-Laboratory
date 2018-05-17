; 6. To write and simulate ARM assembly language programs for data transfer, arithmetic and
; logical operations (Demonstrate with the help of a suitable program).

    area sh, code, readonly
start
    ldr r0, =val1
    ldr r1, [r0]
    ldr r0, =val2
    ldr r2, [r0]
    add r3, r1, r2, lsl #2
    sub r4, r1, r2
    rsb r5, r1, r2
    and r6, r1, r2
    orr r7, r1, r2
    ldr r0, =res
    str r3, [r0]
    nop
    nop
    nop

    area data1, data, readonly
val1 dcd 0xA
val2 dcd 2

    area data2, data, readwrite
res dcd 0x00

    end