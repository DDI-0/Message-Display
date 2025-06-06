module clock_divider (
    input  logic clk_in,       
    input  logic reset_n,             
    input  logic speed_ctrl,          // Speed control: 0 = normal, 1 = fast
    output logic enable               // Enable signal pulsing at the divided clock rate
);

    // Parameters
    parameter integer f_input = 50_000_000; 
    parameter integer f_normal = 1;        
    parameter integer f_fast = 10;         

    // Toggle values for normal and fast speeds
    localparam integer toggle_normal = f_input / (2 * f_normal); 
    localparam integer toggle_fast = f_input / (2 * f_fast);     

    // Determine maximum counter width needed
    localparam integer max_toggle = (toggle_normal > toggle_fast) ? toggle_normal : toggle_fast;
    localparam integer COUNTER_WIDTH = $clog2(max_toggle);

    // Counter and current toggle value
    logic [COUNTER_WIDTH-1:0] counter;  
    logic [COUNTER_WIDTH-1:0] current_toggle;

    // Select toggle value based on speed control (combinational)
    always_comb begin
        current_toggle = (speed_ctrl == 1) ? toggle_fast[COUNTER_WIDTH-1:0] : toggle_normal[COUNTER_WIDTH-1:0];
    end

    // Enable pulsing logic
    always_ff @(posedge clk_in or negedge reset_n) begin
        if (!reset_n) begin
            counter <= 0;
            enable <= 0;
        end else begin
            if (counter == current_toggle - 1) begin
                enable <= 1; 
                counter <= 0;
            end else begin
                enable <= 0;
                counter <= counter + 1;
            end
        end
    end

endmodule