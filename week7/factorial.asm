.data:
Message: .asciiz "Ket qua tinh giai thua la: "

.text:
main:

addi $a0, $zero, 6
jal WARP
nop
print:
add $a1, $v0, $zero
li $v0, 56
la $a0, Message
syscall

quit:
li $v0, 10
syscall

WARP:
sw $fp,-4($sp)
addi $fp,$sp,0
addi $sp,$sp,-8
sw $ra, 0($sp)

li $a0,6
jal FACT
nop
lw $ra,0($sp)
addi $ra,$sp,0
lw $fp, -4($sp)
jr $ra
nop
WRAP_end:

FACT:
sw $fp,-4($sp)
addi $fp, $sp,0
addi $sp, $sp, -12
sw $ra,4($sp)
sw $a0,0($sp)

slti $t0,$a0,2
beq $t0,$zero, recursive
nop
li $v0,1
j done
nop

recursive:
addi $a0, $a0,-1
jal FACT
nop
lw $v1, 0($sp)
mult $v1,$v0
mflo $v0

done:
lw $ra, 4($sp)
lw $a0,0($sp)
addi $sp,$fp,0
lw $fp,-4($sp)
jr $ra

FACT_end: