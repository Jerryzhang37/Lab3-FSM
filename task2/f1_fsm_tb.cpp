#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vf1_fsm.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char** env){
    int i, clk;
    Verilated::commandArgs(argc,argv);
    Vf1_fsm* top = new Vf1_fsm; 
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp,99);
    tfp->open ("f1_fsm.vcd");
    if(vbdOpen()!=1) return(-1);
    vbdHeader("Lab 3: FSM");
    top->clk = 1;
    top->rst = 0;
    top->en = 0;
        // run simulation for many clock cycles
    for (i = 0; i < 1000000; i++) {
        top->en = vbdFlag();
        // dump variables into VCD file and toggle clock
        for (clk = 0; clk < 2; clk++) {
            tfp->dump(2 * i+clk);
            top->clk = !top->clk;
            top->eval();
        }
        vbdBar(top->data_out & 0xFF);
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q')){
            exit(0); 
        }
    }
    vbdClose();
    tfp->close();
    exit(0); 
}
