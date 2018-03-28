.data
string: .space 50
message1: .asciiz "Enter a string: "
message2: .asciiz "Length of the string: "

.text
main:
get_string:
li $v0, 54
la $a0, message1
la $a1, string
la $a2, 50
syscall

get_length:
la $a0, string
xor $v0, $zero, $zero

check_char:
add $t1, $a0, $v0
lb $t2, 0($t1)
beq $t2,0x0000000a, end_of_str	# 0x0000000a : '\n'
nop
addi $v0, $v0, 1
j check_char

end_of_str:
end_of_get_length:
print_length:
or $a1,$v0,$zero		# $a1 = $v0 = length
li $v0, 56
la $a0, message2
syscall
