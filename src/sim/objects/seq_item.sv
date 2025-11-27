class seq_item extends uvm_sequence_item;

`uvm_object_utils_begin(seq_item)
    `uvm_field_bit(serial_in, UVM_ALL_ON)
    `uvm_field_bit(we, UVM_ALL_ON)
`UVM_OBJECT_UTILS_END()

rand bit serial_in;
rand bit we;

function new(string name = "seq_item");
    super.new(name);
endfunction

endclass : seq_item