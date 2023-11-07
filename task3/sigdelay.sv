module sigdelay #(
    parameter   A_WIDTH = 9,
                D_WIDTH = 8
)(
    // interface signals
    input   logic                   clk,                // clock
    input   logic                   rst,                // reset
    input   logic                   wr,                 // write enable
    input   logic                   rd,                 // read enable
    input   logic [A_WIDTH-1:0]     offset,             // offset
    input   logic [D_WIDTH-1:0]     mic_signal,         // input data
    output  logic [D_WIDTH-1:0]     delayed_signal      // output data
);

    logic   [A_WIDTH-1:0]           wr_addr;    // interconnect wire
    logic   [A_WIDTH-1:0]           rd_addr;    // interconnect wire

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .offset (offset),
    .count1 (wr_addr),
    .count2 (rd_addr)
);

ram2ports sineRam (
    .clk (clk),
    .wr_en (wr),
    .rd_en (rd),
    .wr_addr (wr_addr),
    .rd_addr (rd_addr),
    .din (mic_signal),
    .dout (delayed_signal)
);

endmodule
