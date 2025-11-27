class seqr extends uvm_sequencer#(seq_item);
    `uvm_object_utils(seqr)

    function new(string name = "seqr");
        super.new(name);
    endfunction
endclass : seqr