class seq_item extends uvm_sequence_item;

`uvm_object_utils_begin(seq_item)
    `uvm_field_bit(serial_in, UVM_ALL_ON)
    `uvm_field_bit(we, UVM_ALL_ON)
    `uvm_field_bit_array(parallel_out, UVM_ALL_ON)
`UVM_OBJECT_UTILS_END()

rand bit serial_in;
rand bit we;
rand bit [128:0] parallel_out;

function new(string name = "seq_item");
    super.new(name);
endfunction

function void post_randomize();

    int DATA_WIDTH;

    if (!uvm_config_db#(int)::get(uvm_root::get(), "dut", "data_width", DATA_WIDTH)) begin
        `uvm_fatal(get_type_name(),
             "Failed to get 'data_width' from uvm_config_db. Check testbench configuration.")
    end

    for (int i = DATA_WIDTH; i < 128; i++) begin
      parallel_out[i] = 0;
    end
endfunction

endclass : seq_item