.text:

lui	$s0, 0x1234
ori	$s0, 0x5678

#extract MSB
andi	$s1, $s0, 0xff000000
srl	$s1, $s1, 24

#clear LSB
andi	$s0, $s0, 0xffffff00

#set LSB
or	$s0, $s0, 0x000000ff

#clear
andi	$s0, $s0, 0x0