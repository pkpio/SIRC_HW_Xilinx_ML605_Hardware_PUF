#!/bin/sh
mkdir work
ncvlog -work work $XILINX/verilog/src/glbl.v
ncvlog -work work ../../example_design/client/address_swap_module_8.v
ncvlog -work work ../../example_design/client/fifo/tx_client_fifo_8.v
ncvlog -work work ../../example_design/client/fifo/rx_client_fifo_8.v
ncvlog -work work ../../example_design/client/fifo/eth_fifo_8.v
ncvlog -work work ../../example_design/physical/gmii_if.v
ncvlog -work work ../../example_design/emac_single.v
ncvlog -work work ../../example_design/emac_single_block.v
ncvlog -work work ../../example_design/emac_single_locallink.v
ncvlog -work work ../../example_design/emac_single_example_design.v
ncvlog -work work ../configuration_tb.v
ncvlog -work work ../phy_tb.v
ncvlog -work work ../demo_tb.v
ncelab -access +rw work.testbench glbl
ncsim -gui -input @"simvision -input wave_ncsim.sv" work.testbench
