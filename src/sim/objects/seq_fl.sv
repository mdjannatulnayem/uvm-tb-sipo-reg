class seq_fl extends uvm_sequence#(seq_item);
    `uvm_object_utils(seq_fl)

    bit fl = 1'b1;

    function new(string name = "seq_fl");
        super.new(name);
    endfunction

    task body();
        seq_item item;
        item = seq_item::type_id::create("item");

        if (!item.randomize()) 
            `uvm_fatal(get_type_name(), "Failed to randomize sequence item.")

        item.load = fl; // Force load
        
        `uvm_info(get_type_name(), $sformatf("Sending sequence item: serial_in=%0b, load=%0b, out_dir=%0b", 
                item.serial_in, item.load, item.out_dir), UVM_LOW)

        start_item(item);
        finish_item(item);

    endtask

endclass : seq_fl