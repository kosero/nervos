#include "nerv.h"

void putchars(char c)
{
    volatile unsigned char *serial_port = (unsigned char *)0x03F8;
    *serial_port = c;
}

void print_str(const char* str)
{
    volatile char* video_memory = (volatile char*)0xB8000;
    char color = 0xC;

    while (*str != '\0')
    {
        *video_memory++ = *str++;
        *video_memory++ = color;
    }
}

