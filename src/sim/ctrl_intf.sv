interface ctrl_intf ();
    
    logic clk;
    logic arst_n;

    realtime timeperiod = 10ns;
    bit clk_en = 0;

    function void start_clock();
        clk_en = 1'b1;
    endfunction

    task static apply_reset(input realtime duration = 100ns);
        arst_n <= 1'b0;
        #(duration);
        arst_n <= 1'b1;
    endtask

always #(timeperiod/2) clk = clk_en ? ~clk : 0;


endinterface : ctrl_intf