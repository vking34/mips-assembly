.data
newline: .asciiz "\n"



.text

addi $s1, $0, 1
add $s2, $s0, $s0
addi $t0, $s0, 1024
addi $s3, $0, 2



loop:
beq $s1, $t0, break
nop
mul $s1, $s1, $s3
addi $s2, $s2, 2

xor $v0, $0, 1
xor $a0, $0, $s1
syscall

xor $v0, $0, 4
la $a0, newline
syscall

j loop
nop
break: