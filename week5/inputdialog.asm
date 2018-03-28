.data
message: .asciiz "Enter an integer:"
.text
li $v0,51
la $a0,message
syscall