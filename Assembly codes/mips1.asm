.data
	num1: .asciiz "Digite uma idade: "
	lmenor: .asciiz "menor de idade \n"
	lmaior: .asciiz "maior de idade \n"
.text

	move $t0,$zero
	
	looping:
	
	addi $t0,$t0,1
	
	li $v0,1
	move $a0,$t0
	syscall 
	
	# t2 = int(input("Digite o primeiro numero))
	li $v0, 4
	la $a0, num1
	syscall
	
	li $v0,5
	syscall 
	
	move $t2,$v0
	
	# -------
	
	slti $t1,$t2,18
	bne $t1,$zero,menor
	
	li $v0, 4
	la $a0, lmaior
	syscall
	
	j fim
	
	menor:
		li $v0, 4
		la $a0, lmenor
		syscall 
	fim:
	
	beq $t0,5,final
	
	j looping
	
	final: