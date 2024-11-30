module clock_divider (
    input  logic clk_in,       
    input  logic reset,        // Active-low reset
    input  logic speed_ctrl,   // Speed control: 0 = normal, 1 = 5x speed
    output logic  clk_out       
);

    // Parameters
    parameter integer f_input = 50_000_000; // Input clock frequency (50 MHz)
    parameter integer f_normal = 1;        // Normal scrolling frequency (1 Hz)
    parameter integer f_fast = 10;          // Fast scrolling frequency (10 Hz)

    // Toggle values for normal and fast speeds
    localparam integer toggle_normal = f_input / (2 * f_normal); 
    localparam integer toggle_fast = f_input / (2 * f_fast);     

    // Counter and toggle value selection
    logic [$clog2(toggle_normal)-1:0] counter = 0;  // -> calculate bit size log_2(n)
    integer toggle;                              

    // Clock division logic
    always_ff @(posedge clk_in or negedge reset) begin
        if (!reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            // Select toggle value based on speed control
            toggle = (speed_ctrl == 1) ? toggle_fast : toggle_normal; // if true fast esle normal
            if (counter == toggle - 1) begin
                clk_out <= ~clk_out; 
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
