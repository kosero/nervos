ENTRY(start)
SECTIONS
{
    . = 0x7C00;

    .text : AT(0x7C00)
    {
        *(.text)
    }

    .rodata : { *(.rodata) }

    .data : { *(.data) }

    .bss : { *(.bss) }

    /DISCARD/ : { *(.eh_frame) *(.comment) }
}

