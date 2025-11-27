class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    virtual data_intf #(DATA_WIDTH) data_if;

    uvm_analysis_port#(seq_item) ap;
    int unsigned seq_length;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction : new

    function build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual data_intf #(DATA_WIDTH))::get(
                uvm_root::get(), "test", "data_if", data_if)) begin
            `uvm_fatal(get_type_name(),
                 "Failed to get virtual interface 'data_if' from uvm_config_db.")
        end
    endfunction


    task run_phase(uvm_phase phase);

        (uvm_config_db #(int unsigned)::get(uvm_root::get(), 
            "test", "seq_length", seq_length));
        
        fork
            forever begin
                seq_item item;
                item = seq_item::type_id::create("item");

                @(posedge data_if.clk);
                if (data_if.arst_n == 1'b0) begin
                    `uvm_info(get_type_name(), "In reset, waiting for reset de-assertion", UVM_MEDIUM)
                    @(posedge data_if.arst_n);  // Wait for reset to end
                end

                item.serial_in    = data_if.serial_in;
                item.we           = data_if.we;

                `uvm_info(get_type_name(), $sformatf("Monitoring signals: serial_in=%0b, we=%0b",
                    item.serial_in, item.we), UVM_LOW)
                ap.write(item);
            end
        join_none
    endtask

endclass : monitor