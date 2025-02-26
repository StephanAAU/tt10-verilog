# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
import cocotb.result
from cocotb.triggers import ClockCycles, RisingEdge, FallingEdge, Edge

# Helper functions to allow waiting for ack signal going high
async def wait_for_bit7_rising(dut):
    dut._log.info("Wait for ACK rising")
    while True:
        await Edge(dut.uo_out)  # Wait for any change on uo_out
        if dut.uo_out.value.is_resolvable:
            dut._log.info(f"ACK triggered: dut.uo_out: {dut.uo_out.value}")
            if dut.uo_out.value & 0b10000000:  # Check if MSB is high
                break

# Helper functions to allow waiting for ack signal going low
async def wait_for_bit7_falling(dut):
    dut._log.info("Wait for ACK falling")
    while True:
        await Edge(dut.uo_out)  # Wait for any change on uo_out
        if dut.uo_out.value.is_resolvable:
            dut._log.info(f"ACK triggered: dut.uo_out: {dut.uo_out.value}")
            if not (dut.uo_out.value & 0b10000000):  # Check if MSB is low
                break


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    dut._log.info(f"Cocotb version: {cocotb.__version__}")

    A_OPS_input  = [26309, 17095, 2236, 16728,  8033,  5778, 1686, 26657, 21660, 7762, 31634,  8881, 17116, 28926, 10037, 24995, 20284, 28575, 16215, 13010,  1702, 10634, 12411,   745]
    B_OPS_input  = [ 6586, 32320, 1636, 18369, 21398, 26058, 7344, 10113, 25684, 1859, 17864, 11586, 19418, 13729, 25711, 14695,  4879, 14561, 23167,  9066, 10994, 10593, 10704, 14882]
    C_RES_output = [     1,    5,    4,     3,     1,     6,    6,     1,     4,    1,     2,     1,     2,     1,     1,     5,     1,     1,     1,     2,    46,     1,     3,     1]

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    await ClockCycles(dut.clk, 5)

    dut._log.info("Testing different inputs")

    for i in range(len(A_OPS_input)):
        dut._log.info(f"Itr {i}")
        # Generate test signals as bit vectors
        bin_a = "{:016b}".format(A_OPS_input[i])
        bin_b = "{:016b}".format(B_OPS_input[i])

        # Assign "A" bit vectors to input pins
        dut._log.info("Input A vector")
        for j in range(8):
            dut.ui_in[j].value = int(bin_a[-1-j])

        for j in range(7):
            dut.uio_in[j].value = int(bin_a[-9-j])

        # Set req high
        await ClockCycles(dut.clk, 2)
        dut._log.info("Set req high")
        dut.uio_in[7].value = 1

        # Wait for ack
        await wait_for_bit7_rising(dut)
        await ClockCycles(dut.clk, 2)

        # Set req low
        dut._log.info("Set req low")
        dut.uio_in[7].value = 0

        # Wait for ack
        await wait_for_bit7_falling(dut)
        await ClockCycles(dut.clk, 2)

        # Assign "B" bit vectors to input pints
        dut._log.info("Input B vector")
        for j in range(8):
            dut.ui_in[j].value = int(bin_b[-1-j])

        for j in range(7):
            dut.uio_in[j].value = int(bin_b[-9-j])
        
        # Set req high
        await ClockCycles(dut.clk, 2)
        dut._log.info("Set req high")
        dut.uio_in[7].value = 1

        # Wait for ack
        await wait_for_bit7_rising(dut)
        await ClockCycles(dut.clk, 2)

        # Extract 7 LSB bits, since 8th is ack
        test = dut.uo_out.value & 0b01111111
        dut._log.info(f"dut.uo_out: {dut.uo_out.value}")

        # Stop on error
        assert test == C_RES_output[i]

        # Set req low
        dut.uio_in[7].value = 0

        # wait for ack
        await wait_for_bit7_falling(dut)
        await ClockCycles(dut.clk, 2)


    # If we reach here the test was good...
    cocotb.result.TestSuccess("Test passed")

