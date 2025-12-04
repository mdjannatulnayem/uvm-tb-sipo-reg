class seq extends uvm_sequence#(seq_item);
    `uvm_object_utils(seq)

    int unsigned seq_length = 32;

    function new(string name = "seq");
        super.new(name);
    endfunction

    task body();
        
        void'(uvm_config_db #(int unsigned)::get(uvm_root::get(), 
            "seq_length", "int", seq_length));

        `uvm_info(get_type_name(), 
            $sformatf("Creating %0d number of sequences.", seq_length), UVM_LOW)

        for (int unsigned i = 0; i < seq_length; i++) begin
            seq_item item;
            item = seq_item::type_id::create("item");

            assert(item.randomize()) else 
                `uvm_fatal(get_type_name(), "Failed to randomize sequence item.")

            `uvm_info(get_type_name(), $sformatf("Sending sequence item %0d: serial_in=%0b, load=%0b, out_dir=%0b", 
                    i, item.serial_in, item.load, item.out_dir), UVM_LOW)

            start_item(item);
            finish_item(item);
        end
    endtask

endclass : seq