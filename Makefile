# Compiler, Elaborator, Simulator
XVLOG = xvlog
XELAB = xelab
XSIM = xsim

# Directory for build files
BUILDDIR = build

# File list
FILELIST = filelist.f

# Target for clean up and rebuilding
.PHONY: all clean compile elab sim build

# Target to run the full build process: clean, compile, elaborate, and simulate
all: clean build compile elab sim
	@echo "Build process completed."

# Compilation step using filelist.f 
compile: build
	@echo "Compiling source files."
	$(XVLOG) -sv -work $(BUILDDIR) -f $(FILELIST)

# Elaboration step (debug flag supported here)
elab: compile
	@echo "Elaborating design."
	$(XELAB) -work $(BUILDDIR) tb_top -top tb_top --debug all

# Simulation step (non-GUI mode)
sim: elab
	@echo "Running simulation in non-GUI mode."
	$(XSIM) tb_top -runall

# Create build directory if it doesn't exist
build:
	@echo "Creating build directory."
	mkdir -p $(BUILDDIR)

# Clean up build directory
clean:
	@echo "Cleaning up build directory."
	rm -rf $(BUILDDIR)
