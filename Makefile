ROOTDIR = $(N64_INST)
GCCN64PREFIX = $(ROOTDIR)/bin/mips64-elf-
CHKSUM64PATH = $(ROOTDIR)/bin/chksum64
MKDFSPATH = $(ROOTDIR)/bin/mkdfs
HEADERPATH = $(ROOTDIR)/mips64-elf/lib
N64TOOL = $(ROOTDIR)/bin/n64tool
HEADERNAME = header
LINK_FLAGS = -G0 -L$(ROOTDIR)/mips64-elf/lib -led64 -ldragon -lc -lstdc++ -lm -ldragonsys -Tnaci.ld
CFLAGS = -std=c++11 -march=vr4300 -mtune=vr4300 -O2 -G0 -Wall -I$(ROOTDIR)/mips64-elf/include
ASFLAGS = -mtune=vr4300 -march=vr4300
CC = $(GCCN64PREFIX)gcc
AS = $(GCCN64PREFIX)as
LD = $(GCCN64PREFIX)ld
OBJCOPY = $(GCCN64PREFIX)objcopy

BUILD_PATH = $(CURDIR)/build
SOURCE_PATH = $(CURDIR)/src
PROG_NAME = $(BUILD_PATH)/main

N64_FLAGS = -l 2M -h $(HEADERPATH)/$(HEADERNAME) -o $(PROG_NAME)$(ROM_EXTENSION) $(PROG_NAME).bin
ifeq ($(N64_BYTE_SWAP),true)
ROM_EXTENSION = .v64
N64_FLAGS = -b $(N64_FLAGS)
else
ROM_EXTENSION = .z64
endif

$(PROG_NAME)$(ROM_EXTENSION): $(PROG_NAME).elf
	$(OBJCOPY) $(PROG_NAME).elf $(PROG_NAME).bin -O binary
	rm -f $(PROG_NAME)$(ROM_EXTENSION)
	$(N64TOOL) $(N64_FLAGS) -t "ED64"
	$(CHKSUM64PATH) $(PROG_NAME)$(ROM_EXTENSION)

$(PROG_NAME).o: $(SOURCE_PATH)/main.cpp
	mkdir -p $(BUILD_PATH)
	$(CC) -c -o $@ $< $(CFLAGS)

$(PROG_NAME).elf: $(PROG_NAME).o
	$(LD) -o $@ $^ $(LINK_FLAGS)

all: $(PROG_NAME)$(ROM_EXTENSION)

install:
	install -m 0644 naci.ld /usr/local/mips64-elf/lib/naci.ld

.PHONY: clean

clean:
	rm -rf $(BUILD_PATH)/*
