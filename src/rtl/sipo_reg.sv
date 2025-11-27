module sipo_reg #(
    parameter int SHIFT_LEFT = 1,
    parameter int DATA_WIDTH = 32
)(
    input logic clk,
    input logic arst_n,
    input logic serial_in,
    input logic we,
    output logic [DATA_WIDTH-1:0] parallel_out
);
    logic [DATA_WIDTH-1:0] shift_reg;

    always_ff @(posedge clk or negedge arst_n) begin
        if (~arst_n) begin
            shift_reg <= {DATA_WIDTH{1'b0}};
        end else if (we) begin
            if(SHIFT_LEFT) begin
                shift_reg <= {shift_reg[DATA_WIDTH-2:0], serial_in};
            end else begin
                shift_reg <= {serial_in, shift_reg[DATA_WIDTH-1:1]};
            end
        //     parallel_out <= '0;
        // end else begin
        //     parallel_out <= shift_reg;
        end
    end

    assign parallel_out = we? '0 : shift_reg;
endmodule