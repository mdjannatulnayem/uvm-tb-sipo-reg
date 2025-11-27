virtual class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    env envr;

    virtual ctrl_intf ctrl_if;

    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        envr = env::type_id::create("envr", this);

        if (!uvm_config_db#(virtual ctrl_intf)::get(uvm_root::get(),
             "vcif", "ctrl_if", ctrl_if)) begin
            `uvm_fatal("CTRL_IF", "Control interface not found in the UVM config database.")
        end
        
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        uvm_top.print_topology();
        start_clock();
        apply_reset();
        phase.drop_objection(this);
    endtask


    task automatic start_clock(input realtime timeperiod = 10ns);
        ctrl_if.timeperiod = timeperiod;
        ctrl_if.start_clock();
    endtask

    task automatic apply_reset(input realtime duration = 100ns);
        ctrl_if.apply_reset(duration);
    endtask


endclass