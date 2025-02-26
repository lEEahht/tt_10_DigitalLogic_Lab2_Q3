/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module BooleanLogicFunction (
    input  wire [7:0] A,   // Input A
    input  wire [7:0] B,   // Input B
    output wire [7:0] C    // Output C
);

    // Internal Wires for OR and XOR results
    wire [6:0] or_result;
    wire [6:0] xor_result;

    // Bitwise OR for lower 7 bits
    assign or_result = A[6:0] | B[6:0];
    
    // Bitwise XOR for lower 7 bits
    assign xor_result = A[6:0] ^ B[6:0];

    // MUX to select between OR and XOR
    assign C[6:0] = (A[7] == 0) ? or_result : xor_result;
   
    // C[7] is always set to 1
    assign C[7] = 1;

endmodule
