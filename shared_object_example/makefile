# Specify the compiler
CXX := g++

# Directories
SRC_DIR := .
TOP = ..
INCLUDE_DIR := $(SRC_DIR)/include
OBJ_DIR := $(TOP)/obj


# Files
# this is wild carded but that's only for simplicity.. we can easily make this take a list of source files instead.
SRCS := $(wildcard $(SRC_DIR)/*.cpp)

# Generate a list of object file paths. using the SRC's list.
# Take the source paths, strip out the path leading up, replace with the object directory path, and replace .cpp with .o
OBJS := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRCS))
SO_NAME := shared_object_example
LIBRARY := BUILD_LIBRARY

# Debug mode flags
DEBUG_FLAGS := -g -O0

# Release mode flags
RELEASE_FLAGS := -O2

# Architecture flags
ARCH_FLAGS_86 := -m32
ARCH_FLAGS_64 := -m64

# Shared object g++ flags
SO_FLAGS = -fPIC -c

# Default target is release 64
all: release64

# Debug target (x86)
debug32: ARCH_FLAGS := $(ARCH_FLAGS_86)
debug32: CXXFLAGS := $(DEBUG_FLAGS)
debug32: DELIVERY_DIR := $(TOP)/debug/lib
debug32: LIBRARY_PATH := $(DELIVERY_DIR)/$(SO_NAME)_32
debug32: $(OBJS) $(LIBRARY)
	@echo "Build completed for Debug (x86)"

# Debug target (x64)
debug64: ARCH_FLAGS := $(ARCH_FLAGS_64)
debug64: CXXFLAGS := $(DEBUG_FLAGS)
debug64: DELIVERY_DIR := $(TOP)/debug/lib
debug64: LIBRARY_PATH := $(DELIVERY_DIR)/$(SO_NAME)_64
debug64: $(OBJS) $(LIBRARY)
	@echo "Build completed for Debug (x64)"

# Release target (x86)
release32: ARCH_FLAGS := $(ARCH_FLAGS_86)
release32: CXXFLAGS := $(RELEASE_FLAGS)
release32: DELIVERY_DIR := $(TOP)/release/lib
release32: LIBRARY_PATH := $(DELIVERY_DIR)/$(SO_NAME)_32
release32: $(OBJS) $(LIBRARY)
	@echo "Build completed for Release (x86)"

# Release target (x64)
release64: ARCH_FLAGS := $(ARCH_FLAGS_64)
release64: CXXFLAGS := $(RELEASE_FLAGS)
release64: DELIVERY_DIR := $(TOP)/release/lib
release64: LIBRARY_PATH := $(DELIVERY_DIR)/$(SO_NAME)_64
release64: $(OBJS) $(LIBRARY)
	@echo "Build completed for Release (x64)"

# Rule to build object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(ARCH_FLAGS) $(SO_FLAGS) -c $< -o $@ -I $(INCLUDE_DIR)

# Rule to build the executable
$(LIBRARY): $(OBJS)
	@mkdir -p $(DELIVERY_DIR)
	$(CXX) $(CXXFLAGS) $(ARCH_FLAGS) -shared $^ -o $(LIBRARY_PATH).so -lstdc++ --entry main
	ar rvs $(LIBRARY_PATH).a $^

# Clean object files
cleanobj:
	rm -rf $(OBJ_DIR)

# Clean target
clean: cleanobj
	rm -rf $(TOP)/release
	rm -rf $(TOP)/debug

# Phony targets
.PHONY: all debug86 debug64 release86 release64 clean cleanobj
