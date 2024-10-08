SRC_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build
ISO_DIR = iso

BOOTLOADER_SRC = $(SRC_DIR)/bootloader.asm
KERNEL_SRC = $(SRC_DIR)/kernel.c
NERV_SRC = $(SRC_DIR)/nerv.c
LINKER_SCRIPT = linker.ld

BOOTLOADER_BIN = $(BUILD_DIR)/bootloader.bin
KERNEL_BIN = $(BUILD_DIR)/kernel.bin
ISO_FILE = $(ISO_DIR)/NervOS.iso

CFLAGS = -m32 -ffreestanding -nostdlib -I$(INCLUDE_DIR) -fno-stack-protector

all: $(ISO_FILE)

$(ISO_FILE): $(BOOTLOADER_BIN) $(KERNEL_BIN)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(BOOTLOADER_BIN) $(ISO_DIR)/boot/
	cp $(KERNEL_BIN) $(ISO_DIR)/boot/
	cp $(SRC_DIR)/grub.cfg $(ISO_DIR)/boot/grub/
	grub2-mkrescue -o $(ISO_FILE) $(ISO_DIR)

$(BOOTLOADER_BIN): $(BOOTLOADER_SRC)
	mkdir -p $(BUILD_DIR)
	nasm -f bin $(BOOTLOADER_SRC) -o $(BOOTLOADER_BIN)

$(BUILD_DIR)/kernel.o: $(KERNEL_SRC) $(NERV_SRC) 
	gcc $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/nerv.o: $(NERV_SRC)
	gcc $(CFLAGS) -c $< -o $@

$(KERNEL_BIN): $(BUILD_DIR)/kernel.o $(BUILD_DIR)/nerv.o
	ld -m elf_i386 -T $(LINKER_SCRIPT) -o $(KERNEL_BIN) $^

clean:
	rm -rf $(BUILD_DIR) $(ISO_DIR)

.PHONY: all clean

