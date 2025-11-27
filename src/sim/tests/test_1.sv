class test_1 extends base_test;
    `uvm_component_utils(test_1)

    unsingned int seq_length = 32;

    function new(string name = "test_1", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        uvm_config_db#(int unsigned)::set(uvm_root::get(), "seq_length", "int", 32);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        phase.raise_objection(this);
        `uvm_info(get_type_name(), $sformatf("Starting test with sequence_length = %0d",
            seq_length), UVM_LOW)

        seq test_1_seq = seq::type_id::create("test_1_seq")

        fork
            test_1_seq.start(envr.agt.sqr);
        join_none

        phase.drop_objection(this);
    endtask
endclass