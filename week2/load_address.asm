.data
X :	.word	
Y : 	.word

.text
la 	$t8, X
nop
li 	$t9, 0x10010000

lw 	$t1, 0($t8)
