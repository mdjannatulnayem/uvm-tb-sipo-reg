// module sipo_reg #(
//     parameter int SHIFT_LEFT = 1,
//     parameter int DATA_WIDTH = 32
// )(
//     input logic clk,
//     input logic arst_n,
//     input logic serial_in,
//     input logic we,
//     output logic [DATA_WIDTH-1:0] parallel_out
// );
//     logic [DATA_WIDTH-1:0] shift_reg;

//     always_ff @(posedge clk or negedge arst_n) begin
//         if (~arst_n) begin
//             shift_reg <= {DATA_WIDTH{1'b0}};
//         end else if (we) begin
//             if(SHIFT_LEFT) begin
//                 shift_reg <= {shift_reg[DATA_WIDTH-2:0], serial_in};
//             end else begin
//                 shift_reg <= {serial_in, shift_reg[DATA_WIDTH-1:1]};
//             end
//         //     parallel_out <= '0;
//         // end else begin
//         //     parallel_out <= shift_reg;
//         end
//     end

//     assign parallel_out = we? '0 : shift_reg;
// endmodule


module sipo_reg #(
    parameter int DATA_WIDTH = 32
)(
    input logic clk,
    input logic arst_n,
    input logic serial_in,
    input logic load,
    input logic out_dir, // 0: LSB first, 1: MSB first
    input logic shift_dir, // 0: Shift Right, 1: Shift Left

    output logic [DATA_WIDTH-1:0] parallel_out
);
    logic [DATA_WIDTH-1:0] shift_reg;

    // Shift left / shift right
    always_ff @(posedge clk or negedge arst_n) begin
        if (~arst_n) begin
            shift_reg <= '0;
        end else if (load) begin
            if (shift_dir) begin // Shift left
                shift_reg <= {shift_reg[DATA_WIDTH-2:0], serial_in};
            end else begin // Shift right
                shift_reg <= {serial_in, shift_reg[DATA_WIDTH-1:1]};
            end
        end
    end
    
    assign parallel_out = load ? '0 : out_dir ? reverse_bits(shift_reg) : shift_reg;


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

endmodule
