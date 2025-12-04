class test_1 extends base_test;
    `uvm_component_utils(test_1)

    localparam seq_length = 32;

    function new(string name = "test_1", uvm_component parent = null);
        super.new(name, parent);

        // uvm_config_db#(int unsigned)::set(uvm_root::get(), "seq_length", "int", seq_length);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        seq_fl test_seq_fl;

        super.run_phase(phase);

        phase.raise_objection(this);
        `uvm_info(get_type_name(), $sformatf("Starting test with sequence_length = %0d",seq_length), UVM_LOW)

        for (int unsigned i = 0; i < seq_length; i++) begin
            test_seq_fl = seq_fl::type_id::create("test_seq_fl");
            test_seq_fl.start(envr.agt.sqr);
        end
        
        test_seq_fl = seq_fl::type_id::create("test_seq_fl");
        test_seq_fl.fl = 1'b0; // Set load to 0
        repeat(3) test_seq_fl.start(envr.agt.sqr);

        `uvm_info(get_type_name(), "Test completed.", UVM_LOW)
        phase.drop_objection(this);
    endtask
endclass