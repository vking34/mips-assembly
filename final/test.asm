.data

scanMess: .asciiz "Enter a number: "

.text

addi $t1, $t1, 4

li $v0, 4
la $a0, scanMess
syscall

li $v0, 5
syscall

xor $t7, $v0, $0	# t7 = v0

checkAddressable:
div $t7, $t1
mfhi $t0
beq $t0, $0, update_SysTheTopOfFree
beq $t0, 1, add_3
beq $t0, 2, add_2
beq $t0, 3, add_1
nop

add_3:
addi $t7, $t7, 3
j update_SysTheTopOfFree
nop
add_2:
addi $t7, $t7, 2
j update_SysTheTopOfFree
nop
add_1:
addi $t7, $t7, 1

update_SysTheTopOfFree:

addi $v0, $0, 1
xor $a0, $t7, $0
syscall


