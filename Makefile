# Compiler, Elaborator, Simulator
XVLOG = xvlog
XELAB = xelab
XSIM = xsim

# Directory for build files
BUILDDIR = build

# File list
FILELIST = filelist.f

# Target for clean up and rebuilding
.PHONY: clean compile elab sim build

# Clean up build directory
clean:
	@echo "Cleaning up build directory."
	rm -rf $(BUILDDIR)

# Create build directory if it doesn't exist
build:
	@echo "Creating build directory."
	mkdir -p $(BUILDDIR)

# Compilation step using filelist.f 
compile: build
	@echo "Compiling source files."
	$(XVLOG) -sv -work $(BUILDDIR) -f $(FILELIST) -debug all

# Elaboration step (no debug flag needed)
elab: compile
	@echo "Elaborating design."
	$(XELAB) -work $(BUILDDIR) tb_top -top tb_top

# Simulation step (non-GUI mode)
sim: elab
	@echo "Running simulation in non-GUI mode."
	$(XSIM) $(BUILDDIR).tb_top -run all

# Target to run the full build process: clean, compile, elaborate, and simulate
all: clean build compile elab sim
	@echo "Build process completed."