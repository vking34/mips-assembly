.data

# pointer
CharPtr: .word 0
BytePtr: .word 0
WordPtr: .word 0
secondCharPtr: .word 0
ArrayPtr: .word 0

# mgs

Menu: .asciiz "\n-----------------------------------------------------------\n--------------------------MENU-----------------------------\n-----------------------------------------------------------\n 1. Malloc then Check Value (*CharPtr, *BytePtr, *WordPtr)\n 2. Check addresses of pointers\n 3. Copy 2 CharPtrs\n 4. Show the total size of allocated space\n 5. Malloc a 2D Array\n 0. Quit\nChoose one option: "
segFaultMess: .asciiz "\nSegmentation Fault\n"

# opt1
CharSizeScanMess: .asciiz "\nEnter size for CharPtr: "
InputMess: .asciiz "Enter element "
colon: .asciiz ": "
ScanStringMess: .asciiz "Enter a string for CharPtr: "
PrintElementChar: .asciiz "\nPrint the element (enter -1 to exit): "

#
ByteSizeScanMess: .asciiz "\nSize for BytePtr: "
ByteScanMess: .asciiz "*BytePtr = "
ByteResult: .asciiz "\nResult: *BytePtr = "

#
WordSizeScanMess: .asciiz "\n\nSize for WordPtr: "
WordScanMess: .asciiz "Enter a string for WordPtr: "
WordResult: .asciiz "\nResult (*WordPtr): "

# opt2
CharPtrAddress: .asciiz "\n&CharPtr = "
BytePtrAddress: .asciiz "\n&BytePtr = "
WordPtrAddress: .asciiz "\n&WordPtr = "

# opt3

secondCharSizeScanMess: .asciiz "\nEnter size of the 2ndCharPtr: "
copyResult: .asciiz "Result (*2nCharPtr): "

# opt4
allocatedSizeMess: .asciiz "\nThe total size of allocated space: "
bytes: .asciiz " (bytes)\n"

# opt5
ArrayMenu: .asciiz "\n-----------------------\n 1. set Array[i][j]\n 2. get Array[i][j]\n 0. Quit\nChoose one option: "
ArraySizeScanMess: .asciiz "(Word) Array[x][y]:\n x = "
yScanMess: .asciiz " y = "
xScanMess: .asciiz " x = "
valueScanMess: .asciiz " value = "


.kdata

Sys_TheTopOfFree: .word 1	# value is the address of Sys_MyFreeSpace
Sys_MyFreeSpace: .word		# used to malloc a pointer starting from Sys_MyFreeSpace address

.text

main:
addi $k0, $0, 4 		# k0 = 4 for checking Adddressalbe
addi $k1, $0, -1		# final static k1 = -1;

jal SysInitMem
nop


menu:

addi $v0, $0, 4
la $a0, Menu
syscall

addi $v0, $0, 5
syscall

beq $v0, 1, opt1
beq $v0, 2, opt2
beq $v0, 3, opt3
beq $v0, 4, opt4
beq $v0, 5, opt5
beq $v0, $0, exit

opt1:
# Scan size for CharPtr
addi $v0, $0, 4
la $a0, CharSizeScanMess
syscall

addi $v0, $0, 5
syscall				# return value passing in v0
xor $a1, $v0, $0		# a1 = v0
xor $s7, $v0, $0		# s7 = Size of CharPtr (for opt3)

CharMalloc:
la $a0, CharPtr			
addi $a2, $0, 1
jal malloc
nop
xor $s0, $v0, $0		# return v0 = address of pointer

# Scan a string using CharPtr
addi $v0, $0, 4
la $a0, ScanStringMess
syscall

addi $a1, $a1, 1		# a1 = a1 + 1 (max char = Size of CharPtr +1,cause the last byte would be null byte 
				# if the number of input chars + 1 = max char)
addi $v0, $0, 8
xor $a0, $s0, $0		# a0 = s0
syscall

# Print elements of the Char pointer
PrintCharELement:
addi $v0, $0, 4
la $a0, PrintElementChar
syscall

addi $v0, $0, 5
syscall				# return value passing in v0

beq $v0, $k1, ByteMalloc	# v0 = -1 => break;

xor $a1, $v0, $0		# a1 = Element Order
la $a0, CharPtr
jal getByteElement

addi $v0, $0, 11
xor $a0, $v1, $0		# a0 = v1 (returned)
syscall
j PrintCharELement

# Scan size for BytePtr
ByteMalloc:
addi $v0, $0, 4
la $a0, ByteSizeScanMess
syscall

addi $v0, $0, 5
syscall				# return value passing in v0

xor $a1, $v0, $0		# a1 = v0
la $a0, BytePtr			
addi $a2, $0, 1
jal malloc
nop
xor $s0, $v0, $0		# return v0 = address of pointer

# scan a number

addi $v0, $0, 4
la $a0, ByteScanMess
syscall

addi $v0, $0, 5
#addi $v0, $0, 12
syscall

la $a0, BytePtr
and $a1, $0, $0
xor $a2, $v0, $0
jal assignByteValue		# *BytePtr = a2;
nop

la $a0, BytePtr
and $a1, $0, $0
jal getByteElement		# get *BytePtr

# print result
addi $v0, $0, 4
la $a0, ByteResult
syscall

addi $v0, $0, 1
xor $a0, $v1, $0
syscall

WordMalloc:

# scan size
addi $v0, $0, 4
la $a0, WordSizeScanMess
syscall

addi $v0, $0, 5
syscall

la $a0, WordPtr			# a0 = WordPtr
xor $a1, $v0, $0		# a1 = Size
addi $a2, $0, 4			# sizeof(word) = 4
jal malloc
nop
xor $s0, $v0, $0		# return v0 = address of pointer

# scan string
addi $v0, $0, 4
la $a0, WordScanMess
syscall

addi $v0, $0, 8
xor $a0, $s0, $0		# a0 = s0
mul $a1, $a1, $a2		
sub $a1, $a1, 1			# let the last byte be null in order to print the string
syscall

addi $v0, $0, 4
la $a0, WordResult
syscall

addi $v0, $0, 4
xor $a0, $s0, $0
syscall

j menu

opt2:	# Show pointer addresses

# &CharPtr
addi $v0, $0, 4
la $a0, CharPtrAddress
syscall

jal getCharPtrAddress
addi $v0, $0, 34
xor $a0, $v1, $0
syscall

# &BytePtr
addi $v0, $0, 4
la $a0, BytePtrAddress
syscall

jal getBytePtrAddress
addi $v0, $0, 34
xor $a0, $v1, $0
syscall

# &WordPtr
addi $v0, $0, 4
la $a0, WordPtrAddress
syscall

jal getWordPtrAddress
addi $v0, $0, 34
xor $a0, $v1, $0
syscall

j menu

opt3:	# Copy 2 CharPtrs

# Scan Size of 2ndCharPtr
addi $v0, $0, 4
la $a0, secondCharSizeScanMess
syscall

addi $v0, $0, 5
syscall

la $a0, secondCharPtr
xor $a1, $v0, $0		# a1 = size2;
add $a2, $0, 1
jal malloc
nop

slt $t0, $a1, $s7		
bne $t0, $0, lessThan		# if size2 < size1, lengthOfCopy = Size2 else lengthOfCopy = Size1
xor $a2, $s7, $0
la $a1, CharPtr
nop
jal copy
nop
j print2ndCharPtr

lessThan:
xor $a2, $a1, $0
la $a1, CharPtr
nop
jal copy

print2ndCharPtr:

addi $v0, $0, 4
la $a0, copyResult
syscall

la $t0, secondCharPtr
lw $a0, 0($t0)
syscall

j menu

opt4:	# Check Allocated Size

addi $v0, $0, 4
la $a0, allocatedSizeMess
syscall

jal allocatedSize
addi $v0, $0, 1
xor $a0, $v1, $0
syscall

addi $v0, $0, 4
la $a0, bytes
syscall

j menu

opt5:	# Malloc a 2D array

addi $v0, $0, 4
la $a0, ArraySizeScanMess
syscall

addi $v0, $0, 5
syscall
xor $s4, $v0, $0		# t0 = x

addi $v0, $0, 4
la $a0, yScanMess
syscall

addi $v0, $0, 5
syscall
xor $s5, $v0, $0		# t1 = y

la $a0, ArrayPtr
mul $a1, $s4, $s5		
addi $a2, $0, 4
jal malloc
nop
xor $a1, $t0, $0
xor $a2, $t1, $0

arraymenu:
addi $v0, $0, 4
la $a0, ArrayMenu
syscall

la $a0, ArrayPtr
addi $v0, $0, 5
syscall
beq $v0, $0, menu
beq $v0, 1, setArray
beq $v0, 2, getArray
nop

j arraymenu

exit:
addi $v0, $0, 10
syscall

## sub-functions

# opt1
getCharPtrAddress:		
la $v1, CharPtr
jr $ra
nop

getBytePtrAddress:
la $v1, BytePtr
jr $ra
nop

getWordPtrAddress:
la $v1, WordPtr
jr $ra
nop

getByteElement:			# a0 = Ptr; a1 = ElementIndex; return $v1
lw $t0, 0($a0)
nop
add $t1, $t0, $a1
lb $v1, 0($t1)
jr $ra
nop

assignByteValue:		# a0 = Ptr; a1 = ElementIndex; a2 = value
lw $t0, 0($a0)
nop
add $t0, $t0, $a1
sw $a2, 0($t0)
jr $ra
nop

# opt3
copy:				# a0 = DesPtr, a1 = SrcPtr, a2 = lengthOfCopy
lw $s0, 0($a0)
lw $s1, 0($a1)
sub $a2, $a2, 1			

loop:				# s2 = counter
add $t1, $s1, $s2
lb $t2, 0($t1)
add $t0, $s0, $s2
sb $t2, 0($t0)
bne $s2, $a2, loop
addi $s2, $s2, 1
jr $ra

# opt4

allocatedSize:			# return the allocated size in v1
lw $v1, 0($t9)			# t9 = address Sys_TheTopOfFree
nop
sub $v1, $v1, $t9
sub $v1, $v1, 4
jr $ra
nop

# opt5

setArray:			# a0 = address of Array, s4 = x, s5 = y
lw $s0, 0($a0)

addi $v0, $0, 4
la $a0, xScanMess	
syscall

addi $v0, $0, 5
syscall
xor $t0, $v0, $0		# t0 = i
slt $t4, $t0, $s4

addi $v0, $0, 4
la $a0, yScanMess	
syscall

addi $v0, $0, 5
syscall
xor $t1, $v0, $0		# t1 = j
slt $t5, $t1, $s5

beq $t4, $0, segmentationFault
beq $t5, $0, segmentationFault

addi $v0, $0, 4
la $a0, valueScanMess
syscall

addi $v0, $0, 5
syscall
xor $t2, $v0, $0		# t2 = value 

mul $t3, $t0, $s5		
add $t3, $t3, $t1
mul $t3, $t3, $k0		# t3 = (i.y + j).4

add $s1, $s0, $t3		# s1 = address to write

sw $t2, 0($s1)			# Array[i][j] = t2
nop
jr $ra
nop

getArray:			# a0 = ArrayPtr, s4 = x, s5 = y
lw $s0, 0($a0)

addi $v0, $0, 4
la $a0, xScanMess	
syscall

addi $v0, $0, 5
syscall
xor $t0, $v0, $0		# t0 = i
slt $t4, $t0, $s4

addi $v0, $0, 4
la $a0, yScanMess	
syscall

addi $v0, $0, 5
syscall
xor $t1, $v0, $0		# t1 = j
slt $t5, $t1, $s5

beq $t4, $0,  segmentationFault
beq $t5, $0, segmentationFault

mul $t3, $t0, $s5	
add $t3, $t3, $t1
mul $t3, $t3, $k0		# t3 = (i.y + j).4

add $s1, $s0, $t3		# s1 = address to read

la $a0, valueScanMess
addi $v0, $0, 4
syscall

lw $a0, 0($s1)			# a0 = Array[i][j]
addi $v0, $0, 1
syscall

jr $ra

segmentationFault:

addi $v0, $0, 4
la $a0, segFaultMess
syscall
j arraymenu
nop

SysInitMem:
la $t9, Sys_TheTopOfFree
la $t7, Sys_MyFreeSpace
sw $t7, 0($t9)
jr $ra
nop

malloc:				# a0 = Ptr, a1 = Size, a2 = sizeof(Ptr); return the allocated address in v0
la $t9, Sys_TheTopOfFree
lw $t8, 0($t9)
sw $t8, 0($a0)
addi $v0, $t8, 0
mul $t7, $a1, $a2

checkAddressable:
div $t7, $k0
mfhi $t0
beq $t0, $0, update_SysTheTopOfFree
beq $t0, 1, add_3
beq $t0, 2, add_2
beq $t0, 3, add_1
nop

add_3:
addi $t7, $t7, 3
j update_SysTheTopOfFree
nop
add_2:
addi $t7, $t7, 2
j update_SysTheTopOfFree
nop
add_1:
addi $t7, $t7, 1

update_SysTheTopOfFree:
add $t6, $t8, $t7
sw $t6, 0($t9)				# update the Sys_TheTopOfFree
jr $ra
nop
