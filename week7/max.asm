.text:

main:
li $a0, 2
li $a1, 6
li $a2, 9
jal max
nop
li $v0, 10
syscall


endmain:

max:
add $v0, $a0, $zero
sub $t0, $a1, $v0
bltz $t0, okay
nop
add $v0, $a1, $zero

okay:
sub $t0, $a2, $v0
bltz $t0, done
nop
add $v0, $a2, $zero

done:
jr $ra
nop