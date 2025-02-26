`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module TestBench;

    reg [7:0] A;
    reg [7:0] B;
    wire [7:0] C;

    // Instantiate the module
    BooleanLogicFunction uut (
        .A(A),
        .B(B),
        .C(C)
    );

    initial begin
        // Test Case 1: A[7] = 0 (Bitwise OR)
        A = 8'b01001101; // 77 in decimal
        B = 8'b00010110; // 22 in decimal
        #10;
       
        // Test Case 2: A[7] = 1 (Bitwise XOR)
        A = 8'b11001101; // 77 in decimal with A[7] as 1
        B = 8'b00010110; // 22 in decimal
        #10;

        // Test Case 3: A[7] = 1 (Bitwise XOR with different inputs)
        A = 8'b11111111; // 255 in decimal with A[7] as 1
        B = 8'b10101010; // 170 in decimal
        #10;

        // Test Case 4: A[7] = 0 (Bitwise OR with all ones)
        A = 8'b01111111; // 127 in decimal
        B = 8'b01111111; // 127 in decimal
        #10;

        // End of Test
        $finish;
    end

endmodule
