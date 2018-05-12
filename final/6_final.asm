.data

# pointer
CharPtr: .word 0
BytePtr: .word 0
WordPtr: .word 0

# mgs

Menu: .asciiz "\n-----------------------------------------------------------\n--------------------------MENU-----------------------------\n-----------------------------------------------------------\n 1. Malloc then Check Value (*CharPtr, *BytePtr, *WordPtr)\n 2. Check addresses of pointers\n 3. Copy 2 CharPtrs\n 4. Show the total allocated size of space\n 5. Malloc a 2D Array\n 0. Quit\nChoose option: "
CharScanMess: .asciiz "Size for CharPtr: "
ByteScanMess: .asciiz "Size for BytePtr: "
WordScanMess: .asciiz "Size for WordPtr: "
InputMess: .asciiz "Enter element "
colon: .asciiz ": "
ScanStringMess: .asciiz "Scanf a string using CharPtr: "
PrintElementChar: .asciiz "\nPrint the element (enter -1 to exit): "

CharPtrAddress: .asciiz "&CharPtr = "
BytePtrAddress: .asciiz "\n&BytePtr = "
WordPtrAddress: .asciiz "\n&WordPtr = "


.kdata

Sys_TheTopOfFree: .word 1	# value is the address of Sys_MyFreeSpace
Sys_MyFreeSpace: .word		# used to malloc a pointer starting from Sys_MyFreeSpace address

.text

main:
addi $k0, $k0, 4 		# k0 = 4 for checking Adddressalbe
addi $k1, $k1, -1		# final static k1 = -1;

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
la $a0, CharScanMess
syscall

addi $v0, $0, 5
syscall				# return value passing in v0
xor $a1, $v0, $0		# a1 = v0

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
jal GetByteElement

addi $v0, $0, 11
xor $a0, $v1, $0		# a0 = v1 (returned)
syscall
j PrintCharELement


# Scan size for BytePtr
addi $v0, $0, 4
la $a0, ByteScanMess
syscall

addi $v0, $0, 5
syscall				# return value passing in v0
xor $a1, $v0, $0		# a1 = v0

ByteMalloc:
la $a0, CharPtr			
addi $a2, $0, 1
jal malloc
nop
xor $s0, $v0, $0		# return v0 = address of pointer






#la $a0, BytePtr
#addi $a1, $0, 6
#addi $a2, $0, 1
#jal malloc
#nop

#la $a0, WordPtr
#addi $a1, $0, 5
#addi $a2, $0, 4
#jal malloc
#nop






j menu

#
opt2:

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

opt3:


j menu

opt4:
#Check Allocated Size

j menu

opt5:


j menu

exit:
addi $v0, $0, 10
syscall


#

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


allocatedSize:			# return the allocated size in v1
la $t0, Sys_TheTopOfFree
la $t1, Sys_MyFreeSpace
sub $v1, $t1, $t0
sub $v1, $v1, 4
jr $ra


GetByteElement:			# a0 = Ptr; a1 = ElementOrder; return $v1
lw $t0, 0($a0)
nop
add $t1, $t0, $a1
lb $v1, 0($t1)
jr $ra
nop







SysInitMem:

la $t9, Sys_TheTopOfFree
la $t7, Sys_MyFreeSpace
sw $t7, 0($t9)
jr $ra
nop

malloc:

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
