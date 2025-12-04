class seq_item extends uvm_sequence_item;

    rand bit serial_in;
    rand bit load;
    rand bit out_dir;

    `uvm_object_utils(seq_item)

    function new(string name = "seq_item");
        super.new(name);
    endfunction

endclass : seq_item