.data
stringasciiz: .asciiz "123abcbABCDE"		#string para ser verificada
string_Mai: .asciiz "Maiusculas: "
string_min: .asciiz "\nMinúsculas: "
string_num: .asciiz "\nNumeros: "

LimitInfNum: .word 0x30 #limite na tabela ASCII dos numeros
LimitSupNum: .word 0x39
LimitInfMai: .word 0x41	#limite na tabela ASCII das letras Maiuculas 
LimitSupMai: .word 0x5A
LimitInfMin: .word 0x61	#limite na tabela ASCII das letras Minusculas
LimitSupMin: .word 0x7A

.text
.globl main
main:   la $t0, stringasciiz 
	li $s0, 0 	#registrador para guardar a quant de letras Maiusculas
	li $s1, 0	#registrador para guardar a quant de letras minusculas
	li $s2, 0	#registrador para guardar a quant de numeros
	add $t2, $zero, $t0
	
LOOP:   lb $t3, 0($t2)		#carrega o byte de $t2 "carrega em ASCII"
	beq $t3, $zero, print	#se for igual a 0 chegou no final da string, logo imprimir resultados
	
		#verifica se possivelmente eh uma letra minúscula
	la $t1, LimitInfMin	#carrega o endereço de do limite minimo	
	lw $t4, 0($t1)		#carrega o conteudo 
	bge $t3, $t4, Min	# "Branch greater than or equal"     se $t3 for >= a $t4 ir para label 

		#verifica se possivelmente eh uma letra Maiúscula
	la $t1, LimitInfMai
	lw $t4, 0($t1)
	bge $t3, $t4, Mai	
	
		#verifica se possivelmente eh um numero
	la $t1, LimitInfNum
	lw $t4, 0($t1)
	bge $t3, $t4, Num	
	
Num: 	la $t1, LimitSupNum		
	lw $t4, 0($t1)
	ble $t3, $t4, ContaNum	 

Mai: 	la $t1, LimitSupMai
	lw $t4, 0($t1)
	ble $t3, $t4, ContaMai	
	
Min: 	la $t1, LimitSupMin
	lw $t4, 0($t1)
	ble $t3, $t4, ContaMin	#"Branch less than or equal"   se $t3 for <= a $t4 pular para label 	
				
ContaMai: addi $s0, $s0, 1	#adciona um no contador de Maiusculas
	  addi $t2, $t2, 1	#incrementa um byte o registrador que guarda a string 
	  j LOOP
	  

ContaMin: addi $s1, $s1, 1	#adiciona um no contador de minusculas
	  addi $t2, $t2, 1	#incrementa um byte o registrador que guarda a string 
	  j LOOP
	  

ContaNum: addi $s2, $s2, 1	#adiciona um no contador de numeros
	  addi $t2, $t2, 1	#incrementa um byte o registrador que guarda a string 
	  j LOOP	  
	   
print:
	  li $v0, 4 		#frase
	  la $a0, string_Mai	
	  syscall
	  
	  li $v0, 1 		#imprime a quant de Maiusculas
	  la $a0, ($s0)		
	  syscall
	  
	  li $v0, 4		#frase
	  la $a0, string_min		
	  syscall
	  
	  li $v0, 1		#imprime a quant de minuscula
	  la $a0, ($s1)
	  syscall 
	  
	  li $v0, 4		#frase
	  la $a0, string_num	
	  syscall
	  
	  li $v0, 1		#impirme a quant de numeros
	  la $a0, ($s2)
	  syscall	 
	  
SAI: 	li $v0, 10
	syscall	

