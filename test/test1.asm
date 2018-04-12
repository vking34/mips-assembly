.data

mess: .asciiz "Input integer: "

.text

li $a1, 9

li $v0, 51
la $a0, mess
syscall

and $v0, $v0, $0
nop