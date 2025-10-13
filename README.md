ALU Verilog Project
===================

Overview
--------
This repository contains a small 4-bit ALU implemented in Verilog along with several testbenches and VCD waveforms. The codebase is intended for simulation with Icarus Verilog (iverilog + vvp) and waveform inspection with GTKWave on Windows (PowerShell examples provided).

Top-level design
-----------------
- `alu.v`
  - Top-level ALU module.
  - Ports:
    - outputs: `R[3:0]` (result), `zero`, `carry`, `sign`
    - inputs: `A[3:0]`, `B[3:0]`, `c_in`, `Op[2:0]`
  - Instantiates `preprocess`, `sum4_v2`, `ul4`, and a `mux2_4` to select between arithmetic and logic outputs.

Modules and purpose
-------------------
- `preprocess.v` (module `preprocess`)
  - Prepares operands `AMod` and `BMod` from raw inputs `A`, `B` and the operation code `Op[2:0]`.
  - Implements control signals derived from `Op`: `ADD1`, `OP1_A`, `OP2_B`, `CPL` (internally `reg`s driven by a combinational `always @(*)` case).
  - Instantiates small helper units: `mux2_4` for selecting constants or inputs, and `compl1` for ones/twos complement behavior.
  - NOTE: During testing we observed a mismatch between an assumed truth-table and the actual behavior for some `Op` values (see `testbench/preprocess_tb.v` and VCD). If the test expectations differ from your intended specification, adjust either `preprocess.v` (control mapping or mux inputs) or the tests.

- `sum4_v2.v` (module `sum4_v2`)
  - 4-bit adder with carry in/out. Used to perform arithmetic operations when selecting the adder path.

- `ul4.v` (module `ul4`)
  - 4-bit logical unit. Instantiates per-bit combinational cell `cl.v` for bitwise AND/OR/XOR/NOT operations controlled by `Op[1:0]`.

- `cl.v` (module `cl`)
  - Single-bit combinational logic cell. Uses `mux4_1` to select among logic functions based on select bits.

- `mux2_4.v` (module `mux2_4`)
  - 2:1 multiplexer for 4-bit buses. Continuous `assign` used: `Out = s ? B : A;`.

- `mux4_1.v` (module `mux4_1`)
  - 4:1 multiplexer used by `cl` to choose the logical function output per bit.

- `comp11.v` (module `compl1`)
  - Complement unit. In this repository it implements the behavior currently observed in tests (one's complement or two's complement depending on file version). Testbenches assume the actual implemented behavior; update the module if a different complement type is required.

Testbenches and waveforms
-------------------------
All testbenches are under the `testbench/` directory and generate VCD files under `vcd/`.

Important testbenches:
- `testbench/alu_tb.v` — exhaustive ALU test over A=0..15, B=0..15, Op=0..7, c_in=0..1. Generates `vcd/alu_tb.vcd`. Checks `zero` and `sign` consistency; reports a final count of checks and errors.
- `testbench/preprocess_tb.v` — simplified preprocess test. Current version fixes `A = 3'b001` and `B = 3'b010` and iterates `Op`. Generates `vcd/preprocess_tb.vcd`. Use it to inspect `AMod`/`BMod` derivation.
- `testbench/compl1_exhaustive_tb.v` — exhaustive test for `compl1` (Inp=0..15).
- Additional testbenches: `testbench/mux2_4_tb.v`, `testbench/ul4_tb.v`, etc.

How to run (PowerShell examples)
--------------------------------
Open PowerShell in the repository root (where `*.v` files are). Example compile & run commands:

- Compile and run the ALU testbench:
```powershell
iverilog -o vvp_alu_tb.exe testbench/alu_tb.v alu.v preprocess.v sum4_v2.v ul4.v mux2_4.v mux4_1.v cl.v comp11.v
vvp vvp_alu_tb.exe
```
- Open the generated VCD in GTKWave:
```powershell
gtkwave vcd/alu_tb.vcd
```

Repository layout
-----------------
- Top-level Verilog sources: `*.v` in repository root (e.g., `alu.v`, `preprocess.v`, `sum4_v2.v`, ...)
- `testbench/` — testbench sources
- `vcd/` — generated waveform files
