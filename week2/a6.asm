.data
x : .word 5
y : .word -1
z : .word

.text
la $t8, x
la $t9, y
lw $t1, 0($t8)
lw $t2, 0($t9)

add $s0, $t1, $t1
add $s0, $s0, $t2

la $t7, z
sw $s0, 0($t7)