V=1
BUILD_DIR=build
SOURCE_DIR=src
include n64.mk

src=main.c

all: main.z64

main.z64: N64_ROM_TITLE="Testbench"
$(BUILD_DIR)/main.elf: $(src:%.c=$(BUILD_DIR)/%.o)

clean:
	rm -f $(BUILD_DIR)/* main.z64

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean
