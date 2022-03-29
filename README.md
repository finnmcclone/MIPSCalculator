# Computer Architecture
## MIPS-2 Group Designed MIPS Test Program

### MIPS-2 Overview
You will collaboarate in developing a test algorithm for MIPS. You will present your algorithm to the class.


### Grade Break Down
| Part                               |   | Points  |
|------------------------------------|---|---------|
| MIPS_2-4 a - Group Algorithm       |   | 30 pts  |   
| MIPS_2-4 b - Mini Presentation     |   | 20 pts  |    
| Total                              |   | 50 pts  |


# 2-4 a: Group Algorithm
Think about the types of applications that you hope your final processor will be able to execute. For this project you will write a test program that will help verify that the MIPS processor works correctly.  Think about the types of MIPS instructions you might want to use. What instructions does MIPS have that are similar to the ones that you will need to use for your final processor?

Negotiate in your group as to the type of MIPS test program you will want to develop.  Come up with an interesting algorithm on your own. Do NOT simply copy a MIPS program from the internet. While this may be tempting, doing so may result in an immediate 0 for this entire assignment. The idea here is for you to have fun and create something original that uses the MIPS assembly language and that is  able to run on QTSpim. 

In the future you might want to convert this algorithm to your own assembly language, so use this time wisely and write something fun and interesting.

After designing your algorithm, each of you individually must include your algorithm in this repository and push your code back to whitgit:

```mips
# Put your mips assembly code algorithm here
# Make sure that it is commented well
# Authors: Finn McClone, Travis Plunkett, and James Holtz
# Date: 3/1/2022

# simple calculator

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

```

# 2-4 b: Presentation

On the due date for this design, groups of two will take 5 minutes (max) and present their test algorithm design to the class. You will be graded on whether you present the following items.  Do not use more than 4 or 5 slides to summarize your algorithm. 

Minute 1:  What MIPS instructions did you choose for your algorithm and why you chose them.
Minute 2:  A neat assembly language listing of your program in the MIPS language. You must include comments. 
Minute 3:  A demonstration of your MIPS assembler language running on QTSpim. 
Minutes 4 - 5:  An analysis of your algorithm. 
* What did you like / dislike about the MIPS instructions you used? 
* How efficient was your algorithm?  
* Will you use a similar program to this in the future for testing your final microprocessor design?
