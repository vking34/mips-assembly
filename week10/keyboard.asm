.eqv KEY_CODE	0xFFFF0004
.eqv KEY_READY	0xFFFF0000
.eqv DISPLAY_CODE	0xFFFF000C
.eqv DISPLAY_READY	0xFFFF0008

.text

li $k0, KEY_CODE
li $k1, KEY_READY

li $s0, DISPLAY_CODE
li $s1, DISPLAY_READY

loop: nop

WaitForKey:
lw $t1, 0($k1)
# $t1 = [$k1] = KEY_READY
beq $t1, $zero, WaitForKey

ReadKey:
lw $t0, 0($k0)

WaitForDis:
lw $t2, 0($s1)
# $t2 = [$s1] = DISPLAY_READY
beq $t2, $zero, WaitForDis

Encrypt:
addi $t0, $t0, 1

ShowKey:
sw $t0, 0($s0)
nop
j loop