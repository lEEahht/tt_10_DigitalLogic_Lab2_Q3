`timescale 1ns/1ps

module tb_adder;
    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    
    // Outputs
    wire [7:0] Sum;
    wire CarryOut;
    
    // Instantiate the adder module
    adder_8bit uut (
        .A(A),
        .B(B),
        .Sum(Sum),
        .CarryOut(CarryOut)
    );
    
    // Monitor the signals
    initial begin
        $monitor("Time=%0t | A=%b | B=%b | Sum=%b | CarryOut=%b", 
                 $time, A, B, Sum, CarryOut);
    end

    // Apply test cases
    initial begin
        // Test Case 1: Basic Addition
        A = 8'b00001111; 
        B = 8'b00000001; 
        #10;
        
        // Test Case 2: Overflow Test
        A = 8'b11111111; 
        B = 8'b00000001; 
        #10;
        
        // Test Case 3: Mixed Bits Test
        A = 8'b10101010; 
        B = 8'b01010101; 
        #10;
        
        // Test Case 4: Zero Addition
        A = 8'b00000000; 
        B = 8'b00000000; 
        #10;
        
        // Test Case 5: Full Carry Test
        A = 8'b11110000; 
        B = 8'b00001111; 
        #10;

        // Test Case 6: Random Pattern Test
        A = 8'b01110110; 
        B = 8'b10001001; 
        #10;
        
        // End simulation
        $finish;
    end
endmodule
