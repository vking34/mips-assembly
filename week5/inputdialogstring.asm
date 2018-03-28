.data
message: .asciiz "Enter a string:"
string: .space 100
.text
li $v0,54
la $a0,message
la $a1,string
la $a2,100
syscall
li $v0,4
la $a0,string
syscall