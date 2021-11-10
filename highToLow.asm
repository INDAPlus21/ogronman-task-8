.data
 newline: .asciiz "\n"
.text

.data

     text1:  .asciiz "Enter the first number in the multiplication: "

.text


.data

     text2:  .asciiz "Enter the second number in the multiplication: "

.text

.macro multiply(%regVal, %a,%b,%saveValue)
	move %regVal, $0
	Loop:
	add %regVal, %regVal, 1
	add %saveValue, %saveValue, %b
	blt %regVal, %a, Loop
.end_macro

.macro faculty(%regVal1, %regVal2,%n,%saveValue)
	li  %regVal2, 1	#Start faculty
	Loop:
	li %saveValue, 0
	multiply(%regVal1, %n,  %regVal2, %saveValue)
	li %regVal2, 0
	move %regVal2, %saveValue
	sub %n, %n, 1
	bgt %n, 1, Loop
	
.end_macro

     e
main:
    
    move $t1, $0
    move $t2, $0
    
    jal printStartText
    
    multiply($t0,$t1,$t2,$s0)
   
    
    faculty($t0, $t1, $t2, $s1)
    
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
    move $a0, $s0
    syscall
    li $v0, 4       # you can call it your way as well with addi 
    la $a0, newline       # load address of the string	
    syscall
    
    li $v0, 1
    move $a0, $s1
    syscall
    jr $ra

	