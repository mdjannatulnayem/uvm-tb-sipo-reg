class env extends uvm_environment;
    `uvm_component_utils(env)

    agent agt;
    scb scbd;

    function new(string name = "env", uvm_component parent = null)
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase)
        super.build_phase();
        agt = agent::type_id::create("agt", this);
        scbd = scb::type_id::create("scbd",this);

        agt.is_active = UVM_ACTIVE;
    endfunction

    function void connect_phase(uvm_phase phase)
        // No virtual sequencer
        agt.mon.ap.connect(scbd.ap);
    endfunction

endclass : env