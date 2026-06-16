`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Module Name : UART_test_bench
// Project     : UART Transmitter and Receiver (Verilog HDL)
// Description :
//   Simulation testbench for functional verification of the UART system.
//
//   The testbench instantiates the top-level UART module and provides
//   stimulus for validating transmitter and receiver operation under
//   different scenarios.
//
// Features Verified:
//   - System reset behavior
//   - Transmission of all-zero data patterns
//   - Transmission of all-one data patterns
//   - Random data transmission
//   - Reset during active transmission
//   - Back-to-back frame transmission
//   - Invalid/partial transmission conditions
//   - Long idle-line operation
//
//   Waveforms are generated using VCD dumping for detailed timing
//   analysis and debugging.
//
// Dependencies:
//   - top_module.v
//
// Author      : M.V.S.Charith
//////////////////////////////////////////////////////////////////////////////////

module UART_test_bench #(parameter baud_rate=100000000/3);
    reg clk, reset, tx_start;
    reg [7:0] tx_data;
    wire tx_done, rx_busy, rx_valid;
    wire [7:0] rx_data;

    top_module#(.baud_rate(baud_rate)) top( .clk(clk), .reset(reset), .tx_start(tx_start), .tx_data(tx_data), .tx_done(tx_done), .rx_data(rx_data), .rx_valid(rx_valid), .rx_busy(rx_busy));
        
    initial begin
        clk = 1'b0;
    end
    always #5 clk = ~clk;
    
    initial begin
        $dumpfile("uart_test.vcd");
        $dumpvars(0, UART_test_bench);
    end
    
    initial begin
        
        $monitor($time, "tx_data=%b, tx_done=%b, rx_data=%b, rx_busy=%b, rx_valid=%b ", tx_data, tx_done, rx_data, rx_busy, rx_valid);
    
        ///*
        //Test 1: Reset + All Zero
        tx_start=1'b0; reset=1'b1;;
        #15 reset=1'b0;
        #2 tx_start=1'b1; tx_data=8'b00000000;
        #1000 $finish;
        //*/
        
        /*
        //Test 2: All Ones
        tx_start=1'b0; reset=1'b1;;
        #15 reset=1'b0;
        #2 tx_start=1'b1; tx_data=8'b11111111;
        #1000 $finish;
        */
        
        /*
        //Test 3: Random Trasmission
        tx_start=1'b0; reset=1'b1;;
        #15 reset=1'b0;
        #2 tx_start=1'b1; tx_data=8'b10110101;
        #1000 $finish;
        */
        
        /*
        //Test 4: Reset during transmission
        tx_start=1'b0; reset=1'b1;;
        #15 reset=1'b0;
        #2 tx_start=1'b1; tx_data=8'b01010101;
        #50 reset=1'b1;
        #15 reset=1'b0;
        #1000 $finish;
        */
        
        /*
        //Test 5: ALternating pattern + Back to back frames
        tx_start=1'b0; reset=1'b1;;
        #15 reset=1'b0;
        #2 tx_start=1'b1; tx_data=8'b01010101;
        #335 tx_data = 8'b00000000;
        #335 tx_data = 8'b11111111;
        #1000 $finish;
        */
        
        /*
        //Test 6: Invalid Transmission
        tx_start=1'b0; reset=1'b1;;
        #15 reset=1'b0;
        #2 tx_start=1'b1;
        #1000 $finish;
        */
        
        /*
        //Test 7: Long Idle Period
        tx_start=1'b0; reset=1'b1;;
        #15 reset=1'b0;
        #1000 $finish;
        */
        
    end
endmodule
