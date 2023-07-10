# User defined values
GNU-EFI_LOCALIZATION = ./gnu-efi
OVMF_LOCALIZATION = ../OVMFbin

# Compiler
CXX = clang
CXXFLAGS = -target x86_64-unknown-windows -ffreestanding -fshort-wchar -mno-red-zone
INCLUDE_HEADERS = -I include

# Files
SRCS = $(shell find src -name "*.c")
OBJ_DIR = obj
OBJS = $(patsubst src/%.c, $(OBJ_DIR)/%.o, $(SRCS))

# Linker
LDFLAGS = -target x86_64-unknown-windows -nostdlib

all: $(OBJS) build

$(OBJ_DIR)/%.o: src/%.c
	@mkdir -p $(@D)
	echo $(CXX) $(CXXFLAGS) $(INCLUDE_HEADERS) -c $< -o $@

build:
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(LDFLAGS) -o $(BUILD_DIR)/libc.o $(OBJS)

clean:
	rm -rf $(OBJ_DIR)
	rm -rf $(BUILD_DIR)

.PHONY: all build clean