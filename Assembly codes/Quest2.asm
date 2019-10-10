.data

DgtSaldo: .asciiz "Digite o saldo:\n"
SaldoMdio: .asciiz "\nSaldo Medio:\n"
Devendo: .asciiz "\nDevedor:\n"
Credor: .asciiz "\nCredor:\n"

.text

	move $t0,$zero # i++
	mtc1 $zero, $f1 # soma saldo
	mtc1 $zero, $f3 # comparar
	move $t2, $zero # cont dev
	move $t3, $zero # cont paga certo
	move $t6, $zero # div
	move $t7, $zero # mult
	
loop:
	
	addi $t0,$t0,1 # i++
	
	li $v0, 4
	la $a0, DgtSaldo
	syscall
	
	li $v0,6
	syscall
	
	add.s $f1, $f1, $f0 #somando os saldos
	
	c.lt.s $f0, $f3
	bc1t deves
	addi $t3,$t3,1 # credor++
	
	j sai
	
deves:
	addi $t2,$t2,1 # dev++
	
sai:
	beq $t0,10,final
	j loop
	
final:
	addi $t6, $t6, 10
	mtc1 $t6, $f4
	cvt.s.w $f4, $f4
	div.s $f3, $f1, $f4

	li $v0, 4
	la $a0, SaldoMdio
	syscall
	
	li $v0,2
	mov.s $f12, $f3
	syscall
	
	li $v0, 4
	la $a0, Devendo
	syscall
	
	addi $t7,$t7,100
	div $t7,$t6
	mflo $a2
	
	mul $v1,$a2,$t2
	
	li $v0,1
	move $a0, $v1
	syscall
	
	li $v0, 4
	la $a0, Credor
	syscall
	
	li $v0,1
	move $a0, $t3
	syscall