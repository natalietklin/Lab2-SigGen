#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp" // include vbuddy code

#define ADDRESS_WIDTH 8
#define ROM_SZ 256

int main(int argc, char **argv, char **env) {
    int simcyc;      // simulation cycle count
    int tick;   // each clock cycle has two ticks for two edges

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vsinegen* top = new Vsinegen;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("sinegen.vcd");

    // init Vbuddy
    if (vbdOpen()!=1) return(-1);
    vbdHeader("Lab 2: Sinegen");

    // initialise simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->incr = 1; // sinewave period is 256 x clock period

    // run simulation for many clock cycles
    for (simcyc=0; simcyc < 1000000; simcyc++) {

        // dump variables into VCD file and toggle clock
        for (tick=0; tick<2; tick++) {
            tfp->dump (2*simcyc+tick);
            top->clk = !top->clk;
            top->eval ();
        }

        top->incr = vbdValue(); // change frequency of sinewave generated using vbdValue() function
        // plot ROM output and print cycle count
        vbdPlot(int (top->dout), 0, 255);
        vbdCycle(simcyc);

        // either simulation finished, or 'q' is pressed
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q'))
            exit(0);        // ... exit if finish OR 'q' pressed

    }

    vbdClose();     // ++++
    tfp->close();
    exit(0);
}
