## UART Basys3 Constraints File (uart_basys3.xdc)

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# ==========================================================

# Clock (100 MHz Onboard Oscillator)

# ==========================================================

set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

create_clock -period 10.000 -name sys_clk -waveform {0 5} [get_ports clk]

# ==========================================================

# Push Buttons

# ==========================================================

# BTN_CENTER -> reset

set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# BTN_LEFT -> tx_start

set_property PACKAGE_PIN W19 [get_ports tx_start]
set_property IOSTANDARD LVCMOS33 [get_ports tx_start]

# ==========================================================

# Switches (tx_data[7:0])

# ==========================================================

set_property PACKAGE_PIN V17 [get_ports {tx_data[0]}]
set_property PACKAGE_PIN V16 [get_ports {tx_data[1]}]
set_property PACKAGE_PIN W16 [get_ports {tx_data[2]}]
set_property PACKAGE_PIN W17 [get_ports {tx_data[3]}]

set_property PACKAGE_PIN W15 [get_ports {tx_data[4]}]
set_property PACKAGE_PIN V15 [get_ports {tx_data[5]}]
set_property PACKAGE_PIN W14 [get_ports {tx_data[6]}]
set_property PACKAGE_PIN W13 [get_ports {tx_data[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {tx_data[*]}]

# ==========================================================

# LEDs (rx_data[7:0])

# ==========================================================

set_property PACKAGE_PIN U16 [get_ports {rx_data[0]}]
set_property PACKAGE_PIN E19 [get_ports {rx_data[1]}]
set_property PACKAGE_PIN U19 [get_ports {rx_data[2]}]
set_property PACKAGE_PIN V19 [get_ports {rx_data[3]}]

set_property PACKAGE_PIN W18 [get_ports {rx_data[4]}]
set_property PACKAGE_PIN U15 [get_ports {rx_data[5]}]
set_property PACKAGE_PIN U14 [get_ports {rx_data[6]}]
set_property PACKAGE_PIN V14 [get_ports {rx_data[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {rx_data[*]}]

# ==========================================================

# Status LEDs

# ==========================================================

# LED8 -> tx_done

set_property PACKAGE_PIN V13 [get_ports tx_done]
set_property IOSTANDARD LVCMOS33 [get_ports tx_done]

# LED9 -> rx_valid

set_property PACKAGE_PIN V3 [get_ports rx_valid]
set_property IOSTANDARD LVCMOS33 [get_ports rx_valid]

# LED10 -> rx_busy

set_property PACKAGE_PIN W3 [get_ports rx_busy]
set_property IOSTANDARD LVCMOS33 [get_ports rx_busy]
