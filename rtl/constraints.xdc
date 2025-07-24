set_property PACKAGE_PIN E3 [get_ports CP]
set_property IOSTANDARD LVCMOS33 [get_ports CP]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports CP]


set_property PACKAGE_PIN W14 [get_ports RESET_N]     ; # BTN0
set_property IOSTANDARD LVCMOS33 [get_ports RESET_N]

set_property PACKAGE_PIN W13 [get_ports CC]          ; # BTN1
set_property IOSTANDARD LVCMOS33 [get_ports CC]

set_property PACKAGE_PIN P15 [get_ports CCEN]        ; # BTN2
set_property IOSTANDARD LVCMOS33 [get_ports CCEN]

set_property PACKAGE_PIN M14 [get_ports RLD]         ; # BTN3
set_property IOSTANDARD LVCMOS33 [get_ports RLD]

# ------------------------------------------------------------------------------
# slide switches
# ------------------------------------------------------------------------------
# instruction input I[3:0]
set_property PACKAGE_PIN R17 [get_ports {I[0]}]      ; # SW0
set_property IOSTANDARD LVCMOS33 [get_ports {I[0]}]
set_property PACKAGE_PIN U20 [get_ports {I[1]}]      ; # SW1
set_property IOSTANDARD LVCMOS33 [get_ports {I[1]}]
set_property PACKAGE_PIN R16 [get_ports {I[2]}]      ; # SW2
set_property IOSTANDARD LVCMOS33 [get_ports {I[2]}]
set_property PACKAGE_PIN N16 [get_ports {I[3]}]      ; # SW3
set_property IOSTANDARD LVCMOS33 [get_ports {I[3]}]

# direct data input D[11:0]
set_property PACKAGE_PIN R14 [get_ports {D[0]}]      ; # SW4
set_property IOSTANDARD LVCMOS33 [get_ports {D[0]}]
set_property PACKAGE_PIN P14 [get_ports {D[1]}]      ; # SW5
set_property IOSTANDARD LVCMOS33 [get_ports {D[1]}]
set_property PACKAGE_PIN L15 [get_ports {D[2]}]      ; # SW6
set_property IOSTANDARD LVCMOS33 [get_ports {D[2]}]
set_property PACKAGE_PIN M15 [get_ports {D[3]}]      ; # SW7
set_property IOSTANDARD LVCMOS33 [get_ports {D[3]}]
set_property PACKAGE_PIN T10 [get_ports {D[4]}]      ; # SW8
set_property IOSTANDARD LVCMOS33 [get_ports {D[4]}]
set_property PACKAGE_PIN T12 [get_ports {D[5]}]      ; # SW9
set_property IOSTANDARD LVCMOS33 [get_ports {D[5]}]
set_property PACKAGE_PIN T11 [get_ports {D[6]}]      ; # SW10
set_property IOSTANDARD LVCMOS33 [get_ports {D[6]}]
set_property PACKAGE_PIN T14 [get_ports {D[7]}]      ; # SW11
set_property IOSTANDARD LVCMOS33 [get_ports {D[7]}]
set_property PACKAGE_PIN T15 [get_ports {D[8]}]      ; # SW12
set_property IOSTANDARD LVCMOS33 [get_ports {D[8]}]
set_property PACKAGE_PIN R15 [get_ports {D[9]}]      ; # SW13
set_property IOSTANDARD LVCMOS33 [get_ports {D[9]}]
set_property PACKAGE_PIN P15 [get_ports {D[10]}]     ; # SW14
set_property IOSTANDARD LVCMOS33 [get_ports {D[10]}]
set_property PACKAGE_PIN N15 [get_ports {D[11]}]     ; # SW15
set_property IOSTANDARD LVCMOS33 [get_ports {D[11]}]

# ------------------------------------------------------------------------------
# LEDs for Output Visualization
# ------------------------------------------------------------------------------
# Microprogram Address Output Y[11:0]
set_property PACKAGE_PIN H14 [get_ports {Y[0]}]      ; # LD0
set_property IOSTANDARD LVCMOS33 [get_ports {Y[0]}]
set_property PACKAGE_PIN J14 [get_ports {Y[1]}]      ; # LD1
set_property IOSTANDARD LVCMOS33 [get_ports {Y[1]}]
set_property PACKAGE_PIN J15 [get_ports {Y[2]}]      ; # LD2
set_property IOSTANDARD LVCMOS33 [get_ports {Y[2]}]
set_property PACKAGE_PIN K14 [get_ports {Y[3]}]      ; # LD3
set_property IOSTANDARD LVCMOS33 [get_ports {Y[3]}]
set_property PACKAGE_PIN K15 [get_ports {Y[4]}]      ; # LD4
set_property IOSTANDARD LVCMOS33 [get_ports {Y[4]}]
set_property PACKAGE_PIN L14 [get_ports {Y[5]}]      ; # LD5
set_property IOSTANDARD LVCMOS33 [get_ports {Y[5]}]
set_property PACKAGE_PIN L15 [get_ports {Y[6]}]      ; # LD6
set_property IOSTANDARD LVCMOS33 [get_ports {Y[6]}]
set_property PACKAGE_PIN M14 [get_ports {Y[7]}]      ; # LD7
set_property IOSTANDARD LVCMOS33 [get_ports {Y[7]}]
set_property PACKAGE_PIN M15 [get_ports {Y[8]}]      ; # LD8
set_property IOSTANDARD LVCMOS33 [get_ports {Y[8]}]
set_property PACKAGE_PIN N14 [get_ports {Y[9]}]      ; # LD9
set_property IOSTANDARD LVCMOS33 [get_ports {Y[9]}]
set_property PACKAGE_PIN P14 [get_ports {Y[10]}]     ; # LD10
set_property IOSTANDARD LVCMOS33 [get_ports {Y[10]}]
set_property PACKAGE_PIN R14 [get_ports {Y[11]}]     ; # LD11
set_property IOSTANDARD LVCMOS33 [get_ports {Y[11]}]

# Status LEDs
set_property PACKAGE_PIN R16 [get_ports FULL]        ; # LD12
set_property IOSTANDARD LVCMOS33 [get_ports FULL]
set_property PACKAGE_PIN T16 [get_ports PL]          ; # LD13
set_property IOSTANDARD LVCMOS33 [get_ports PL]
set_property PACKAGE_PIN N17 [get_ports MAP]         ; # LD14
set_property IOSTANDARD LVCMOS33 [get_ports MAP]
set_property PACKAGE_PIN P17 [get_ports VECT]        ; # LD15
set_property IOSTANDARD LVCMOS33 [get_ports VECT]

# ------------------------------------------------------------------------------
# Tying unused inputs to ground or VCC via switches if needed
# For now, let's assume we control them.
# The `CI` and `OE` are not mapped to physical pins in this example,
# so they will be optimized away by the synthesizer unless you use them.
# If you need them, you can tie them to switches or buttons as well.
# For example, to control OE with BTN4:
# set_property PACKAGE_PIN E20 [get_ports OE] ; # BTN4
# set_property IOSTANDARD LVCMOS33 [get_ports OE]
#
# To control CI with BTN5:
# set_property PACKAGE_PIN F20 [get_ports CI] ; # BTN5
# set_property IOSTANDARD LVCMOS33 [get_ports CI]
# ------------------------------------------------------------------------------