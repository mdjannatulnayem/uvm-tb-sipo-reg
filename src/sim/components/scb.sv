class scb extends uvm_component;
    `uvm_component_utils(scb)

    // Port to receive monitored transactions
    uvm_analysis_imp #(rsp_item, scb) imp;

    localparam DATA_WIDTH = 32;

    // Golden model storage
    bit [DATA_WIDTH-1:0] golden_shift_reg;
    bit [DATA_WIDTH-1:0] output_expected;

    // Counters
    int pass_count;
    int fail_count;

    function new(string name = "sipo_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        imp = new("imp", this);

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
        if(t.load) begin
             // When we is high, output_expected is zero            
            golden_shift_reg = {golden_shift_reg[DATA_WIDTH-2:0], t.serial_in};
            output_expected = '0;
        end else begin
            // When we is low, output_expected should match shift register
            output_expected =  t.out_dir ? reverse_bits(golden_shift_reg) : golden_shift_reg; 
        end

        // Compare DUT output with golden model
        if(t.parallel_out !== output_expected) begin
            `uvm_error(get_type_name(), 
                $sformatf("Mismatch detected! DUT=0x%0h, GOLD=0x%0h, serial_in=%0b, load=%0b, out_dir=%0b",
                        t.parallel_out, output_expected, t.serial_in, t.load, t.out_dir))
            fail_count++;
        end else begin
            `uvm_info(get_type_name(), 
                $sformatf("Match: DUT=0x%0h, GOLD=0x%0h, serial_in=%0b, load=%0b, out_dir=%0b", 
                    t.parallel_out, output_expected, t.serial_in, t.load, t.out_dir), UVM_LOW)
            pass_count++;
        end

    endfunction

    // Utility function to reverse the golden model bits
    function automatic logic [DATA_WIDTH-1:0] reverse_bits(input logic [DATA_WIDTH-1:0] in);
        logic [DATA_WIDTH-1:0] reversed;
        integer i;
        begin
            reversed = '0;
            for (i = 0; i < DATA_WIDTH; i = i + 1) begin
                reversed[i] = in[DATA_WIDTH-i-1];
            end
            reverse_bits = reversed;
        end
    endfunction

    // Report summary at the end of simulation
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(),
            $sformatf("===== SCOREBOARD SUMMARY =====\nPass Count = %0d\nFail Count = %0d\n==============================", 
                pass_count, fail_count),UVM_MEDIUM)
    endfunction

endclass : scb
