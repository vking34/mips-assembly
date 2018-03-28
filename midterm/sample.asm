.data:

scanMess: .asciiz "Enter the number of rows: "
spaces: .asciiz "  "
space: .asciiz " "
newLine: .asciiz "\n"

.text:

# scanf the highth of the triangle
li $v0, 4
la $a0, scanMess
syscall

li $v0, 5
syscall

xor $s0, $v0, $zero		# h = s0

#li $v0, 1
#xor $a0, $s0, $zero
#syscall

#li $v0, 4
#la $a0, newLine
#syscall

# for(i=1; i<=h; i++)

addiu $t0, $zero, 1		# i = t0 = 1

mainLoop:	

# for(j=0; j<h-i; j++)
sub $s1, $s0, $t0		# s1 = h-i
beqz $s1, increasing
addiu $t1, $zero, 1		# j = t1 = 1

spaceLoop:	

li $v0, 4
la $a0, spaces
syscall
blt $t1, $s1, spaceLoop		# j < h-i
addi $t1, $t1, 1		# j++

# for(k=1;k<=i;k++)
increasing:
addiu $t2, $zero, 1		# k = t2 = 1

increasingLoop:
li $v0, 1
xor $a0, $t2, $zero
syscall
li $v0, 4
la $a0, space
syscall 
bgt $t0, $t2, increasingLoop	# k <= i
addi $t2, $t2, 1		# k++

# for(k=i-1; k>0;k--)
addi $t2, $t2, -2		# k = t2 = i-1
beqz $t2, newline

decreasingLoop:

li $v0, 1
xor $a0, $t2, $zero
syscall
li $v0, 4
la $a0, space
syscall
bgt $t2, 1, decreasingLoop
addi $t2, $t2, -1

#printf("\n")
newline:
li $v0, 4
la $a0, newLine
syscall

bgt $s0, $t0, mainLoop		# i <= h
addi $t0, $t0, 1		# i++ 

exit:
li $v0, 10
syscall
