`timescale 1ns / 1ps
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name : UART_receiver
// Project     : UART Transmitter and Receiver (Verilog HDL)
// Description :
//   Implements an 8-bit UART receiver using a finite state machine (FSM).
//   The receiver converts a serial UART frame into parallel data.
//
//   Reception format:
//
//     - 1 Start Bit  (Logic 0)
//     - 8 Data Bits  (LSB First)
//     - 1 Stop Bit   (Logic 1)
//
//   Data sampling is performed using a midpoint sampling pulse (mid_tick)
//   to improve sampling alignment within each received bit period.
//   State transitions are controlled by baud_tick.
//
// Features:
//   - Falling-edge start bit detection
//   - Mid-bit data sampling
//   - LSB-first data reconstruction
//   - Frame reception status indication
//   - rx_valid pulse upon successful frame completion
//
// Dependencies:
//   - baud_rate_generator.v
//   - UART_transmitter.v
//
// Author      : M.V.S.Charith
//////////////////////////////////////////////////////////////////////////////////

module UART_receiver(
    input clk,
    input reset,
    input baud_tick,
    input rx_serial_in,
    input mid_tick,
    output mid_detect,
    output [7:0] rx_data,
    output rx_busy,
    output rx_valid
);
    
    parameter IDLE=0, DATA_BITS=1, STOP=2, WAIT_STOP=3, DONE=4;
    reg [2:0] state, next_state;
    
    reg [7:0] out_reg;
    reg busy_reg;
    reg mid_detect_reg;
    
    reg in_reg;
    
    reg [2:0] count; 
    
    always @(*) begin
        case(state)
            IDLE: next_state = (~rx_serial_in)? DATA_BITS: IDLE;
            DATA_BITS: next_state = (count!=3'd7)? DATA_BITS: (rx_serial_in)? STOP: WAIT_STOP;
            STOP: next_state = DONE;
            WAIT_STOP: next_state = (rx_serial_in)? DONE: WAIT_STOP;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            out_reg <= 8'b0;
            busy_reg <= 1'b0;
            count <= 3'd0;
            mid_detect_reg <= 1'b0;
            in_reg <= 1'b0;
            state <= IDLE;
        end else begin
            in_reg <= rx_serial_in;
            
            if(state==IDLE && ~rx_serial_in && in_reg)
                mid_detect_reg <= 1'b1;
            else
                mid_detect_reg <= 1'b0;
                
            if(next_state!=DONE) begin
                if(baud_tick) begin
                    state <= next_state;
                    if(next_state==DATA_BITS && state!=DATA_BITS) begin
                        count <= 3'd0;
                        busy_reg <= 1'b0;
                    end else if(state==DATA_BITS) begin
                        count <= count+1;
                        busy_reg <= 1'b1;   
                    end else begin
                        count <= 3'd0;
                        busy_reg <= 1'b0;
                    end
                        
                end else if(mid_tick) begin
                    if(next_state==DATA_BITS && state!=DATA_BITS)
                        out_reg <= 8'd0;
                    else if(state==DATA_BITS)
                        out_reg[count] <= rx_serial_in; 
                end
                    
            end else begin
                state <= next_state;
            end  
        end
    end
    
    assign mid_detect = mid_detect_reg;
    assign rx_data = out_reg;
    assign rx_busy = busy_reg;
    assign rx_valid = (state==DONE);
    
endmodule
