module sinegen #(
    parameter   A_WIDTH = 8,
                D_WIDTH = 8
)(
    // interface signals
    input   logic                   clk,        // clock
    input   logic                   rst,        // reset
    input   logic                   en,         // enable
    input   logic [D_WIDTH-1:0]     incr,       // increment for addr counter
    input   logic [A_WIDTH-1:0]     offset,     // offset from the first address from counter
    output  logic [D_WIDTH-1:0]     dout1,      // output data
    output  logic [D_WIDTH-1:0]     dout2       // output data of wave with offset
);

    logic   [A_WIDTH-1:0]           address;    // interconnect wire

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (incr),
    .count (address) // address 1 passed from the counter to the rom
);

rom2ports sineRom (
    .clk (clk),
    .addr1 (address),
    .addr2 (offset),
    .dout1 (dout1),
    .dout2 (dout2)
);

endmodule
