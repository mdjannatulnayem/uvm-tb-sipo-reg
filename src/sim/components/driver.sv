class driver extends uvm_driver#(seq_item);
    `uvm_component_utils(driver)
    
    function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    localparam DATA_WIDTH = 32;
    virtual data_intf #(DATA_WIDTH) data_if;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual data_intf #(DATA_WIDTH))::get(
                uvm_root::get(), "vdif", "data_if", data_if)) begin
            `uvm_fatal(get_type_name(),
                 "Failed to get virtual interface 'data_if' from uvm_config_db.")
        end
    endfunction

    task run_phase(uvm_phase phase);
        seq_item item;

        forever begin

            @(posedge data_if.clk);
            if (data_if.arst_n == 1'b0) begin
                `uvm_info(get_type_name(), "In reset, waiting for reset de-assertion", UVM_MEDIUM)
                @(posedge data_if.arst_n);  // Wait for reset to end
            end

            seq_item_port.get_next_item(item);

            `uvm_info(get_type_name(), $sformatf("Driving signals: serial_in=%0b, load=%0b, out_dir=%0b", 
                    item.serial_in, item.load, item.out_dir), UVM_LOW)

            data_if.serial_in   <= item.serial_in;
            data_if.load        <= item.load;
            data_if.out_dir     <= item.out_dir;

            seq_item_port.item_done();
        end
    endtask
endclass : driver