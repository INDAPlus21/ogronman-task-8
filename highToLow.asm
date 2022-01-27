
.macro	PUSH (%reg)
	addi	$sp,$sp,-4              # decrement stack pointer (stack builds "downwards" in memory)
	sw	    %reg,0($sp)             # save value to stack
.end_macro

.macro	POP (%reg)
	lw	    %reg,0($sp)             # load value from stack to given registry
	addi	$sp,$sp,4               # increment stack pointer (stack builds "downwards" in memory)
.end_macro

.data


     newline: .asciiz "\n"
     text1:  .asciiz "Enter the first number in the multiplication: "
     text2:  .asciiz "Enter the second number in the multiplication: "

.text

.globl multiplication
.globl faculty
     
main:

    move $t3, $0
    
    jal printStartText
    
    #multiply($t0,$t1,$t2,$s0)
    
   
    move $a0, $t1
    move $a1, $t1
    
    jal multiplication
    move $s1, $v0
    
    jal faculty 
    move $s0, $v0
    
    jal printResults
    

    # exit program
    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program



printStartText:
    # Printing out the text
    li $v0, 4
    la $a0, text1
    syscall
    
    # Getting user input
    li $v0, 5
    syscall

    # Moving the integer input to another register
    move $t1, $v0
    
    # Printing out the text
    li $v0, 4
    la $a0, text2
    syscall
    
    # Getting user input
    li $v0, 5
    syscall

    # Moving the integer input to another register
    move $t2, $v0
    
    jr $ra

printInput:
    # Printing out the multiplication
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4       # you can call it your way as well with addi 
    la $a0, newline       # load address of the string	
    syscall
    jr $ra

printResults:
    # Printing out the multiplication
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 4       # you can call it your way as well with addi 
    la $a0, newline       # load address of the string	
    syscall
    
    li $v0, 1
    move $a0, $s0
    syscall
    jr $ra
    
faculty:
    PUSH($ra)
    li $t0, 1
    move $t1, $a0
    facLoop:
    	move $a0, $t1
    	move $a1, $t0
    	jal multiplication
    	move $t0, $v0
    	sub $t1, $t1, 1
    	bne $t1, 1, facLoop
    	POP($ra)
    	jr $ra
    	
    
multiplication:
    move $t2, $0 #counter
    move $t3, $0  #sum
    mulLoop:
    add $t2, $t2, 1
    add $t3, $t3, $a1
    bne $t2, $a0, mulLoop
    move $v0, $t3
    jr $ra
