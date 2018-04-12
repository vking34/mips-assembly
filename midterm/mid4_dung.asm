.data

A: .space 100

scanNumberOfArray: .asciiz " Enter number of integer in array: "
scanArrayMess: .asciiz " Enter an array of interger: \n"
scanSmaller: .asciiz " Enter the range. \n+ The first endpoint: "
scanLarger: .asciiz "+ The second enpoint: "
Max: .asciiz "The maximun is: "
Number: .asciiz " The number of integer in the range: "


.text
main:

# t0 -> A
la $t0, A

#input the size of array
li $v0, 51
la $a0, scanNumberOfArray
syscall
xor $a1, $a0, $zero     #a1 = size of Array

#input the array A
li $v0, 4
la $a0, scanArrayMess
syscall

# t1: current point
# s0 / 4: length of A

scanLoop:

li $v0, 5
syscall
add $t1, $t0, $s0
sw $v0, 0($t1)
addi $s7, $s7, 1              #s7, count
addi $s0, $s0, 4              
bne $a1, $s7, scanLoop        #count = size of Array => OUT
nop
 
#input 2 endpoint of the range
endPoint:

li $v0, 51
la $a0, scanSmaller
syscall
xor $s1, $a0, $zero   #s1 = Smaller

li $v0, 51
la $a0, scanLarger
syscall
xor $s2, $a0, $zero   #s2 = Larger

#Find MAX
li $k0, -999999    #k0 = max

loadNext:
beq $t2, $t1, print  #t2 = t1 => end of array
nop
add $t2, $t0, $t3    #t2 = current pointer
addi $t3, $t3, 4
lw $t4, 0($t2)       #t4 = temp value of A[i]

max:
blt $t4, $k0, num   #A[i] < max => num: Find in range
nop
xor $k0, $t4, $zero

num:
ble $t4, $s1, loadNext
nop
bge $t4, $s2, loadNext
nop
addi $s3, $s3, 1
j loadNext
nop

print:

#print max
li $v0, 4
la $a0, Max
syscall
li $v0, 1
xor $a0, $k0, $zero
syscall

#print range
li $v0, 4
la $a0, Number
syscall

li $v0, 1
xor $a0, $s3, $zero
syscall
