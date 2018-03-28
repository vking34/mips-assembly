.data
message:	.asciiz "VKing34 \nHello baby!"
.text
li	$v0,4
la	$a0, message
syscall