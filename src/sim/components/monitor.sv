class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    localparam DATA_WIDTH = 32;
    virtual data_intf #(DATA_WIDTH) data_if;

    uvm_analysis_port#(rsp_item) ap;
    int unsigned seq_length = 32;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual data_intf #(DATA_WIDTH))::get(
                uvm_root::get(), "vdif", "data_if", data_if)) begin
            `uvm_fatal(get_type_name(),
                 "Failed to get virtual interface 'data_if' from uvm_config_db.")
        end
    endfunction


    task run_phase(uvm_phase phase);

        void'(uvm_config_db #(int unsigned)::get(uvm_root::get(), "seq_length", "int", seq_length));
        
        fork
            forever begin
                rsp_item item;
                item = rsp_item::type_id::create("item");

                @(posedge data_if.clk);
                if (data_if.arst_n == 1'b0) begin
                    `uvm_info(get_type_name(), "In reset, waiting for reset de-assertion", UVM_MEDIUM)
                    @(posedge data_if.arst_n);  // Wait for reset to end
                end

                item.serial_in    = data_if.serial_in;
                item.we           = data_if.we;
                item.out_dir      = data_if.out_dir;
                item.shift_dir    = data_if.shift_dir;
                item.parallel_out  = data_if.parallel_out;

                `uvm_info(get_type_name(), $sformatf("Monitoring signals: serial_in=%0b, we=%0b, out_dir=%0b, shift_dir=%0b, parallel_out=%0h",
                    item.serial_in, item.we,item.out_dir,item.shift_dir, item.parallel_out), UVM_LOW)
                    
                ap.write(item);
            end
        join_none
    endtask

endclass : monitor