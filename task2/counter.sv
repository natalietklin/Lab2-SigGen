module counter #(
    parameter WIDTH = 8
)(
    // interface signals
    input logic              clk,    // clock    
    input logic              rst,    // reset
    input logic              en,     // counter enable
    input logic  [WIDTH-1:0] incr,   // increment
    input logic  [WIDTH-1:0] offset, // 90/360 * 2^8 = 64 so the phase offset is 90 degrees when offset = 64
    output logic [WIDTH-1:0] count1, // count output
    output logic [WIDTH-1:0] count2  // count output for sinewave with offset
);

always_ff @ (posedge clk) 
    if (rst) begin
        count1 <= {WIDTH{1'b0}};
        count2 <= {WIDTH{1'b0}};
    end
    else begin
        count1 <= count1 + {{WIDTH-1{1'b0}}, en};
        count2 <= count1 + offset;
    end

endmodule
