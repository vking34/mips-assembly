.data
a1: .asciiz "b1"
a2: .asciiz "b2"

.text

addi $s1, $s1, 1
addi $s2, $s2, 2
addi $s3, $s3, 3

#blt $s1, $s2, b2
#bgt $s1, $s3, b2
#addi $t0, $t0, 1

#j b2
bgt $s3, $s2, b2

b1:
li $v0, 4
la $a0, a1
syscall

b2:
li $v0, 4
la $a0, a2
syscall