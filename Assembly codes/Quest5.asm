.data 
        DgtNum:   .asciiz "Digite o num:\n"
	positivo: .asciiz "\nPositivos: \n"
	negativo: .asciiz "\nNegativos: \n"
	nulo:     .asciiz "\nNulos: \n"
	media:    .asciiz "\nMedia numeros negativos: \n"
	soma:     .asciiz "\nSoma:\n"
.text

	move $t0,$zero # incrementador do loop
	move $s1, $zero # somar geral
	move $s4, $zero
	move $s5, $zero
	move $t1, $zero 
	move $t2, $zero # contador negativo
	move $t3, $zero # contador de positivo
	move $t4, $zero # contador nulo
	
	
	move $t7, $zero 
loop:
	
	addi $t0,$t0,1
	
	li $v0, 4
	la $a0, DgtNum 
	syscall
	
	li $v0,5 
	syscall
         move $s4, $v0
	add $t5, $t5, $s4 
	
	beq $s4, $zero, IgualZero 
	
	slti $s3, $s4, 0
	bne $s3, $zero, Negativo
	
	addi $t3,$t3,1
	
	j sair

IgualZero:

addi $t4, $t4, 1

j sair

Negativo:
add $s5, $s5, $s4
addi $t2, $t2, 1

j sair

sair:

beq $t0, 10, fechar

j loop

fechar:

	        li $v0, 4
		la $a0, positivo
		syscall 
		
		li $v0,1
	        move $a0,$t3
	        syscall
	        
	        li $v0, 4
		la $a0, negativo
		syscall 
		
		li $v0,1
	        move $a0,$t2
	        syscall
	        
	        li $v0, 4
		la $a0, nulo
		syscall 
		
		li $v0,1
	        move $a0,$t4
	        syscall
	        
	         li $v0, 4
		la $a0, soma
		syscall 
		
		li $v0,1
	        move $a0, $t5
	        syscall
	        
	        div $s5, $t2
	        mflo $t7
	        li $v0, 4
		la $a0, media
		syscall 
		
		li $v0,1
	        move $a0, $t7
	        syscall