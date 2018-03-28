.data
A: .word -2, 6, -1, 3, -2

.text
main:
la $a0,A
li $a1,5
j mspfx
nop

continue:
lock:
j lock
nop

end_of_main:

mspfx:
addi $v0,$zero,0
addi $v1,$zero,0
addi $t0,$zero,0
addi $t1,$zero,0

loop:
add $t2,$t0,$t0
add $t2,$t2,$t2
add $t3,$t2,$a0
lw $t4,0($t3)
add $t1,$t1,$t4
slt $t5,$v1,$t1
bne $t5,$zero,mdfy
j test
nop

mdfy:
addi $v0,$t0,1
addi $v1,$t1,0

test:
addi $t0,$t0,1
slt $t5,$t0,$a1
bne $t5,$zero,loop
nop

done:

#j continue
#nop

mspfx_end: