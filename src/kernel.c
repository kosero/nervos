#include <nvio.h>

// Multiboot 
asm(".section .multiboot\n\t"
    "   .long 0x1BADB002\n\t"  
    "   .long 0x00           \n\t"  
    "   .long - (0x1BADB002 + 0x00)\n\t");  

void kmain() {
    write_string("NERV Operating System.");
    
    while (1) {
    }
}

