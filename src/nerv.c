#include "nerv.h"

volatile Buffer *buffer = (volatile Buffer *)0xB8000;

Writer writer = { 0, (Black << 4) | LightRed };

void clear_row(unsigned int row)
{
    ScreenChar blank = { ' ', writer.color_code };
    for (unsigned int col = 0; col < BUFFER_WIDTH; col++) {
        buffer->chars[row][col] = blank;
    }
}

void new_line()
{
    for (unsigned int row = 1; row < BUFFER_HEIGHT; row++) {
        for (unsigned int col = 0; col < BUFFER_WIDTH; col++) {
            buffer->chars[row - 1][col] = buffer->chars[row][col];
        }
    }
    clear_row(BUFFER_HEIGHT - 1);
    writer.column_position = 0;
}

void write_byte(unsigned char byte)
{
    if (byte == '\n') {
        new_line();
        return;
    }

    if (writer.column_position >= BUFFER_WIDTH) {
        new_line();
    }

    unsigned int row = BUFFER_HEIGHT - 1;
    unsigned int col = writer.column_position;

    buffer->chars[row][col].ascii_character = byte;
    buffer->chars[row][col].color_code = writer.color_code;

    writer.column_position++;
}

void write_string(const char* str)
{
    while (*str != '\0') {
        if (*str == '\n') {
            write_byte('\n');
        } else if (*str >= ' ' && *str <= '~') {
            write_byte((unsigned char)*str);
        } else {
            write_byte(0xfe);
        }
        str++;
    }
}
