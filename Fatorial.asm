.data

    tela: .asciiz "Digite X:\n"

    resultado: .asciiz "Fatorial de (x)! = "

.text

main:

    #mostrar tela

    li        $v0, 4

    la        $a0, tela

    syscall

    # read x

    li        $v0, 5

    syscall

    # function call

    move      $a0, $v0

    jal      fatorial       # jump factorial e salva a posição em $ra

    move      $t0, $v0        # $t0 = $v0

    # show prompt

    li        $v0, 4

    la        $a0, resultado

    syscall

    # print the result

    li        $v0, 1        # system call #1 - print int

    move      $a0, $t0        # $a0 = $t0

    syscall                # execute

    # return 0

    li        $v0, 10        # $v0 = 10

    syscall





.text

fatorial:

    addi    $sp, $sp, -8

    # save $s0 and $ra

    sw      $s0, 4($sp)

    sw      $ra, 0($sp)

    bne     $a0, 0, else

    addi    $v0, $zero, 1    # return 1

    j fact_return



else:

    # backup $a0

    move    $s0, $a0

    addi    $a0, $a0, -1 # x -= 1

    jal     fatorial

    # when we get here, we already have Fact(x-1) store in $v0

    multu   $s0, $v0 # return x*Fact(x-1)

    mflo    $v0

fact_return:

    lw      $s0, 4($sp)

    lw      $ra, 0($sp)

    addi    $sp, $sp, 8

    jr      $ra
