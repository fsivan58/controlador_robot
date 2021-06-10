set_property PACKAGE_PIN N11 [get_ports CLK_FPGA]
set_property IOSTANDARD LVCMOS33 [get_ports CLK_FPGA]


set_property PACKAGE_PIN T7 [get_ports led_m_l]
set_property PACKAGE_PIN R8 [get_ports led_m_r]

set_property IOSTANDARD LVCMOS33 [get_ports led_m_r]
set_property IOSTANDARD LVCMOS33 [get_ports led_m_l]


set_property PACKAGE_PIN L13 [get_ports motor_left]
set_property PACKAGE_PIN N12 [get_ports motor_right]
set_property IOSTANDARD LVCMOS33 [get_ports motor_right]
set_property IOSTANDARD LVCMOS33 [get_ports motor_left]


set_property PACKAGE_PIN B7 [get_ports sw_start]
set_property IOSTANDARD LVCMOS33 [get_ports sw_start]

set_property PACKAGE_PIN T13 [get_ports echo_front]
set_property PACKAGE_PIN R13 [get_ports trig_front]
