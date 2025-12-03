interface data_intf #(
    parameter int DATA_WIDTH=32
)(
    input logic clk,
    input logic arst_n
);
    
    logic serial_in;
    logic load;
    logic out_dir;
    logic shift_dir;
    logic [DATA_WIDTH-1:0] parallel_out;
endinterface : data_intf