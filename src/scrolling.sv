module scrolling #(
    parameter MSG_LEN = 11,         
    parameter CHAR_WIDTH = 8,       
    parameter NUM_DISPLAYS = 6      
)(
    input  logic clk,                 
    input  logic rst_n,               // Active-low reset
    input  logic enable,              // Enable signal from clock divider
    input  logic scroll_dir,          // Scroll direction: 0 = left-to-right, 1 = right-to-left
    output logic [CHAR_WIDTH-1:0] display_chars [NUM_DISPLAYS-1:0] // Characters for displays
);

    // Message buffer (stores the entire message) 
    localparam logic [CHAR_WIDTH-1:0] message [MSG_LEN-1:0] = '{
        8'b01001000, // 'H'
        8'b01000101, // 'E'
        8'b01001100, // 'L'
        8'b01001100, // 'L'
        8'b01001111, // 'O'
        8'b00100000, // space
        8'b00110001, // '1'
        8'b00110010, // '2'
        8'b00110011, // '3'
        8'b00110100, // '4'
        8'b00100000  // space
    };

    // Scroll index (tracks which part of the message is visible on the displays)
    logic [$clog2(MSG_LEN+1)-1:0] scroll_index;

    // Scrolling logic - use proper clock domain
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            scroll_index <= 0; 
        end else if (enable) begin  // Only update when enable is high
            // Increment index to scroll the message
            if (scroll_index == MSG_LEN - 1)  
                scroll_index <= 0; 
            else
                scroll_index <= scroll_index + 1;
        end
    end

    // Update output characters for displays
    always_comb begin
        for (int i = 0; i < NUM_DISPLAYS; i++) begin
            if (scroll_dir == 0) begin
                // Left-to-right scrolling
                display_chars[i] = message[(scroll_index + i) % MSG_LEN];
            end else begin
                // Right-to-left scrolling
                display_chars[i] = message[(MSG_LEN - 1 - i + scroll_index) % MSG_LEN];
            end
        end
    end

endmodule