# UART Transmitter and Receiver using Verilog HDL

## Overview

This project implements a complete **UART (Universal Asynchronous Receiver Transmitter)** communication system using **Verilog HDL** and demonstrates the complete FPGA design workflow using **Xilinx Vivado**.

The design consists of a parameterized **Baud Rate Generator**, an FSM-based **UART Transmitter**, an FSM-based **UART Receiver**, and a top-level loopback integration module. The receiver employs midpoint sampling to reliably reconstruct serial data transmitted by the UART transmitter.

The project was successfully simulated, synthesized, implemented, and verified for FPGA deployment using the **Xilinx Artix-7 FPGA** platform.

---

## Target FPGA

* FPGA Family : Xilinx Artix-7
* Device       : xc7a35tcpg236-1
* Development Board : Basys 3
* Toolchain    : Vivado 2024.x

---

## Features

* FSM-based UART transmitter
* FSM-based UART receiver
* Parameterized baud rate generator
* Midpoint sampling based data reception
* Serial-to-parallel data reconstruction
* Parallel-to-serial data transmission
* Loopback communication verification
* Modular Verilog implementation
* Behavioral simulation and waveform verification
* FPGA synthesis and implementation flow
* Timing and resource utilization analysis
* Complete FPGA constraints and pin mapping

---

## Working Principle

UART communication transfers data serially using a predefined frame structure consisting of:

* One Start Bit
* Eight Data Bits
* One Stop Bit

The transmitter converts parallel input data into a serial stream, while the receiver reconstructs the original byte by sampling the incoming serial data at the midpoint of each bit period.

### UART Frame Format

```text
Idle | Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop
  1      0      LSB -----------------------------> MSB   1
```

### Communication Flow

```text
Parallel Data
      ↓
UART Transmitter
      ↓
Serial Data Stream
      ↓
UART Receiver
      ↓
Recovered Parallel Data
```

---

## Project Structure

```text
UART-Transmitter-Receiver-Verilog/
│
├── src/
│   ├── baud_rate_generator.v
│   ├── UART_transmitter.v
│   ├── UART_receiver.v
│   └── top_module.v
│
├── sim/
│   └── UART_test_bench.v
│   └── UART_test_bench_behav.wcfg
│
├── constraints/
│   └── constraints.xdc
│
├── docs/
│   ├── UART_Project_Report.pdf
│   ├── Architecture_Diagram.png
│   ├── Baud_Generator_Block_Diagram.png
│   ├── UART_TX_FSM.png
│   ├── UART_RX_FSM.png
│   ├── System_Architecture.png
│   └── Results/
│
├── vivado_reports/
│
├── README.md
├── LICENSE
└── .gitignore
```

---

## RTL Modules

| Module                | Function                                             |
| --------------------- | ---------------------------------------------------- |
| `baud_rate_generator` | Generates baud tick and midpoint sampling tick       |
| `UART_transmitter`    | Serializes parallel data using UART protocol         |
| `UART_receiver`       | Reconstructs received serial data                    |
| `top_module`          | Integrates baud generator, transmitter, and receiver |
| `UART_test_bench`     | Functional verification environment                  |

---

## FSM States Implemented

### UART Transmitter FSM

| State     | Description                    |
| --------- | ------------------------------ |
| IDLE      | Waits for transmission request |
| START     | Transmits start bit            |
| DATA_BITS | Serially transmits 8 data bits |
| STOP      | Transmits stop bit             |
| DONE      | Indicates frame completion     |

### UART Receiver FSM

| State     | Description                    |
| --------- | ------------------------------ |
| IDLE      | Waits for start bit detection  |
| DATA_BITS | Samples incoming data bits     |
| STOP      | Valid stop bit detected        |
| WAIT_STOP | Waits for stop bit if delayed  |
| DONE      | Indicates successful reception |

---

## Verification

The design was verified using multiple functional test scenarios.

### Test Cases Performed

* Initial reset verification
* All-zero transmission
* All-one transmission
* Random data transmission
* Alternating bit pattern transmission
* Back-to-back frame transmission
* Reset during transmission
* Invalid transmission scenario
* Long idle period verification
* Complete TX-RX loopback verification

### Verification Results

Functional verification confirmed:

* Correct UART frame generation
* Correct start and stop bit handling
* Proper LSB-first transmission
* Accurate midpoint sampling
* Correct serial-to-parallel reconstruction
* Stable reset behavior
* Successful loopback communication
* Correct FSM state transitions

Detailed simulation observations are available in the project report.

```text
docs/UART_TX_RX_Project_Report.pdf
```
---

## FPGA Design Flow

The project successfully completed the following Vivado stages:

* Behavioral Simulation
* RTL Elaboration
* Synthesis
* Placement
* Routing
* Timing Analysis
* Design Rule Check (DRC)
* Bitstream Generation

---

## Tools Used

* Verilog HDL
* Xilinx Vivado 2024.x
* Vivado Simulator
* Basys 3 FPGA Board
* Artix-7 FPGA Series

---

## Resource Utilization and Timing

The implemented design achieved successful FPGA implementation with:

* Successful synthesis completion
* Successful routing completion
* Positive timing analysis
* Valid FPGA pin mapping
* Successful bitstream generation

Detailed synthesis and timing reports are available in:

```text
vivado_reports/
```

---

## Results

### 1. Overall System Architecture

<img width="1536" height="1024" alt="System Architecture" src="https://github.com/user-attachments/assets/47d2628c-3e37-4459-8858-af4abf842bf4" />

*Figure 1. Overall UART System Architecture showing data flow between baud generator, transmitter, and receiver.*

---

### 2. UART Transmitter FSM State Diagram

<img width="1536" height="1024" alt="TX State Transition Diagram" src="https://github.com/user-attachments/assets/701fa101-f08b-4e4f-bc6a-1e55cf00d959" />

*Figure 2. UART transmitter finite state machine.*

---

### 3. Random Data Transmission

<img width="1556" height="546" alt="Test - Random data" src="https://github.com/user-attachments/assets/94cf00bc-b25b-4166-9a3a-c290db8e407b" />

*Figure 3. Successful UART transmission and reception waveform.*

---

### 4. Reset During Transmission Verification

<img width="1080" height="535" alt="Test - Reset during transmission" src="https://github.com/user-attachments/assets/60d0d41c-4809-47c6-a50e-e9fd0dfee6e0" />

*Figure 4. UART behavior during asynchronous reset.*

---

### 5. Back-to-Back Frame Verification

<img width="1557" height="536" alt="Test - Back to back frames" src="https://github.com/user-attachments/assets/94dc8c9a-7046-450c-9708-64770124f560" />

*Figure 5. Consecutive UART frame transmission verification.*

---

### 6. Implemented Design

<img width="1620" height="882" alt="Implemented Device" src="https://github.com/user-attachments/assets/dda790a3-4070-4046-b605-2061206e13c2" />

*Figure 6. Post-implementation device view.*

---

### 7. Resource Utilization Summary

<img width="720" height="272" alt="Utilization Summary" src="https://github.com/user-attachments/assets/ba692076-f8b5-4d4a-8de6-bf2c993ee6bd" />

*Figure 7. FPGA resource utilization summary.*

---

### 8. Timing Summary

<img width="1365" height="477" alt="Timing Summary" src="https://github.com/user-attachments/assets/d0ca82ac-bb15-42ec-92b1-2144155a2cb9" />

*Figure 8. Summary of Timing analysis after implementation.*

---

## Simulation Notes

For faster simulation, the baud rate parameter was overridden inside the testbench to generate baud ticks at a much higher frequency than the actual hardware configuration. This significantly reduced simulation runtime while preserving functional behavior. Before synthesis and implementation, the hardware-oriented baud rate of **9600 bps** was restored to ensure correct FPGA operation.

Example simulation override:

```verilog
baud_rate_generator #(.baud_rate(100000000/3))
```

Final hardware configuration:

```verilog
parameter baud_rate = 9600;
```

---

## Key Learnings

* UART communication protocol fundamentals
* FSM-based digital design methodology
* Serial data transmission and reception
* Midpoint sampling concepts
* Modular RTL design practices
* Functional verification using simulation
* FPGA synthesis and implementation flow
* Timing analysis and constraint handling
* Hardware-oriented debugging techniques

---

## Future Improvements

* Hardware validation using external UART devices
* Configurable data length support
* Parity bit generation and checking
* Multiple stop-bit configurations
* FIFO buffering
* Oversampling-based receiver design
* UART-to-PC communication interface
* SystemVerilog verification environment

---

## References

1. UART Communication Protocol Documentation.
2. Xilinx Vivado Design Suite User Guides.
3. Digilent Basys 3 FPGA Board Reference Manual.
4. Artix-7 FPGA Data Sheet.
5. Verilog HDL Language Reference Manual (IEEE 1364).

---

## Author

**M.V.S.Charith**

FPGA and Digital Design Enthusiast
