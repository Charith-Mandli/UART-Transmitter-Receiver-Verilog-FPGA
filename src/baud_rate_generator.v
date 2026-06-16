`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Module Name : baud_rate_generator
// Project     : UART Transmitter and Receiver (Verilog HDL)
// Description :
// Generates baud-rate timing pulses for UART communication.
//
// Functionality:
// - Generates periodic baud_tick pulses used for UART state transitions.
// - Generates mid_tick pulses used for midpoint data sampling in the
//   UART receiver.
// - Supports synchronization of midpoint timing through mid_detect.
//
// Inputs:
// - clk        : System clock.
// - reset      : Active-high synchronous reset.
// - mid_detect : Synchronization trigger generated upon start-bit detection.
//
// Outputs:
// - baud_tick  : Baud-rate timing pulse.
// - mid_tick   : Midpoint sampling pulse for UART reception.
//
// Notes:
// - Designed for simulation and FPGA implementation.
// - COUNT_STOP is derived from the system clock frequency and selected
//   baud rate.
// - Midpoint timing is aligned after start-bit detection and is used
//   exclusively by the receiver for data sampling.
//
// Author: M.V.S.Charith
//////////////////////////////////////////////////////////////////////////////////

module baud_rate_generator #(parameter baud_rate=9600)(
    input clk,
    input reset,
    input mid_detect,
    output mid_tick,
    output baud_tick
    );
    
    parameter COUNT_STOP=100000000/baud_rate;
    
    reg [$clog2(COUNT_STOP)-1:0] count_baud, count_mid;
    reg baud_tick_reg; 
    reg mid_tick_reg;
    reg mid_flag;
    
    always @(posedge clk) begin
        if(reset) begin
            count_baud <= 0;
            baud_tick_reg <= 1'b0;
        end else begin
            if(count_baud==COUNT_STOP-1) begin
                count_baud <= 0;
                baud_tick_reg <= 1'b1;
            end else begin
                count_baud <= count_baud+1;
                baud_tick_reg <= 1'b0;
            end
        end
    end
    
    always @(posedge clk) begin
        if(reset) begin
            count_mid <= 0;
            mid_tick_reg <= 1'b0;
            mid_flag <= 1'b0;
        end else begin
            if(mid_detect) begin
                count_mid <= 0;
                mid_flag <= 1'b1;
            end else if(~baud_tick&&mid_flag) begin
                count_mid <= count_mid+1;
            end else
                count_mid <= 0;
                
            if(mid_flag&&((count_mid==COUNT_STOP/2-1))) begin
                mid_tick_reg <= 1'b1;
            end else begin
                mid_tick_reg <= 1'b0;
            end
        end
    end
    
    assign baud_tick = baud_tick_reg;
    assign mid_tick = mid_tick_reg;
    
endmodule
