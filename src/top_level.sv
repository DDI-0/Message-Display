module top_level (
    input  logic clk_50mhz,            // 50 MHz input clock
    input  logic reset_n,              // Active-low reset
    input  logic dir_switch,           // Switch for direction: 0 = L-to-R, 1 = R-to-L
    input  logic speed_switch,         // Switch for speed: 0 = normal, 1 = fast
    output logic[6:0] hex_segments[5:0]
);

    // Parameters
    localparam MSG_LEN = 11;           
    localparam CHAR_WIDTH = 8;         
    localparam NUM_DISPLAYS = 6;       

    // Internal Signals
    logic enable_top;                  // Scrolling clock 
    logic [CHAR_WIDTH-1:0] display_chars [NUM_DISPLAYS-1:0]; 
    logic [6:0] segment_data [NUM_DISPLAYS-1:0];            

    clock_divider #(
        .f_input(50_000_000),         
        .f_normal(1),                 
        .f_fast(10)                    
    ) clk_div_inst (
        .clk_in(clk_50mhz),
        .reset(reset_n),
        .speed_ctrl(speed_switch),    
        .enable(enable_top)
    );

    // Scrolling Logic
scrolling #(
     .MSG_LEN(MSG_LEN),
     .CHAR_WIDTH(CHAR_WIDTH),
     .NUM_DISPLAYS(NUM_DISPLAYS)
) scrolling_inst (
        .enable(enable_top),  // changed          
        .rst_n(reset_n),
        .scroll_dir(dir_switch),      // Connect the direction control switch
        .display_chars(display_chars)
    );

   //  Conversion for Each Display
    genvar i;
    generate
        for (i = 0; i < NUM_DISPLAYS; i++) begin : ascii_to_seg
            converter ascii_to_seg_inst (
                .ascii_in(display_chars[i]),
                .seg_out(segment_data[i])
            );
        end
    endgenerate

  assign hex_segments = segment_data;

endmodule
