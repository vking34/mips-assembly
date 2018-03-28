li	$s2,3
li	$s1,5
start:
slt	$t0,$s2,$s1
bne	$t0,$zero,else
nop
addi	$t1,$t1,1
addi	$t3,$zero,1
j	endif
else:
addi	$t2,$t2,-1
add	$t3,$t3,$t3
endif: