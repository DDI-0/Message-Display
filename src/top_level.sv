module top_level (
    input  wire clk_50mhz,            // 50 MHz input clock
    input  wire reset_n,              // Active-low reset
    input  wire dir_switch,           // Switch for direction: 0 = L-to-R, 1 = R-to-L
    input  wire speed_switch,         // Switch for speed: 0 = normal, 1 = fast
    output wire [6:0] hex0_segments,  
    output wire [6:0] hex1_segments,  
    output wire [6:0] hex2_segments,  
    output wire [6:0] hex3_segments,  
    output wire [6:0] hex4_segments,  
    output wire [6:0] hex5_segments  
);

    // Parameters
    parameter MSG_LEN = 11;           
    parameter CHAR_WIDTH = 8;         
    parameter NUM_DISPLAYS = 6;       

    // Internal Signals
    wire clk_scroll;                  // Scrolling clock 
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
        .clk_out(clk_scroll)
    );

    // Scrolling Logic
scrolling #(
     .MSG_LEN(MSG_LEN),
     .CHAR_WIDTH(CHAR_WIDTH),
     .NUM_DISPLAYS(NUM_DISPLAYS)
) scrolling_inst (
        .clk(clk_scroll),            
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

    // Assign Segment Outputs to Each HEX Display
    assign hex0_segments = segment_data[0];
    assign hex1_segments = segment_data[1];
    assign hex2_segments = segment_data[2];
    assign hex3_segments = segment_data[3];
    assign hex4_segments = segment_data[4];
    assign hex5_segments = segment_data[5];

endmodule
