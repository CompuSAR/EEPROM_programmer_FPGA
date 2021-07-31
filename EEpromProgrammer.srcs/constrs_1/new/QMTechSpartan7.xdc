set_property PACKAGE_PIN N10 [get_ports serial_tx]
#set_property IOSTANDARD LVCMOS33 [get_ports serial_tx]
# Incorrect value 5v0 so we can drive the EEPROM. The CP2102 can handle it, however
set_property IOSTANDARD LVTTL [get_ports serial_tx]

set_property PACKAGE_PIN P10 [get_ports serial_rx]
set_property IOSTANDARD LVCMOS33 [get_ports serial_rx]

#set_property PACKAGE_PIN E11 [get_ports led2]
#set_property IOSTANDARD LVCMOS33 [get_ports led2]
#set_property PACKAGE_PIN M10 [get_ports led3]
#set_property IOSTANDARD LVCMOS33 [get_ports led3]

# Top row pins, left to right
set_property PACKAGE_PIN A10 [get_ports eeprom_address[14]]
set_property PACKAGE_PIN A13 [get_ports eeprom_address[12]]
set_property PACKAGE_PIN B14 [get_ports eeprom_address[7]]
set_property PACKAGE_PIN C14 [get_ports eeprom_address[6]]
set_property PACKAGE_PIN D13 [get_ports eeprom_address[5]]
set_property PACKAGE_PIN E12 [get_ports eeprom_address[4]]
set_property PACKAGE_PIN E13 [get_ports eeprom_address[3]]
set_property PACKAGE_PIN F14 [get_ports eeprom_address[2]]
set_property PACKAGE_PIN F11 [get_ports eeprom_address[1]]
set_property PACKAGE_PIN J14 [get_ports eeprom_address[0]]
set_property PACKAGE_PIN K12 [get_ports eeprom_data[0]]
set_property PACKAGE_PIN L13 [get_ports eeprom_data[1]]
set_property PACKAGE_PIN L14 [get_ports eeprom_data[2]]

# Bottom row pins, left to right
set_property PACKAGE_PIN B10 [get_ports eeprom_nWE]
set_property PACKAGE_PIN A12 [get_ports eeprom_address[13]]
set_property PACKAGE_PIN B13 [get_ports eeprom_address[8]]
set_property PACKAGE_PIN D14 [get_ports eeprom_address[9]]
set_property PACKAGE_PIN D12 [get_ports eeprom_address[11]]
set_property PACKAGE_PIN F12 [get_ports eeprom_nOE]
set_property PACKAGE_PIN F13 [get_ports eeprom_address[10]]
set_property PACKAGE_PIN G14 [get_ports eeprom_nCE]
set_property PACKAGE_PIN G11 [get_ports eeprom_data[7]]
set_property PACKAGE_PIN J13 [get_ports eeprom_data[6]]
set_property PACKAGE_PIN K11 [get_ports eeprom_data[5]]
set_property PACKAGE_PIN L12 [get_ports eeprom_data[4]]
set_property PACKAGE_PIN M13 [get_ports eeprom_data[3]]
set_property IOSTANDARD LVTTL [get_ports eeprom_*]





set_property PACKAGE_PIN H13 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]
create_clock -period 20.000 -name sysClk -waveform  {0.000 10.000} [get_ports sys_clk]

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]