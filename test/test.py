# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_boolean_logic_function(dut):
    dut._log.info("Start Boolean Logic Function Test")

    # Set up the clock (10 us period -> 100 KHz frequency)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset DUT
    dut._log.info("Reset DUT")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Begin Testing Boolean Logic Function")

    # Test Cases
    test_cases = [
        (0b01001101, 0b00010110, 0b10011111),  # A[7] = 0 -> OR
        (0b11001101, 0b00010110, 0b10111011),  # A[7] = 1 -> XOR
        (0b11111111, 0b10101010, 0b01010101),  # A[7] = 1 -> XOR
        (0b01111111, 0b01111111, 0b11111111),  # A[7] = 0 -> OR
    ]

    # Run through test cases
    for A_val, B_val, expected_output in test_cases:
        # Apply inputs
        dut.ui_in.value = A_val
        dut.uio_in.value = B_val

        # Wait for one clock cycle
        await ClockCycles(dut.clk, 1)

        # Read the output
        output_val = int(dut.uo_out.value)

        # Log result
        dut._log.info(f"Test case A={A_val:08b}, B={B_val:08b} -> C={output_val:08b}")

        # Assert correctness
        assert output_val == expected_output, (
            f"Test failed for A={A_val:08b}, B={B_val:08b}. Expected {expected_output:08b}, "
            f"but got {output_val:08b}"
        )

        # Log success
        dut._log.info(f"Test passed for A={A_val:08b}, B={B_val:08b}")

    dut._log.info("Boolean Logic Function Test Completed Successfully")
