# Specify the compiler
CXX := g++

# Directories
SRC_DIR := ./
OBJ_DIR := obj
BIN_DIR := bin
INCLUDE_DIR := $(SRC_DIR)/shared_object_example/include

# Files
# this is wild carded but that's only for simplicity.. we can easily make this take a list of source files instead.
SRCS := $(wildcard $(SRC_DIR)/*.cpp)

# Generate a list of object file paths. using the SRC's list.
# Take the source paths, strip out the path leading up, replace with the object directory path, and replace .cpp with .o
OBJS := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRCS))
PROG_NAME := myprogram
EXECUTABLE := BUILD_EXECUTABLE

# Debug mode flags
DEBUG_FLAGS := -g -O0

# Release mode flags
RELEASE_FLAGS := -O2

# Architecture flags
ARCH_FLAGS_86 := -m32
ARCH_FLAGS_64 := -m64

LINKAGE_FLAGS = -W

# Default target is release 64
all: release64

# Debug target (x86)
debug32: ARCH_FLAGS := $(ARCH_FLAGS_86)
debug32: CXXFLAGS := $(DEBUG_FLAGS)
debug32: BIN_ARCH_DIR := debug/bin
debug32: LIB_ARCH_DIR := debug/lib
debug32: BITNESS_SUFFIX:= _32
debug32: EXE_PATH := $(BIN_ARCH_DIR)/$(PROG_NAME)$(BITNESS_SUFFIX)
debug32: $(OBJS) $(EXECUTABLE)
	@echo "Build completed for Debug (x86)"

# Debug target (x64)
debug64: ARCH_FLAGS := $(ARCH_FLAGS_64)
debug64: CXXFLAGS := $(DEBUG_FLAGS)
debug64: BIN_ARCH_DIR := debug/bin
debug64: LIB_ARCH_DIR := debug/lib
debug64: BITNESS_SUFFIX:= _64
debug64: EXE_PATH := $(BIN_ARCH_DIR)/$(PROG_NAME)$(BITNESS_SUFFIX)
debug64: $(OBJS) $(EXECUTABLE)
	@echo "Build completed for Debug (x64)"

# Release target (x86)
release32: ARCH_FLAGS := $(ARCH_FLAGS_86)
release32: CXXFLAGS := $(RELEASE_FLAGS)
release32: BIN_ARCH_DIR := release/bin
release32: LIB_ARCH_DIR := release/lib
release32: BITNESS_SUFFIX:= _32
release32: EXE_PATH := $(BIN_ARCH_DIR)/$(PROG_NAME)$(BITNESS_SUFFIX)
release32: $(OBJS) $(EXECUTABLE)
	@echo "Build completed for Release (x86)"

# Release target (x64)
release64: ARCH_FLAGS := $(ARCH_FLAGS_64)
release64: CXXFLAGS := $(RELEASE_FLAGS)
release64: BIN_ARCH_DIR := release/bin
release64: LIB_ARCH_DIR := release/lib
release64: BITNESS_SUFFIX:= _64
release64: EXE_PATH := $(BIN_ARCH_DIR)/$(PROG_NAME)$(BITNESS_SUFFIX)
release64: $(OBJS) $(EXECUTABLE)
	@echo "Build completed for Release (x64)"

# Rule to build object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(ARCH_FLAGS) -c $< -o $@ -I $(INCLUDE_DIR)

# Rule to build the executable
$(EXECUTABLE): $(OBJS)
	@mkdir -p $(BIN_ARCH_DIR)
	$(CXX) -w $(CXXFLAGS) $(ARCH_FLAGS) $^ -o $(EXE_PATH) -L$(LIB_ARCH_DIR) -l:shared_object_example_64.a -lstdc++
	@$(MAKE) cleanobj

# $(CXX) -w $(CXXFLAGS) $(ARCH_FLAGS) $^ -o $(EXE_PATH) -L$(LIB_ARCH_DIR) -l:shared_object_example_64.a -lstdc++
# Clean object files
cleanobj:
	rm -rf $(OBJ_DIR)

# Clean target
clean: cleanobj
	rm -rf $(BIN_DIR)

# Phony targets
.PHONY: all debug86 debug64 release86 release64 clean cleanobj
