### Data Declaration Section ###
.data
primes:		.space  1000            # reserves a block of 1000 bytes in application memory
err_msg:	.asciiz "Invalid input! Expected integer n, where 1 < n < 1001.\n"
space:		.asciiz " "
print_msg:	.asciiz "The prime numbers are: \n"

.text
### Executable Code Section ###

main:
    # get input
    li      $v0,5                   # set system call code to "read integer"
    syscall                         # read integer from standard input stream to $v0

    # validate input
    li 	    $t0,1001                # $t0 = 1001
    slt	    $t1,$v0,$t0		        # $t1 = input < 1001
    beq     $t1,$zero,invalid_input # if !(input < 1001), jump to invalid_input
    nop
    li	    $t0,1                   # $t0 = 1
    slt     $t1,$t0,$v0		        # $t1 = 1 < input
    beq     $t1,$zero,invalid_input # if !(1 < input), jump to invalid_input
    nop
    
    # initialise primes array
    la	    $t0,primes              # $s1 = address of the first element in the array
    move    $t1,$v0
    li 	    $t2,0
    li	    $t3,1
init_loop:
    sb	    $t3, ($t0)              # primes[i] = 1
    addi    $t0, $t0, 1             # increment pointer
    addi    $t2, $t2, 1             # increment counter
    ble	    $t2, $t1, init_loop     # loop if counter != input value
    
    ### Sieve of Eratosthenes ###
       
sieve_loop:
   add $t3, $t3, 1
   mul $t2, $t3, $t3
      
   move $t4, $t2
   inner_loop:
   la $t0, primes
   add $t0, $t0, $t4
   sb $0, ($t0)
   add $t4, $t4, $t3
   ble $t4, $t1, inner_loop
   ble $t2, $t1 sieve_loop
  
   ######## Print code #######
   li $t2, 1
   li $v0, 4
   la $a0, print_msg
   syscall
   
   print_loop:
   la $t0, primes
   add $t2, $t2 ,1
   add $t0, $t0, $t2
   bgt $t2, $t1, exit_program
   lb $t3, ($t0)
   bgt $t3, $0, print_number  
   ble $t2, $t1, print_loop
   
   # exit program
   j       exit_program
   nop
    
print_number:
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, space       
    syscall
    j print_loop

invalid_input:
    # print error message
    li      $v0, 4                  # set system call code "print string"
    la      $a0, err_msg            # load address of string err_msg into the system call argument registry
    syscall                         # print the message to standard output stream

exit_program:
    # exit program
    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # exit program