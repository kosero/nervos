CC=gcc

INCLUDE_DIR=include
SRC_DIR=src
BUILD_DIR=build
ISO_DIR=iso

KERNEL_SRC=$(SRC_DIR)/kernel.c
NVIO_SRC=$(SRC_DIR)/nvio.c
LINKER_SCRIPT=linker.ld

KERNEL_BIN=$(BUILD_DIR)/kernel.bin
ISO_FILE=$(ISO_DIR)/NervOS.iso

CFLAGS=-m64 -ffreestanding -nostdlib -I$(INCLUDE_DIR)

all: $(BUILD_DIR) $(ISO_FILE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(ISO_FILE): $(KERNEL_BIN)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL_BIN) $(ISO_DIR)/boot
	cp $(SRC_DIR)/grub.cfg $(ISO_DIR)/boot/grub/
	grub-mkrescue -o $(ISO_FILE) $(ISO_DIR)

$(BUILD_DIR)/kernel.o: $(KERNEL_SRC) | $(BUILD_DIR)
	gcc $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/nvio.o: $(NVIO_SRC) | $(BUILD_DIR)
	gcc $(CFLAGS) -c $< -o $@

$(KERNEL_BIN): $(BUILD_DIR)/kernel.o $(BUILD_DIR)/nvio.o
	ld -m elf_x86_64 -T $(LINKER_SCRIPT) -o $@ $^

clean:
	rm -rf $(BUILD_DIR) $(ISO_DIR)

.PHONY: all clean

