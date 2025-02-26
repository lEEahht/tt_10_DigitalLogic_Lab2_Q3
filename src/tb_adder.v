module tb_adder;
    reg [7:0] A, B;
    wire [7:0] Sum;
    wire CarryOut;

    adder_8bit uut (.A(A), .B(B), .Sum(Sum), .CarryOut(CarryOut));

    initial begin
        $monitor("Time=%0t | A=%b | B=%b | Sum=%b | CarryOut=%b", $time, A, B, Sum, CarryOut);

        A = 8'b00001111; B = 8'b00000001; #10;  // Test 1
        A = 8'b11111111; B = 8'b00000001; #10;  // Overflow test
        A = 8'b10101010; B = 8'b01010101; #10;  // Mixed test
        $finish;
    end
endmodule
