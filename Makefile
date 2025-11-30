# Vivado Tools
XVLOG = xvlog
XELAB = xelab
XSIM  = xsim

# Build directory
BUILDDIR = build
LIB      = work

# Source file list
FILELIST = filelist.f

# Makefile Targets
.PHONY: all clean compile elab sim build

# Default target
all: clean build compile elab sim
	@echo "Build process completed."

build:
	@echo "Creating build directory."
	mkdir -p $(BUILDDIR)

compile:
	@echo "Compiling source files."
	$(XVLOG) -sv \
		-work $(BUILDDIR)/$(LIB) \
		-f $(FILELIST) \
		-L uvm \
		-d UVM_NO_DEPRECATED \
		-d UVM_OBJECT_MUST_HAVE_CONSTRUCTOR

elab:
	@echo "Elaborating design."
	$(XELAB) \
		-work $(BUILDDIR)/$(LIB) \
		tb_top -top tb_top \
		-L uvm \
		--debug typical

sim:
	@echo "Running simulation."
	$(XSIM) tb_top -runall

# Clean target
clean:
	@echo "Cleaning up build directory."
	rm -rf $(BUILDDIR)
