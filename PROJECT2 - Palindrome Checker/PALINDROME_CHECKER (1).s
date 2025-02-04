# Program: Palindrome Checker
# Description: This program checks if the given string is a palindrome.
# Author: Vedad Kruho & Mustafa Sinanovic
# Date: 22.05.2024
# Course: Computer Architecture (CS304)
# Project: MIPS Project 

.data
input_string: .asciiz "818"           # String input which we are going to test

.text
.globl __start   # Define where program will start

__start:   # Label for program start

    # Initialize length counter ($t0) to 0
    addi $t0, $zero, 0                 # $t0 = 0, initialize length counter

    # Load the base address of the input string into $a1
    lui $s5, 0x1000                    # Load upper 16 bits of address into $s5
    ori $a1, $s5, 0x0000               # Combine with lower 16 bits to form full address in $a1

    # Loop to calculate the length of the input string, it goes until end of the string and adds $a1 by each of them
length_loop:
    lb $t5, 0($a1)                     # Load byte at address in $a1 into $t5
    sll $zero, $zero, 0                # No-operation to ensure data is loaded
    beq $t5, $zero, length_end         # If byte is 0 (end of string), branch to length_end
    addi $a1, $a1, 1                   # Increment $a1 to point to next character
    addi $t0, $t0, 1                   # Increment length counter ($t0)
    j length_loop                      # Jump back to the start of the loop

length_end: # End of the length calculation loop

    # Prepare to check if the string is a palindrome, $a1 and $a2 are set to first and last character so they are ready for further comparing
    lui $s5, 0x1000                    # Load the upper 16 bits of the address into $s5
    ori $a1, $s5, 0x0000               # Combine with lower 16 bits to form full address in $a1
    add $a2, $a1, $zero                # Copy $a1 to $a2
    add $a2, $a2, $t0                  # Add length of string to $a2 to point just past last character
    addi $a2, $a2, -1                  # Move $a2 back to point to the last character (before null terminator)
    addi $t1, $zero, 1                 # Assume string is a palindrome, set $t1 to 1

    # Loop to check if the string is a palindrome, use $t5 and $t6 to check if ASCII values are the same, if yes check until sub is equal 0, or until bot registers point to the same value, it means that the string is palindrome
palindrome_check_loop:
    lb $t5, 0($a1)                     # Load byte at $a1 (current start) into $t5
    lb $t6, 0($a2)                     # Load byte at $a2 (current end) into $t6
    sll $zero, $zero, 0                # No-operation to ensure data is loaded
    bne $t5, $t6, not_palindrome       # If bytes are not equal, branch to not_palindrome
    addi $a1, $a1, 1                   # Increment $a1 to next character
    addi $a2, $a2, -1                  # Decrement $a2 to previous character
    sub  $at, $a1, $a2                 # Subtract $a2 from $a1 to compare addresses
    bne $at, $zero, palindrome_check_loop # If $a1 is less than $a2, repeat loop

    # If all characters matched, print 1
    j print_result                     # Jump to print_result
    sll $zero, $zero, 0                # No-operation

not_palindrome:                        # Set $t1 to 0 if string is not a palindrome
    ori $t1, $zero, 0                  # $t1 = 0, string is not a palindrome

print_result:                          # Print result based on $t1 value
    add $a0, $t1, $zero                # Copy $t1 to $a0 (instead of using move)
    lui $v0, 0                         # Load upper half of syscall code for print integer (0x00000001)
    ori $v0, $v0, 1                    # Load lower half of syscall code for print integer (0x00000001)
    syscall                            # Print the result

program_end:                           # End the program
    lui $v0, 0                         # Load upper half of syscall code for exit (0x0000000A)
    ori $v0, $v0, 10                   # Load lower half of syscall code for exit (0x0000000A)
    syscall                            # End the program
