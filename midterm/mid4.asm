.data

A: .space 100

scanArrayMess: .asciiz "Enter an array of integers (end with a negative number): \n"
scan2Mess1: .asciiz "Enter 2 endpoints of the range.\n+ The first endpoint: "
scan2Mess2: .asciiz "+ The second endpoint: "
warning: .asciiz "The first endpoint must be less than the second endpoint !!!\nPlease try again.\n"
maxMess: .asciiz "The maximum element: "
numMess: .asciiz "\nThe number of elements in the range of ("
comma: .asciiz ", "
close: .asciiz "): "

.text
main:

# t0 -> A
la $t0, A

# input the array A
li $v0, 4
la $a0, scanArrayMess
syscall

# s0 / 4 : length of A
# t1 : current point
scanLoop:

li $v0, 5
syscall
add $t1, $t0, $s0
sw $v0,0($t1)
bgtz $v0, scanLoop
addi $s0, $s0, 4

# input 2 endpoints of the range
endPoints:

li $v0, 4
la $a0, scan2Mess1
syscall

li $v0, 5
syscall
xor $s1, $v0, $zero			# the first endpoint = s1

li $v0, 4
la $a0, scan2Mess2
syscall

li $v0, 5
syscall
xor $s2, $v0, $zero			# the second endpoint = s2

bgt $s1, $s2, warn			# s1 > s2 -> warning

# t2 / 4 : length of A
# t3 : current point
# t4 : temp
# k0 : max
# s3 : inside elements

add $t3, $t0, $t2
loadNext:
beq $t3, $t1, print			# t3 = t1 -> end of array
lw $t4, 0($t3)				

max:
blt $t4, $k0, num			# temp < max -> num
addi $t2, $t2, 4
xor $k0, $t4, $zero			# max = temp;

num:
ble $t4, $s1, loadNext			# temp <= s1 -> loadNext
add $t3, $t0, $t2
bge $t4, $s2, loadNext			# temp >= s2 -> loadNext
nop
addi $s3, $s3, 1			# num++;
j loadNext

print:

# print max
li $v0, 4
la $a0, maxMess
syscall

li $v0, 1
xor $a0, $k0, $zero
syscall

#print the numbers of elements in the range
li $v0, 4
la $a0, numMess
syscall

li $v0, 1
xor $a0, $s1, $zero
syscall

li $v0, 4
la $a0, comma
syscall

li $v0, 1
xor $a0, $s2, $zero
syscall

li $v0, 4
la $a0, close
syscall

li $v0, 1
xor $a0, $s3, $zero
syscall

exit:

li $v0, 10
syscall

warn:
li $v0, 4
la $a0, warning
syscall
j endPoints
nop