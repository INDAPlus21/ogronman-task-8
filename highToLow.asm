.data


     newline: .asciiz "\n"
     text1:  .asciiz "Enter the first number in the multiplication: "
     text2:  .asciiz "Enter the second number in the multiplication: "

.text

## Should I do it like this or like not use macros
## Not very knowledgeable about MIPS lingo so I do not know how to wrap things in global routines :(
## Feels like alot can go wrong if I just use temporary values inside the macro, but I guess that is what they are made for

.macro multiply(%a,%b)
	move $t0, $0
	Loop:
	add $t0, $t0, 1
	add $s0, $t2, %b
	blt $t0, %a, Loop
.end_macro

.macro faculty(%n)
	li  $t1, 1	#Start faculty
	Loop:
	li $s0, 0
	multiply(%n,  $t1)
	li $t1, 0
	move $t1, $t2
	sub %n, %n, 1
	bgt %n, 1, Loop
	
	move %n, $t2
.end_macro

     
main:

    move $t3, $0
    
    jal printStartText
    
    #multiply($t0,$t1,$t2,$s0)
   
    
    faculty($t2)
    
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
    move $a0, $t2
    syscall
    li $v0, 4       # you can call it your way as well with addi 
    la $a0, newline       # load address of the string	
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall
    jr $ra

	
