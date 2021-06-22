#Color
set_property PACKAGE_PIN R2 [get_ports s0]
set_property PACKAGE_PIN R3 [get_ports s1]
set_property PACKAGE_PIN R1 [get_ports s2]
set_property PACKAGE_PIN T12 [get_ports s3]
set_property PACKAGE_PIN T4 [get_ports led_c]
set_property PACKAGE_PIN T3 [get_ports fr_color]


set_property IOSTANDARD LVCMOS33 [get_ports s0]
set_property IOSTANDARD LVCMOS33 [get_ports s1]
set_property IOSTANDARD LVCMOS33 [get_ports s2]
set_property IOSTANDARD LVCMOS33 [get_ports s3]

set_property IOSTANDARD LVCMOS33 [get_ports led_c]
set_property IOSTANDARD LVCMOS33 [get_ports fr_color]


set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets fr_color] 