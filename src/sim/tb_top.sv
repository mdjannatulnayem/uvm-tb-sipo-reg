`include "uvm_macros.svh"

import uvm_pkg::*;

module tb_top;

    initial $display("##--------------TEST STARTED--------------##");
    final $display("##--------------TEST ENDED--------------##");

    localparam int DATA_WIDTH = 32;

    logic clk;
    logic arst_n;
    logic serial_in;
    logic load;
    logic out_dir;
    logic [DATA_WIDTH-1:0] parallel_out;   

    ctrl_intf ctrl_if();
    data_intf #(DATA_WIDTH) data_if(.clk(clk), .arst_n(arst_n));

    sipo_reg #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .arst_n(arst_n),
        .serial_in(serial_in),
        .load(load),
        .out_dir(out_dir),
        .parallel_out(parallel_out)
    );

    assign clk = ctrl_if.clk;
    assign arst_n = ctrl_if.arst_n;
    assign serial_in = data_if.serial_in;
    assign load = data_if.load;
    assign out_dir = data_if.out_dir;
    assign data_if.parallel_out = parallel_out;

    initial begin

        string test;

        if (!$value$plusargs("TEST=%s", test)) begin
            $fatal(1, "No test name provided. Use +TEST=<test_name> to specify a test.");
        end

        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);
            
        uvm_config_db#(virtual ctrl_intf)::set(
            uvm_root::get(), "vcif", "ctrl_if", ctrl_if);

        uvm_config_db#(virtual data_intf #(DATA_WIDTH))::set(
            uvm_root::get(), "vdif", "data_if", data_if);
        
        run_test(test);

        #100 $finish;
    end

endmodule : tb_top