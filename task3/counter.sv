module counter #(
    parameter WIDTH = 9
)(
    // interface signals
    input logic              clk,    // clock    
    input logic              rst,    // reset
    input logic  [WIDTH-1:0] offset, // offset
    output logic [WIDTH-1:0] count1, // count output
    output logic [WIDTH-1:0] count2  // count output with offset
);

always_ff @ (posedge clk)
    if (rst) begin
        count1 <= {WIDTH{1'b0}};
        count2 <= {WIDTH{1'b0}};
    end
    else begin
        count1 <= count1 + {{WIDTH-1{1'b0}}, 1'b1}; // assume that en is always 1
        count2 <= count1 + offset;
    end

endmodule
