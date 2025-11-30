# UVM Testbench for SIPO Register

## Overview

This repository contains a **Universal Verification Methodology (UVM)** testbench for verifying a **Serial-In Parallel-Out (SIPO) Register** implemented in SystemVerilog.

The environment is built to run seamlessly on **Xilinx Vivado 2025.x** using:

* `xvlog` — compiler
* `xelab` — elaborator
* `xsim` — simulator

The project includes a modular UVM environment with reusable components, sequences, tests, and a clean build flow using a Makefile.

---

## Features

* **Complete UVM Verification Environment**

  * Driver, Monitor, Agent, Sequencer, Scoreboard, Environment
* **SIPO Register RTL**

  * Simple and synthesizable RTL implementation
* **Parameterized UVM Sequences & Tests**
* **Vivado-Compatible Simulation Flow**

  * Uses `xvlog → xelab → xsim`
  * UVM library linking with `-L uvm`
* **Makefile Automation**

  * Clean, compile, elaborate, simulate
* **Debug & Waveform Ready**

  * Can extend to GUI runs with `xsim --gui`

---

## 📂 Directory Structure

```
.
├── docs/                 # Documentation and specs
│   └── rtl_spec.md
├── filelist.f            # All RTL + TB files for compilation
├── LICENSE               # Project license
├── Makefile              # Build + simulation automation
├── README.md             # Project overview (this file)
└── src/
    ├── rtl/              # RTL design
    │   └── sipo_reg.sv
    └── sim/              # UVM testbench
        ├── components/   # Driver, monitor, agent, env, scoreboard, sequencer
        ├── interfaces/   # ctrl_intf.sv / data_intf.sv
        ├── objects/      # seq_item, rsp_item, sequences
        ├── tests/        # base_test, test_1
        └── tb_top.sv     # Top-level SystemVerilog testbench
```

---

## Requirements

To build and run simulations:

* **Xilinx Vivado 2020.2+** (tested on Vivado 2025)
* **GNU Make**
* A Unix-like shell (Linux/macOS/WSL recommended)

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/yourusername/uvm-tb-sipo-reg.git
cd uvm-tb-sipo-reg
```

---

## ▶️ Running Simulation

This project provides a Makefile for a clean Vivado workflow.

### **Recommended: Full Build Flow**

```bash
make all
```

This performs:

1. `clean` – remove stale caches (`build/`, `xsim.dir/`, logs)
2. `compile` – run `xvlog` using `filelist.f`
3. `elab` – elaborate the testbench in Vivado UVM mode
4. `sim` – run `xsim` in non-GUI mode

---

### 🧩 Individual Steps

**Compile RTL + TB:**

```bash
make compile
```

**Elaborate:**

```bash
make elab
```

**Simulate (console):**

```bash
make sim
```

---

## UVM Testbench Structure

The verification environment follows a standard UVM hierarchy:

### Components

| Component       | Description                                   |
| --------------- | --------------------------------------------- |
| **Driver**      | Converts sequence items to pin-level activity |
| **Monitor**     | Observes DUT outputs and gathers transactions |
| **Sequencer**   | Controls stimulus ordering                    |
| **Agent**       | Bundles driver, monitor, sequencer            |
| **Scoreboard**  | Checks correctness of DUT output              |
| **Environment** | Instantiates and connects all components      |

### Objects

* `seq_item.sv` – transaction class
* `rsp_item.sv` – response object
* `seq.sv` – UVM sequence

### Tests

* `base_test.sv` – UVM test configuration
* `test_1.sv` – Example test sequence

---

## 📝 Documentation

Detailed documentation is available under:

```
docs/rtl_spec.md
```

This includes RTL behavior and verification approach.

---

## 🛠️ Contributing

Contributions are welcome!
Feel free to:

* open issues
* submit pull requests
* propose new test cases or features

Make sure that:

* code is well formatted
* tests pass
* documentation is updated accordingly

---

## 📄 License

This project is licensed under the **MIT License**.
See the `LICENSE` file for details.

---

## 📬 Contact

**Md. Jannatul Nayem**
📧 Email: *[nayemalimran106@gmail.com](mailto:nayemalimran106@gmail.com)*
🐙 GitHub: [mdjannatulnayem](https://github.com/mdjannatulnayem)
