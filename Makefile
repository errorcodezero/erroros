CC := i686-elf-gcc
AS := i686-elf-as
LD := i686-elf-gcc
QEMU := qemu-system-i386

SRC_DIR := src
BUILD_DIR := build

C_SRCS := $(wildcard $(SRC_DIR)/*.c)
S_SRCS := $(wildcard $(SRC_DIR)/*.s)
LINK_SCRIPT := $(SRC_DIR)/linker.ld

OBJS := $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(C_SRCS)) \
        $(patsubst $(SRC_DIR)/%.s, $(BUILD_DIR)/%.o, $(S_SRCS))

TARGET := $(BUILD_DIR)/mykernel.bin

CFLAGS := -std=gnu99 -ffreestanding -O2 -Wall -Wextra
LDFLAGS := -ffreestanding -O2 -nostdlib -T $(LINK_SCRIPT)

.PHONY: all clean

all: $(TARGET)

dev: $(TARGET)
	$(QEMU) -fda $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@ -lgcc

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s | $(BUILD_DIR)
	$(AS) $< -o $@

clean:
	rm -rf $(BUILD_DIR)
