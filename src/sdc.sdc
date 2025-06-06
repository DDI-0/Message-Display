# Create a clock for clk_in with a 50 MHz frequency (20 ns period)
create_clock -name clk_in -period 20.000 [get_ports clk_in]
create_generated_clock -name enable_normal -source [get_ports clk_in] -divide_by 50000000 [get_ports enable]

create_generated_clock -name enable_fast -source [get_ports clk_in] -divide_by 5000000 [get_ports enable]

