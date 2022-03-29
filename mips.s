# simple calculator
# created by: Finn McClone, Travis Plunkett, and James Holtz
# date: 3/1/2022

.data
arg_1_prompt: .asciiz "Enter first int: \n"
arg_2_prompt: .asciiz "Enter second int: \n"
arg_3_prompt: .asciiz "Enter opperation (+, -, *): \n"
error_prompt: .asciiz "Invalid Entry. Try Again: \n"
repeat_prompt: .asciiz "\nWould you like to evaluate another expression? (y/n)\n"
line_end: .asciiz "\n"
result: .asciiz "Result:\n"

.text
main:

addi $s0, $0, 0x2B              # stores '+' into $s0
addi $s1, $0, 0x2D              # stroes '-' into $s1
addi $s2, $0, 0x2A              # stores '*' into $s2

addi $s3, $0, 0x79              # stores 'y' into $s3
addi $s4, $0, 0x6E              # stores 'n' into $s4


# loop until user inputs to end
startLoop:
    # ask for user input
    addi $v0, $0, 4                 # 4 is the system call for write string
    la $a0, arg_1_prompt
    syscall

    # user inputs arg 1
    addi $v0, $0, 5                 # 5 is the system call for read int
    syscall
    add $t0, $0, $v0                # stores first integer into $t0

    # ask for user input 2
    addi $v0, $0, 4                 # 4 is the system call for write string
    la $a0, arg_2_prompt
    syscall

    # user inputs arg 2
    addi $v0, $0, 5                 # 5 is the system call for read int
    syscall
    add $t1, $0, $v0                # stores second value into $t1

    # ask for opperation
    addi $v0, $0, 4                 # 4 is the system call for write string
    la $a0, arg_3_prompt
    syscall

    # jump back to here if opperation is invalid
    error_1:
        addi $v0, $0, 12                # 12 is the system call for read char
        syscall
        add $t2, $0, $v0                # stores opperation into $t2

        li $v0, 4                       # end line
        la $a0, line_end
        syscall

    # checking opperation
    # if addition
    beq $s0, $t2, addition
    # if subtraction
    beq $s1, $t2, subtraction 
    # if mulitplication
    beq $s2, $t2, mulitplication

    # if none
    addi $v0, $0, 4                 #  4 is the system call for write string
    la $a0, error_prompt
    syscall
    # jump back to read opperation
    j error_1


    addition:
        li $v0, 4                       # writes result
        la $a0, result
        syscall

        add $a0, $t0, $t1
        addi $v0, $0, 1
        syscall
        j postOpp

    subtraction:
        li $v0, 4                       # writes result
        la $a0, result
        syscall

        sub $a0, $t0, $t1
        addi $v0, $0, 1
        syscall
        j postOpp

    mulitplication:
        li $v0, 4                       # writes result
        la $a0, result
        syscall

        mul $a0, $t0, $t1
        addi $v0, $0, 1
        syscall
        j postOpp


    postOpp:
    # repeat on user input
        addi $v0, $0, 4                 # write repeat prompt
        la $a0, repeat_prompt
        syscall

    error_2:
        addi $v0, $0, 12                # read character
        syscall
        add $t3, $0, $v0                # store character into $t3

        li $v0, 4                       # end line
        la $a0, line_end
        syscall

    # check user input
    beq $s3, $t3, startLoop         # if 'y', go to start of loop
    beq $s4, $t3, endLoop           # if 'n', go to end of code

    addi $v0, $0, 4                 # print error prompt
    la $a0, error_prompt
    syscall
    j error_2

endLoop:
    # end program
    addi $v0, $0, 10
    syscall