# Specify the compiler
CXX := g++

# Directories
SRC_DIR := ./
OBJ_DIR := obj
BIN_DIR := bin
INCLUDE_DIR := $(SRC_DIR)/shared_object_example/include

# Subdirs in order they are expected to be produced.
SUBDIRS := $(SRC_DIR)/shared_object_example

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

# Variables
COMMON_FLAGS := -L$(LIB_ARCH_DIR) -lstdc++
DEBUG_TARGETS := debug32 debug64
RELEASE_TARGETS := release32 release64

# Default target is release 64
all: release64

# Debug targets
$(DEBUG_TARGETS):
	$(eval ARCH_FLAGS := $(if $(filter $@, debug32), $(ARCH_FLAGS_86), $(ARCH_FLAGS_64)))
	$(eval CXXFLAGS := $(DEBUG_FLAGS))
	$(eval BIN_ARCH_DIR := debug/bin)
	$(eval LIB_ARCH_DIR := debug/lib)
	$(eval BITNESS_SUFFIX := $(if $(filter $@, debug32), _32, _64))
	$(eval EXE_PATH := $(BIN_ARCH_DIR)/$(PROG_NAME)$(BITNESS_SUFFIX))

	@$(MAKE) -C $(SUBDIRS) $(if $(filter $@, debug32), debug32, debug64)
	@mkdir -p $(BIN_ARCH_DIR)
	$(CXX) $(CXXFLAGS) $(ARCH_FLAGS) -c $(SRCS) -o $@ -I $(INCLUDE_DIR)
	$(CXX) -w $(CXXFLAGS) $(ARCH_FLAGS) $(OBJS) -o $(EXE_PATH) -L$(LIB_ARCH_DIR) -l:shared_object_example$(BITNESS_SUFFIX).a $(COMMON_FLAGS)
	@echo "Build completed for $@"

# Release targets
$(RELEASE_TARGETS):
	$(eval ARCH_FLAGS := $(if $(filter $@, release32), $(ARCH_FLAGS_86), $(ARCH_FLAGS_64)))
	$(eval CXXFLAGS := $(RELEASE_FLAGS))
	$(eval BIN_ARCH_DIR := release/bin)
	$(eval LIB_ARCH_DIR := release/lib)
	$(eval BITNESS_SUFFIX := $(if $(filter $@, release32), _32, _64))
	$(eval EXE_PATH := $(BIN_ARCH_DIR)/$(PROG_NAME)$(BITNESS_SUFFIX))

	@$(MAKE) -C $(SUBDIRS) $(if $(filter $@, release32), release32, release64)
	@mkdir -p $(BIN_ARCH_DIR)
	$(CXX) $(CXXFLAGS) $(ARCH_FLAGS) -c $(SRCS) -o $@ -I $(INCLUDE_DIR)
	$(CXX) -w $(CXXFLAGS) $(ARCH_FLAGS) $(OBJS) -o $(EXE_PATH) -L$(LIB_ARCH_DIR) -l:shared_object_example$(BITNESS_SUFFIX).a $(COMMON_FLAGS)
	@echo "Build completed for $@"

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
