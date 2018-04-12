.eqv SEVENSEG_RIGHT 0xFFFF0010
.eqv SEVENSEG_LEFT 0xFFFF0011

.text
main:
li $a0, 0x7d
jal SHOW_7SEG_LEFT
nop
li $a0, 0x6F
jal SHOW_7SEG_RIGHT

exit:
li $v0, 10
syscall

#set value for segments
#show
#set value for segments
#show
endmain:

#---------------------------------------------------------------
SHOW_7SEG_LEFT:
li $t0, SEVENSEG_LEFT # assign port's address
sb $a0, 0($t0)
# assign new value
jr $ra

#---------------------------------------------------------------
SHOW_7SEG_RIGHT:
li $t0, SEVENSEG_RIGHT # assign port's address
sb $a0, 0($t0)
# assign new value
jr $ra