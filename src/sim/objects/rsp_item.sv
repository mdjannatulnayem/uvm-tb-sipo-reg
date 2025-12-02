class rsp_item extends seq_item;
    `uvm_object_utils(rsp_item)

    localparam DATA_WIDTH = 32;
    bit [DATA_WIDTH-1:0] parallel_out;

    function new(string name = "rsp_item");
        super.new(name);

    endfunction

endclass : rsp_item