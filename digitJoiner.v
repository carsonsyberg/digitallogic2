// takes [dig2 dig1] for ex 2 and 6 and changes them into [dig2dig1] together for ex 26 (all values in binary)
module digitJoiner(dig1, dig2, digJoin);

    input [3:0] dig1, dig2;
    output [6:0] digJoin; //need 7 bits to get up to 99

    //multiply dig2 by 10 need 7 bits to get up to 90
    wire [6:0] dig10;
    assign dig10 = dig2 * 4'b1010;

    //add new value to dig1 to get their actual binary value
    assign digJoin = dig10 + dig1;
    
endmodule

