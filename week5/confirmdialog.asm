.data
message: .asciiz "Do you love me?"
.text
li $v0,50
la $a0,message
syscall