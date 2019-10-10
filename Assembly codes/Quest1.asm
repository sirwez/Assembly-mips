.data
   DgtId: .asciiz "Digite a idade:\n"
   Menor: .asciiz "\nIdade menor que 30: \n"
   Media: .asciiz "Media:\n"
 
 .text
 
 move $t0, $zero
 move $t1, $zero
 move $s2, $zero
 move $t4, $zero
 
   looping:
   
addi $t0, $t0, 1 # i++

 #printa DgtId 
li $v0, 4
la $a0, DgtId
syscall

#ler a idade
li $v0, 5
syscall

#pega o que foi lido e coloca em $t1
move $t1, $v0

#---------------------Acabou a leitura-----------------

#vai somando para depois calcular a media
add $s2, $s2, $t1
#comparar

slti $t6, $t1, 30
bne $t6, $zero, men

   j compara

   men:
   addi $t4, $t4, 1
   
    j compara
     
   compara:
   
   beq $t0, 2, sai
   
   j looping
   
   sai:
   
    divu $s1, $s2, $t0 #executa a divisão entre s2 e s3
    
    		li $v0,1
	        move $a0,$s1
   		li $v0, 4
		la $a0, Media
		syscall 
		
    		li $v0,1
	        move $a0, $s1
	        syscall 
	        li $v0, 4
		la $a0, Menor
		syscall 
		
		li $v0,1
	        move $a0,$t4
	        syscall
	        
	        j fim
	        
	        fim: