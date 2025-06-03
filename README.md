# Message-Display
Clock Divider:\
Module created to display a delay visible to the human eye. The board I used was the De10-Lite which has a 50Mhz clock.
The clock divider helped to reduce it from 50Mhz to 1Hz, which is able to be seen by the human Eye. <br><br>
Message Storage:\
Module created to store the message statically to a ROM. The message format was in ASCII. <br><br>
ASCII converter:\
Module created to manually map the ASCII value to a binary pattern for the 7-segment display.  <br><br>
Scrolling Logic:\
The scrolling module uses a circular buffer to manage scrolling, storing the message in a fixed-size array. Arithmetic to ensure the scrolling wraps around, with display_chars acting as a dynamic window into the buffer, shifting based on scroll_index and scroll_dir.



![Circular_Buffer_Animation-2](https://github.com/user-attachments/assets/e673cbb9-dfe2-4145-a29f-2b5a3eb699e4)
