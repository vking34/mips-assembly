.data

message1: .asciiz "Enter a string: "
message2: .asciiz "The reverse string: "
string: .space 20
reverse: .space 20

.text

input_string:
li $v0, 4
la $a0, message1
syscall

li $v0, 8
la $a0, string
li $a1, 21
syscall

process_string:

la $s1, string
la $s2, reverse
beqz $s1, print

xor $t0, $zero, $zero

point_to_end:
add $s3, $s1, $t0
lb $a1, 0($s3)
beqz $a1, reverse_copy
addi $t0, $t0, 1
j point_to_end

reverse_copy:

addi $s3, $s3, -1
lb $a1, 0($s3)
beq $a1, 0x0000000a, copy
xor $t0, $zero, $zero
addi $s3, $s3, -1

copy:
add $s4, $t0, $s2
lb $a1, 0($s3)
sb $a1, 0($s4)
beq $s3, $s1, print
addi $s3, $s3, -1
j copy
addi $t0, $t0, 1

print:
#li $v0, 4
#la $a0, message2
#syscall
#li $v0, 4
#la $a0, reverse
#syscall

li $v0, 59
la $a0, message2
la $a1, reverse
syscall