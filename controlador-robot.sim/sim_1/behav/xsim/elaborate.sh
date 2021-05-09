#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Sat May 08 10:26:48 CEST 2021
# SW Build 3064766 on Wed Nov 18 09:12:47 MST 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto 8cb68b1b40d14a1c9118e848c01ea0b1 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot prueba1_test_behav xil_defaultlib.prueba1_test -log elaborate.log"
xelab -wto 8cb68b1b40d14a1c9118e848c01ea0b1 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot prueba1_test_behav xil_defaultlib.prueba1_test -log elaborate.log

