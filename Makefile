# Vivado Tools
XVLOG = xvlog
XELAB = xelab
XSIM  = xsim

# Build directory
BUILDDIR = build
WORKDIR  = $(BUILDDIR)/work

# Source file list
SRC_FILELIST = filelist.f         # original filelist.f in root
BUILD_FILELIST = $(BUILDDIR)/filelist.f  # generated filelist for build/

# Default test name
DEFAULT_TEST = test_1

# Test name from argument or use default
TEST_NAME ?= $(DEFAULT_TEST)

# Makefile Targets
.PHONY: all clean build compile elab sim

# Default target
all: clean build compile elab sim
	@echo "Build process completed."

# Create build directories and generate build filelist
build:
	@echo "Creating build directories..."
	mkdir -p $(WORKDIR)
	@echo "Generating build filelist..."
# Prepend '../' only to lines NOT starting with '#' and not empty
	@awk '{if($$0 ~ /^#/ || $$0 ~ /^$$/) print $$0; else print "../"$$0}' $(SRC_FILELIST) > $(BUILD_FILELIST)

# Compile source files inside build/
compile:
	@echo "Compiling source files..."
	cd $(BUILDDIR) && $(XVLOG) -sv -L uvm -f filelist.f

# Elaborate design inside build/
elab:
	@echo "Elaborating design..."
	cd $(BUILDDIR) && $(XELAB) -timescale 1ns/1ps -L uvm -debug all -top tb_top

# Run simulation inside build/
sim:
	@echo "Running simulation with test: $(TEST_NAME)..."
	cd $(BUILDDIR) && $(XSIM) work.tb_top -runall --testplusarg "TEST=$(TEST_NAME)"

# Clean build directory
clean:
	@echo "Cleaning up build directory..."
	rm -rf $(BUILDDIR)
