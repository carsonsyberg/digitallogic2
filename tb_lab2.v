`timescale 1 ns / 100 ps

module tb_lab2();

reg [9:0] s_in;
reg [1:0] k_in;
reg clock;
wire [9:0] l_out;
wire [7:0] H0, H1, H2, H4, H5;

top_V2 U0(.SW(s_in), .HEX0(H0), .HEX1(H1), .HEX2(H2), .HEX4(H4), .HEX5(H5), .LEDR(l_out), .ADC_CLK_10(clock), .KEY(k_in));

initial begin
    $dumpfile("out.vcd");
    $dumpvars;
    $display($time, "<<Starting Simulation>>");

    // Initializations
    s_in = 8'b00000000; // switch signal
    k_in = 2'b11;        // both buttons off
    clock = 0; 

        // Turn off RESET
        #5
        k_in = 2'b10; // RESET toggled on buttonpress
        #5
        k_in = 2'b11; // button unpressed

     $display($time, "<<Regular Working Order>>");
    // Regular Functionality
    #16000 // amount of time to show count from 1 - 99 / all dates regularly
    
     $display($time, "<<RESET>>");
    // Reset Toggle
    k_in = 2'b10; // RESET toggled on buttonpress
    #5
    k_in = 2'b11; // button unpressed
    #1000 // wait to show effect of reset
    k_in = 2'b10; // RESET toggled on buttonpress
    #5
    k_in = 2'b11; // button unpressed
    #500 // show back to normal

    $display($time, "<<SPEED UP CLOCK>>");
    // Frequency of Clock Change EXTRA CREDIT
    k_in = 2'b01; // Speed Change toggled on buttonpress
    #5
    k_in = 2'b11; // button unpressed
    #4000 // wait to show effect of speed change
    k_in = 2'b01; // Speed Change toggled on buttonpress
    #5
    k_in = 2'b11; // button unpressed
    #1000 // show back to normal

    $display($time, "<<LEAP YEAR>>");
    // Leap Year Functionality
    s_in[9] = 1; // SWITCH 9 HIGH --> leap year
        //RESET
        k_in = 2'b10; // RESET toggled on buttonpress
        #5
        k_in = 2'b11; // button unpressed
        #100
        k_in = 2'b10; // RESET toggled on buttonpress
        #5
        k_in = 2'b11; // button unpressed
    #16000 // wait to show difference with leap year dates
    s_in[9] = 0; // back to normal


    
    $display($time, "<<Simulation Complete>>");
    $finish;
end

always
    #10 clock = ~clock; // creates 20 Mhz Clock

endmodule