# **SIPO Register (Serial-In Parallel-Out) Module Specification**

## **Overview**

The `sipo_reg` module is a Serial-In Parallel-Out (SIPO) register designed to shift serial data into a parallel register. This module can shift data either left or right based on a parameter, and it provides a parallel output that can be accessed when the write enable (`we`) signal is low.

## **Parameters**

* **SHIFT_LEFT (default: 1)**
  This parameter controls the direction of the shift.

  * `1`: Shifts data left (serial input is inserted at the least significant bit).
  * `0`: Shifts data right (serial input is inserted at the most significant bit).

* **DATA_WIDTH (default: 32)**
  This parameter defines the width of the shift register and the parallel output. The register will hold `DATA_WIDTH` bits.

## **Ports**

* **clk (input logic)**
  The clock signal driving the shifting operation.

* **arst_n (input logic)**
  Asynchronous active-low reset. When low, the shift register is reset to zero.

* **serial_in (input logic)**
  The serial data input to the shift register. Data is shifted into the register on each clock cycle when `we` is high.

* **we (input logic)**
  Write enable signal. When high, the register shifts data based on `serial_in` and `SHIFT_LEFT` setting. When low, the register holds its current value and the parallel output reflects the register contents.

* **parallel_out (output logic [DATA_WIDTH-1:0])**
  The parallel output of the register. This output reflects the contents of the shift register, except when `we` is high, in which case it is driven to `'0`.

## **Behavior**

1. **Reset Behavior**:
   On the rising edge of `clk` or the falling edge of `arst_n`, if `arst_n` is low, the shift register (`shift_reg`) is asynchronously cleared to zero.

2. **Shifting Behavior**:

   * When `we` is high, the serial data (`serial_in`) is shifted into the register.
   * If `SHIFT_LEFT` is set to `1`, the data is shifted left, and the new bit enters at the least significant bit (LSB).
   * If `SHIFT_LEFT` is set to `0`, the data is shifted right, and the new bit enters at the most significant bit (MSB).

3. **Parallel Output**:
   The `parallel_out` signal is driven by the value of the shift register.

   * When `we` is low, the `parallel_out` reflects the value of `shift_reg`.
   * When `we` is high, `parallel_out` is forced to `'0`.

## **Example Usage**

```verilog
sipo_reg #(
    .SHIFT_LEFT(1),       // Shift left (default)
    .DATA_WIDTH(16)       // 16-bit wide register
) sipo_instance (
    .clk(clk),
    .arst_n(arst_n),
    .serial_in(serial_in),
    .we(write_enable),
    .parallel_out(parallel_out)
);
```
