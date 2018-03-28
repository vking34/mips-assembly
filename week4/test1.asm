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
xor $t0,$zero,$zero

check_char:
add	$t1,$a0,$t0
lb $t2, 0($t1)
# t2 = string[i]
beq $t2,$zero,end_of_str # Is null char?
addi $v0, $v0, 1
# v0=v0+1->length=length+1
addi $t0, $t0, 1
# t0=t0+1->i = i + 1
j check_char
end_of_str:
end_of_get_length:
print_length:
or $a1,$v0,$zero		# $a1 = $v0 = length
li $v0, 56
la $a0, message2
syscall