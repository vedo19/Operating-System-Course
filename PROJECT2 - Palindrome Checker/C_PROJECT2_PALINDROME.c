#include <stdio.h>
#include <string.h>

int main() {
    
    char test[] = "rotator"; // Input for testing if it is palindrome
    int length_test = 0;

    // Calculating the length of our input
    while (test[length_test] != '\0') { // It will calculate (be inside loop) until 'null character' is reached - no more characters)
        length_test++; // Increasing length each time by one
    }
    
    // We need to initialize start and end point
    char *starting_point = test; // Pointing to the start of a string
    char *ending_point = test + length_test - 1; // Pointing to the last character of a string
    int check_palindrome = 1; // We assume string is palindrome - set to 1

    // Now, go inside the loop to check if string is palindrome
    while (starting_point < ending_point) { // Basically, goes until last character is reached
        
        if (*starting_point != *ending_point) {
            check_palindrome = 0; // In palindrome, first and last character needs to match, so if they are not equal, it is 0
            break; // Loop - exit because it is not plaindrome
        }
        starting_point++; // Move to the next character from the start
        ending_point--; // Move to the previous character from the end
    }

    // Length of a string
    printf("Length: %d\n", length_test);

    // Result
    if (check_palindrome) {
        printf("PALINDROME!\n");
    } else {
        printf("NOT PALINDROME!\n");
    }

    return 0; // Exit call
}
