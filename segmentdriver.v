module segmentdriver(numIn, hexOut);

    input [3:0] numIn;
    output reg [7:0] hexOut; 

    always @ (numIn) begin
        // Controls hexOut
        if(numIn[3:0] == 4'b1001) // input 9
            hexOut <= 8'b10011000; // 9
        else if(numIn[3:0] == 4'b1000) // input 8
            hexOut <= 8'b10000000; // 8
        else if(numIn[3:0] == 4'b0111) // input 7
            hexOut <= 8'b11111000; // 7
        else if(numIn[3:0] == 4'b0110) // input 6
            hexOut <= 8'b10000011; // 6
        else if(numIn[3:0] == 4'b0101) // input 5
            hexOut <= 8'b10010010; // 5
        else if(numIn[3:0] == 4'b0100) // input 4
            hexOut <= 8'b10011001; // 4
        else if(numIn[3:0] == 4'b0011) // input 3
            hexOut <= 8'b10110000; // 3
        else if(numIn[3:0] == 4'b0010) // input 2
            hexOut <= 8'b10100100; // 2
        else if(numIn[3:0] == 4'b0001) // input 1
            hexOut <= 8'b11111001; // 1
        else if(numIn[3:0] == 4'b0000) // input 0
            hexOut <= 8'b11000000; // 0
        else
            hexOut <= 8'b11111111; // OFF
    end

endmodule