`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Module Name : top_module
// Project     : UART Transmitter and Receiver (Verilog HDL)
// Description :
//   Top-level integration module for the UART communication system.
//
//   This module instantiates and connects:
//
//     - Baud Rate Generator
//     - UART Transmitter
//     - UART Receiver
//
//   The transmitter converts parallel input data into a serial UART frame.
//   The receiver reconstructs the transmitted serial frame back into
//   parallel data using midpoint sampling.
//
//   For simulation and verification purposes, the transmitter serial output
//   is internally looped back to the receiver input, enabling complete
//   end-to-end UART functionality testing without external hardware.
//
// Features:
//   - Integrated TX and RX communication path
//   - Shared baud timing generation
//   - Internal loopback verification
//   - End-to-end UART frame transmission and reception
//
// Dependencies:
//   - baud_rate_generator.v
//   - UART_transmitter.v
//   - UART_receiver.v
//
// Author      : M.V.S.Charith
//////////////////////////////////////////////////////////////////////////////////

module top_module#(parameter baud_rate=9600)(
    input clk,
    input reset,
    input tx_start,
    input [7:0] tx_data,
    output tx_done,
    output [7:0] rx_data,
    output rx_valid,
    output rx_busy
    );
    
    wire mid_tick, mid_detect, baud_tick, tx_serial_out;  
    
    baud_rate_generator #(.baud_rate(baud_rate)) baud_gen(.clk(clk), .reset(reset), .mid_detect(mid_detect), .mid_tick(mid_tick), .baud_tick(baud_tick));
    UART_transmitter tx(.clk(clk), .reset(reset), .baud_tick(baud_tick), .tx_start(tx_start), .tx_data(tx_data), .tx_serial_out(tx_serial_out), .tx_done(tx_done));
    UART_receiver rx(.clk(clk), .reset(reset), .baud_tick(baud_tick), .rx_serial_in(tx_serial_out), .mid_tick(mid_tick), .mid_detect(mid_detect), .rx_data(rx_data), .rx_busy(rx_busy), .rx_valid(rx_valid));
    
endmodule
