#ifndef NVIO_H
#define NVIO_H

#define BUFFER_HEIGHT 25
#define BUFFER_WIDTH 80

#define PORT_OUTPUT 0x3F8
#define PORT_INPUT  0x60

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
    unsigned int column_position;
    unsigned char color_code;
} Writer;

extern volatile Buffer *buffer;

void outb(unsigned short port, unsigned char value);
unsigned char inb(unsigned short port);

void clear_row(unsigned int row);
void new_line(void);
void write_byte(unsigned char byte);
void write_string(const char* str);

#endif // NVIO_H

