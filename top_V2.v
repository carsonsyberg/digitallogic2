
module top_V2(SW, HEX0, HEX1, HEX2, HEX4, HEX5, LEDR, ADC_CLK_10, KEY);

    input [9:0] SW;
    output [9:0] LEDR;
    output [7:0] HEX0, HEX1, HEX2, HEX4, HEX5;

    input ADC_CLK_10;
    input [1:0] KEY;
    reg key1Latch_n, key0Latch_n;

    wire clockDivOutput, slowClock, fastClock;

    assign LEDR[1] = ~key1Latch_n ? slowClock : fastClock; // LED blinks at slow rate if KEY[1] unpressed
    assign LEDR[9:2] = 9'b000000000;

    wire [6:0] joinedDigits;
    wire [3:0] month, day1, day0;

    reg [3:0] lsd9Counter, msd9Counter;

    clk_div_V1 C0(.clk(ADC_CLK_10), .reset(KEY[0]), .clk_out(slowClock));
    clk_div_V2 C1(.clk(ADC_CLK_10), .reset(KEY[0]), .clk_out(fastClock));

    segmentdriver S0(.numIn(lsd9Counter), .hexOut(HEX4));
    msdSegDriver S1(.numIn(msd9Counter), .hexOut(HEX5));
    segmentdriver S2(.numIn(month), .hexOut(HEX2));
    segmentdriver S3(.numIn(day1), .hexOut(HEX1));
    segmentdriver S4(.numIn(day0), .hexOut(HEX0));

    digitJoiner U0(.dig1(lsd9Counter), .dig2(msd9Counter), .digJoin(joinedDigits));

    translateDisplay U1(.number(joinedDigits), .month(month), .day1(day1), .day0(day0), .switch(SW[9]));

    assign clockDivOutput = ~key1Latch_n ? slowClock : fastClock;

    always @(negedge KEY[0])
        key0Latch_n <= ~key0Latch_n;
    always @(negedge KEY[1])
        key1Latch_n <= ~key1Latch_n;
    
    assign LEDR[0] = ~key0Latch_n;

    initial begin
        key0Latch_n = 0;
        key1Latch_n = 1;
        lsd9Counter = 1;
        msd9Counter = 0;
    end

    always @(posedge clockDivOutput or negedge key0Latch_n) begin
        if(~key0Latch_n) // reset active
            lsd9Counter <= 1;
        else if(lsd9Counter != 9)
            lsd9Counter <= lsd9Counter + 1;
        else if(msd9Counter != 9) // rolling over from 9-10 or 19-20 or etc
            lsd9Counter <= 0;
        else                      // rolling over from 99 - 1
            lsd9Counter <= 1;
        
        if(~key0Latch_n) // reset active
            msd9Counter <= 0;
        else if(msd9Counter != 9 && lsd9Counter == 9)
            msd9Counter <= msd9Counter + 1;
        else if(msd9Counter == 9 && lsd9Counter == 9)
            msd9Counter <= 0;
        
    end

endmodule