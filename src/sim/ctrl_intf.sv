interface ctrl_intf ();
    
    logic clk;
    logic rst_n;

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

    initial begin
        forever begin
            clk <= clk_en & rst_n;
            #(timeperiod / 2);
            clk <= 1'b0;
            #(timeperiod / 2);
        end
    end

endinterface : ctrl_intf