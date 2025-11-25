interface data_intf #(
    parameter int DATA_WIDTH=32
)(
    input logic clk,
    input logic rst_n
);
    
    logic serial_in;
    logic we;
    logic [DATA_WIDTH-1:0] parallel_out;
endinterface : data_intf