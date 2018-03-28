.data
message: .asciiz "xin chao"
.text
li $v0,55
la $a0,message
syscall