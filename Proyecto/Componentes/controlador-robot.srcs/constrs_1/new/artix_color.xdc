set_property PACKAGE_PIN N11 [get_ports clk]
set_property PACKAGE_PIN P1 [get_ports serial_color]

set_property PACKAGE_PIN T2 [get_ports s0]
set_property PACKAGE_PIN T3 [get_ports s1]
set_property PACKAGE_PIN P3 [get_ports s2]
set_property PACKAGE_PIN N4 [get_ports s3]


set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports serial_color]

set_property IOSTANDARD LVCMOS33 [get_ports s0]
set_property IOSTANDARD LVCMOS33 [get_ports s1]
set_property IOSTANDARD LVCMOS33 [get_ports s2]
set_property IOSTANDARD LVCMOS33 [get_ports s3]

#// Display 8 segm
set_property PACKAGE_PIN T9 [get_ports dig_1]
set_property PACKAGE_PIN P10 [get_ports dig_2]
set_property PACKAGE_PIN T8 [get_ports dig_3]
set_property IOSTANDARD LVCMOS33 [get_ports dig_1]
set_property IOSTANDARD LVCMOS33 [get_ports dig_2]
set_property IOSTANDARD LVCMOS33 [get_ports dig_3]

set_property PACKAGE_PIN T10 [get_ports {out_display[0]}]
set_property PACKAGE_PIN K13 [get_ports {out_display[1]}]
set_property PACKAGE_PIN P11 [get_ports {out_display[2]}]
set_property PACKAGE_PIN R11 [get_ports {out_display[3]}]
set_property PACKAGE_PIN R10 [get_ports {out_display[4]}]
set_property PACKAGE_PIN N9 [get_ports {out_display[5]}]
set_property PACKAGE_PIN K12 [get_ports {out_display[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_display[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_display[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_display[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_display[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_display[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_display[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_display[0]}]

set_property PACKAGE_PIN R6 [get_ports led_r6]
set_property IOSTANDARD LVCMOS33 [get_ports led_r6]

set_property PACKAGE_PIN T5 [get_ports led_t5]
set_property IOSTANDARD LVCMOS33 [get_ports led_t5]
