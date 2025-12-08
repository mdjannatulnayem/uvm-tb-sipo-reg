This repository contains a UVM-based (Universal Verification Methodology) testbench for verifying a **Serial-In-Parallel-Out (SIPO) Register** design. The testbench is structured to facilitate easy integration of UVM components and provide an efficient simulation flow using **Xilinx Vivado** tools (with `xvlog`, `xelab`, and `xsim`).

## Features

* **UVM Testbench**: Modular testbench structure with components like agents, drivers, monitors, and sequencers.
* **SIPO Register Design**: RTL description of a Serial-In-Parallel-Out Register.
* **Verification**: Various test cases and stimulus generation through UVM sequences.
* **Simulation**: Easy integration with Xilinx tools for compiling, elaborating, and simulating the design.
* **Debugging Support**: Debugging flags (`--debug all`) enabled during elaboration for easier troubleshooting.

## Directory Structure

```
.
├── docs                # Documentation files
├── filelist.f          # List of all source files for compilation
├── LICENSE             # License information
├── Makefile            # Build and simulation automation
├── README.md           # Project overview
└── src
    ├── rtl             # RTL design files
    │   └── sipo_reg.sv # SIPO register design (SystemVerilog)
    └── sim             # UVM testbench files
        ├── components  # UVM components like agent, driver, monitor, etc.
        ├── interfaces  # UVM interfaces (control/data)
        ├── objects     # UVM sequences, items, response items
        ├── tests       # UVM test cases
        └── tb_top.sv   # Top-level testbench file
```

## Requirements

To build and simulate the design, you need the following tools:

* **Xilinx Vivado**: For simulation (`xvlog`, `xelab`, and `xsim`)
* **Make**: For automation of the build process

## Getting Started

### Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/yourusername/uvm-tb-sipo-reg.git
cd uvm-tb-sipo-reg
```

### Build and Run the Simulation

Use the provided `Makefile` to automate the process of compilation, elaboration, and simulation.

1. **Clean the build directory** (optional but recommended):

   ```bash
   make clean
   ```

2. **Run the full build process** (compilation, elaboration, and simulation):

   ```bash
   make all
   ```

This will:

* Create a `build/` directory for intermediate files.
* Compile the source files.
* Elaborate the design.
* Run the simulation in non-GUI mode (`--runall`).

### Individual Targets

You can also run individual steps using the following commands:

* **Compile**: Compile the design files listed in `filelist.f`.

  ```bash
  make compile
  ```

* **Elaborate**: Elaborate the design after compilation.

  ```bash
  make elab
  ```

* **Simulate**: Run the simulation in non-GUI mode.

  ```bash
  make sim
  ```

### Simulation Output

The simulation output will be printed in the terminal. If you encounter any issues, check the logs and debug information generated during compilation.

## UVM Testbench Components

This testbench follows the UVM methodology, and the files in the `src/sim` directory are organized into the following categories:

* **Components**: The main UVM components such as `agent.sv`, `driver.sv`, `monitor.sv`, etc.
* **Interfaces**: UVM interfaces like `ctrl_intf.sv` and `data_intf.sv` for communication between components.
* **Objects**: UVM objects such as `seq_item.sv`, `rsp_item.sv`, and `seq.sv` for handling transaction-level communication.
* **Tests**: UVM test cases like `base_test.sv` and `test_1.sv` for running different simulations.
* **Top-level Testbench**: `tb_top.sv` is the top-level testbench file that connects all the components and interfaces.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Documentation

Further documentation can be found in the `docs/` directory. This includes detailed descriptions of the design specification and more.

## Contributing

Feel free to fork this project and submit pull requests for improvements. Please ensure that tests pass and that new features are well-documented.

## Contact

For any questions or feedback, please contact the repository maintainer:

* Name: Md. Jannatul Nayem
* Email: nayemalimran106@gmail.com




