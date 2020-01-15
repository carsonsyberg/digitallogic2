// joined digits --> number
// HEX2 driver --> month
// HEX1 driver --> day1
// HEX0 driver --> day0
// SW[9] --> switch
module translateDisplay(number, month, day1, day0, switch);

    input switch; // decides if leap year or not
    input [6:0] number; // needs to be 7 bits cause will hold 1 - 99
    output reg [3:0] month, day1, day0; // month == binary num to display on HEX2
                                    // day1 == binary num to display on HEX1 day2 == binary num to display on HEX0
    // used for Feb
    wire [6:0] numMinus1; // makes us able to subtract first 31 days off number // needs to be same size as num for it to work
    assign numMinus1 = number - 31;
    // used for March
    wire [6:0] numMinus2; // needs to be same size as num for it to work
    assign numMinus2 = number - 59;
    // used for April
    wire [6:0] numMinus3; // needs to be same size as num for it to work
    assign numMinus3 = number - 90;

    //need different numMinus2/3 for LEAP YEAR part
    // used for Feb
    wire [6:0] leapMinus1; // makes us able to subtract first 31 days off number // needs to be same size as num for it to work
    assign leapMinus1 = number - 31;
    // used for March
    wire [6:0] leapMinus2; // needs to be same size as num for it to work
    assign leapMinus2 = number - 60;
    // used for April
    wire [6:0] leapMinus3; // needs to be same size as num for it to work
    assign leapMinus3 = number - 91;

    always @(number) begin
        if(switch == 1'b0) begin // SWITCH OFF NOT LEAP YEAR
            if(number <= 31) begin
                // JANUARY
                month <= 1;
                if(number < 10) begin
                    // the single digits
                    day1 <= 4'b1010; // 10 will mean empty to the segment driver
                    day0 <= number;
                end
                else if(number >= 10 && number < 20) begin
                    // the teens
                    day1 <= 1'b1;
                    day0 <= number - 10;
                end
                else if(number >= 20 && number < 30) begin
                    // the twenties
                    day1 <= 2;
                    day0 <= number - 20;
                end
                else if(number >= 30 && number < 40) begin
                    // the thirties
                    day1 <= 3;
                    day0 <= number - 30;
                end
                else begin
                    // if we get to here, there's something wrong cause number should not be more than 31
                    day1 <= 10;
                    day0 <= 10; // sets both to OFF
                end
            end
            else if(number >= 32 && number <= 59) begin
                //FEBRUARY
                month <= 2;
                if(numMinus1 < 10) begin
                    // the single digits
                    day1 <= 4'b1010; // 10 will mean empty to the segment driver
                    day0 <= numMinus1;
                end
                else if(numMinus1 >= 10 && numMinus1 < 20) begin
                    // the teens
                    day1 <= 1'b1;
                    day0 <= numMinus1 - 10;
                end
                else if(numMinus1 >= 20 && numMinus1 < 30) begin
                    // the twenties
                    day1 <= 2;
                    day0 <= numMinus1 - 20;
                end
                else begin
                    // if we get to here, there's something wrong cause numMinus1 should not be more than 28
                    day1 <= 10;
                    day0 <= 10; // sets both to OFF
                end
            end
            else if(number >= 60 && number <= 90) begin
                // MARCH
                month <= 3;
                if(numMinus2 < 10) begin
                    // the single digits
                    day1 <= 4'b1010; // 10 will mean empty to the segment driver
                    day0 <= numMinus2;
                end
                else if(numMinus2 >= 10 && numMinus2 < 20) begin
                    // the teens
                    day1 <= 1'b1;
                    day0 <= numMinus2 - 10;
                end
                else if(numMinus2 >= 20 && numMinus2 < 30) begin
                    // the twenties
                    day1 <= 2;
                    day0 <= numMinus2 - 20;
                end
                else if(numMinus2 >= 30 && numMinus2 < 40) begin
                    // the thirties
                    day1 <= 3;
                    day0 <= numMinus2 - 30;
                end
                else begin
                    // if we get to here, there's something wrong cause numMinus2 should not be more than 31
                    day1 <= 10;
                    day0 <= 10; // sets both to OFF
                end
            end
            else if(number >= 91 && number <= 99) begin
                // APRIL
                month <= 4;
                if(numMinus3 < 10) begin
                    // the single digits
                    day1 <= 4'b1010; // 10 will mean empty to the segment driver
                    day0 <= numMinus3;
                end
                else if(numMinus3 >= 10 && numMinus3 < 20) begin
                    // the teens
                    day1 <= 1'b1;
                    day0 <= numMinus3 - 10;
                end
                else begin
                    // if we get to here, there's something wrong cause numMinus3 should not be more than 10
                    day1 <= 10;
                    day0 <= 10; // set's both to OFF
                end
            end
        end
        else begin // LEAP YEAR SWITCH ON
            if(number <= 31) begin
                // JANUARY
                month <= 1;
                if(number < 10) begin
                    // the single digits
                    day1 <= 4'b1010; // 10 will mean empty to the segment driver
                    day0 <= number;
                end
                else if(number >= 10 && number < 20) begin
                    // the teens
                    day1 <= 1'b1;
                    day0 <= number - 10;
                end
                else if(number >= 20 && number < 30) begin
                    // the twenties
                    day1 <= 2;
                    day0 <= number - 20;
                end
                else if(number >= 30 && number < 40) begin
                    // the thirties
                    day1 <= 3;
                    day0 <= number - 30;
                end
                else begin
                    // if we get to here, there's something wrong cause number should not be more than 31
                    day1 <= 10;
                    day0 <= 10; // sets both to OFF
                end
            end
            else if(number >= 32 && number <= 60) begin
                //FEBRUARY
                month <= 2;
                if(leapMinus1 < 10) begin
                    // the single digits
                    day1 <= 4'b1010; // 10 will mean empty to the segment driver
                    day0 <= numMinus1;
                end
                else if(leapMinus1 >= 10 && leapMinus1 < 20) begin
                    // the teens
                    day1 <= 1'b1;
                    day0 <= leapMinus1 - 10;
                end
                else if(leapMinus1 >= 20 && leapMinus1 < 30) begin
                    // the twenties
                    day1 <= 2;
                    day0 <= leapMinus1 - 20;
                end
                else begin
                    // if we get to here, there's something wrong cause numMinus1 should not be more than 28
                    day1 <= 10;
                    day0 <= 10; // sets both to OFF
                end
            end
            else if(number >= 61 && number <= 91) begin
                // MARCH
                month <= 3;
                if(leapMinus2 < 10) begin
                    // the single digits
                    day1 <= 4'b1010; // 10 will mean empty to the segment driver
                    day0 <= leapMinus2;
                end
                else if(leapMinus2 >= 10 && leapMinus2 < 20) begin
                    // the teens
                    day1 <= 1'b1;
                    day0 <= leapMinus2 - 10;
                end
                else if(leapMinus2 >= 20 && leapMinus2 < 30) begin
                    // the twenties
                    day1 <= 2;
                    day0 <= leapMinus2 - 20;
                end
                else if(leapMinus2 >= 30 && leapMinus2 < 40) begin
                    // the thirties
                    day1 <= 3;
                    day0 <= leapMinus2 - 30;
                end
                else begin
                    // if we get to here, there's something wrong cause numMinus2 should not be more than 31
                    day1 <= 10;
                    day0 <= 10; // sets both to OFF
                end
            end
            else if(number >= 92 && number <= 99) begin
                // APRIL
                month <= 4;
                if(leapMinus3 < 10) begin
                    // the single digits
                    day1 <= 4'b1010; // 10 will mean empty to the segment driver
                    day0 <= leapMinus3;
                end
                else if(leapMinus3 >= 10 && leapMinus3 < 20) begin
                    // the teens
                    day1 <= 1'b1;
                    day0 <= leapMinus3 - 10;
                end
                else begin
                    // if we get to here, there's something wrong cause numMinus3 should not be more than 10
                    day1 <= 10;
                    day0 <= 10; // set's both to OFF
                end
            end
        end
    end

endmodule