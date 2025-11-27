class rsp_item extends seq_item;
    `uvm_object_utils(rsp_item)

    unsigned int DATA_WIDTH = 32;
    bit [DATA_WIDTH-1:0] parallel_out;

    function new(string name = "rsp_item");
        super.new(name);

        if (!uvm_config_db#(int)::get(uvm_root::get(), "data_width", "int", DATA_WIDTH)) begin
            `uvm_fatal(get_type_name(),
                "Failed to get 'data_width' from uvm_config_db. Check testbench configuration.")
        end

    endfunction

endclass : rsp_item