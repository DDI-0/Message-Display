module scrolling #(
    parameter MSG_LEN = 11,         // Length of the scrolling message
    parameter CHAR_WIDTH = 8,       // Width of each character
    parameter NUM_DISPLAYS = 6      
)(
    input  logic clk,               
    input  logic rst_n,             // Active-low reset
    input  logic scroll_dir,        // Scroll direction: 0 = left-to-right, 1 = right-to-left
    output logic [CHAR_WIDTH-1:0] display_chars [NUM_DISPLAYS-1:0] // Characters for displays
);

    // Message buffer (stores the entire message)
    logic [CHAR_WIDTH-1:0] message [MSG_LEN-1:0];

    // Scroll index (tracks which part of the message is visible on the displays)
    logic [$clog2(MSG_LEN+1)-1:0] scroll_index;

    // Initialize the message with "HELLO 1234"
    initial begin
        message[0] = 8'b01001000; // 'H'
        message[1] = 8'b01000101; // 'E'
        message[2] = 8'b01001100; // 'L'
        message[3] = 8'b01001100; // 'L'
        message[4] = 8'b01001111; // 'O'
        message[5] = 8'b00100000; // ' ' (space)
        message[6] = 8'b00110001; // '1'
        message[7] = 8'b00110010; // '2'
        message[8] = 8'b00110011; // '3'
        message[9] = 8'b00110100; // '4'
		  message[10] = 8'b00100000; // ' ' (space)

    end

    // Scrolling logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            scroll_index <= 0; 
        end else begin
            // Increment index to scroll the message
            if (scroll_index == MSG_LEN)
                scroll_index <= 0; // Wrap around
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
                display_chars[i] = message[(scroll_index + MSG_LEN - i) % MSG_LEN];
            end
        end
    end

endmodule
