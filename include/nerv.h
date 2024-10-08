#ifndef NERV_H
#define NERV_H

#include <stddef.h>

#define BUFFER_HEIGHT 25
#define BUFFER_WIDTH 80

typedef struct {
    unsigned char ascii_character;
    unsigned char color_code;
} ScreenChar;

typedef struct {
    ScreenChar chars[BUFFER_HEIGHT][BUFFER_WIDTH];
} Buffer;

enum Color {
    Black = 0,
    Blue = 1,
    Green = 2,
    Cyan = 3,
    Red = 4,
    Magenta = 5,
    Brown = 6,
    LightGray = 7,
    DarkGray = 8,
    LightBlue = 9,
    LightGreen = 10,
    LightCyan = 11,
    LightRed = 12,
    Pink = 13,
    Yellow = 14,
    White = 15
};

typedef struct {
    size_t column_position;
    unsigned char color_code;
} Writer;

extern volatile Buffer *buffer;

void clear_row(size_t row);
void new_line(void);
void write_byte(unsigned char byte);
void write_string(const char* str);

#endif // NERV_H

