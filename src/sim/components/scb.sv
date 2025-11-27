class scb extends uvm_component;
    `uvm_component_utils(scb)

    // Analysis port to receive monitored transactions
    uvm_analysis_export #(rsp_item) ap;

    unsigned int DATA_WIDTH = 32;
    parameter bit SHIFT_LEFT = 1; // 1 for left shift, 0 for right shift

    // Golden model storage
    bit [DATA_WIDTH-1:0] golden_shift_reg;

    // Counters
    int pass_count;
    int fail_count;

    function new(string name = "sipo_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);

        if (!uvm_config_db#(int)::get(uvm_root::get(), "data_width", "int", DATA_WIDTH)) begin
            `uvm_fatal(get_type_name(),
                "Failed to get 'data_width' from uvm_config_db. Check testbench configuration.")
        end

        if (!uvm_config_db#(bit)::get(uvm_root::get(), "shift_left", "int", SHIFT_LEFT)) begin
            `uvm_fatal(get_type_name(),
                "Failed to get 'shift_left' from uvm_config_db. Check testbench configuration.")
        end

        golden_shift_reg = '0;
        pass_count = 0;
        fail_count = 0;
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    // Called when monitor writes a transaction
    function void write(rsp_item t);

        // Shift the golden model according to DUT behavior
        if(t.we) begin
            if(SHIFT_LEFT) begin
                golden_shift_reg = {golden_shift_reg[DATA_WIDTH-2:0], t.serial_in};
            end else begin
                golden_shift_reg = {t.serial_in, golden_shift_reg[DATA_WIDTH-1:1]};
            end
        end

        // Compare DUT output with golden model
        if(t.parallel_out !== golden_shift_reg) begin
            `uvm_error(get_type_name(),
                $sformatf("Mismatch detected! DUT=0x%0h, GOLD=0x%0h, serial_in=%0b, we=%0b",
                          t.parallel_out, golden_shift_reg, t.serial_in, t.we))
            fail_count++;
        end else begin
            `uvm_info(get_type_name(),
                $sformatf("Match: DUT=0x%0h, GOLD=0x%0h", t.parallel_out, golden_shift_reg), UVM_LOW)
            pass_count++;
        end

    endfunction

    // Report summary at the end of simulation
    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(),
            $sformatf("===== SCOREBOARD SUMMARY =====\nPass Count = %0d\nFail Count = %0d\n==============================", 
                      pass_count, fail_count),
            UVM_HIGH)
    endfunction

endclass : scb
