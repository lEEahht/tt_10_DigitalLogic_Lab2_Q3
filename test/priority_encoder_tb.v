`timescale 1ns/1ps

module tb_tt_um_VKL;
    // Inputs
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    reg clk;
    reg rst_n;
    reg ena;

    // Outputs
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    
    // Internal Signals for Priority Encoder
    reg [15:0] In;
    wire [7:0] C;

    // Instantiate the top-level module
    tt_um_VKL uut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Instantiate the Priority Encoder
    tt_um_priority_encoder encoder_inst (
        .In(In),
        .C(C)
    );
    
    // Clock Generation
    always #5 clk = ~clk;
    
    // Testbench Logic
    initial begin
        // Initialize inputs
        clk = 0;
        rst_n = 0;
        ena = 1;
        ui_in = 8'b0000_0000;
        uio_in = 8'b0000_0000;
        In = 16'b0000_0000_0000_0000;
        
        // Release reset
        #10 rst_n = 1;

        // Test Case 1: Basic Sum Test
        ui_in = 8'b0000_1010;
        uio_in = 8'b0000_0101;
        #10;
        
        // Test Case 2: Priority Encoder - First 1 at In[15]
        In = 16'b1000_0000_0000_0000;
        #10;
        
        // Test Case 3: Priority Encoder - First 1 at In[0]
        In = 16'b0000_0000_0000_0001;
        #10;
        
        // Test Case 4: Priority Encoder - Multiple 1s, Highest at In[14]
        In = 16'b0100_0000_0000_0001;
        #10;
        
        // Test Case 5: Priority Encoder - All Zeros (Special Case)
        In = 16'b0000_0000_0000_0000;
        #10;
        
        // Test Case 6: Complex Sum Test
        ui_in = 8'b1010_1010;
        uio_in = 8'b0101_0101;
        #10;
        
        // Test Case 7: Random Pattern
        In = 16'b0011_1100_1100_0011;
        ui_in = 8'b1100_1100;
        uio_in = 8'b0011_0011;
        #10;
        
        // End Simulation
        $stop;
    end
    
    // Monitor the signals
    initial begin
        $monitor("Time=%0t | ui_in=%b | uio_in=%b | uo_out=%b | Priority=%b", 
                 $time, ui_in, uio_in, uo_out, C);
    end
endmodule
