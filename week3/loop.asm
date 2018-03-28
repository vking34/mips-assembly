.data
A : 2,3,5,4,1

.text
li 	$s3,4
li	$s1,0
li	$s4,1
la	$s2,A
lw	$s5,A
nop


add	$s1,$s1,$s4
add	$t1,$s1,$s1
add 	$t1,$t1,$t1
add 	$t1,$t1,$s2
lw	$t0,0($t1)
add	$s5,$s5,$t0
bne	$s1,$s3,loop

loop:
add	$s1,$s1,$s4
add	$t1,$s1,$s1
add 	$t1,$t1,$t1
add 	$t1,$t1,$s2
lw	$t0,0($t1)
add	$s5,$s5,$t0
bne	$s1,$s3,loop
