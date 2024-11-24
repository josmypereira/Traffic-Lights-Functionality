library ieee;
use ieee.std_logic_1164. all;
use ieee.numeric_std.all;

entity TrafficLightsTb is 
end entity;

architecture sim of TrafficLightsTb is

	-- We are usig a low clock frequency to speed up the simulation
	constant ClockFrequencyHz : integer := 100;  --100 Hz
	constant ClockPeriod      : time    := 1000 ms / ClockFrequencyHz;
	
	signal CLK         : std_logic := '1';
	signal nRST		   : std_logic := '0';
	signal NorthRed    : std_logic;
	signal NorthYellow : std_logic;
	signal NorthGreen  : std_logic;
	signal WestRed	   : std_logic;
	signal WestYellow  : std_logic;
	signal WestGreen   : std_logic;
begin
	
	-- The Device Under Test (DUT)
	i_TrafficLights : entity work.TrafficLights(rtl)
	generic map(ClockFrequencyHz => 100)
	port map (
		Clk        		=> CLK,
		nRST	   		=> nRST,
		NorthRed   		=> NorthRed,
		NorthYellow     => NorthYellow,
		NorthGreen      => NorthGreen,
		WestRed         => WestRed,
		WestYellow      => WestYellow,
		WestGreen       => WestGreen);
		
		-- Process for generating clock
		Clk <= not Clk after ClockPeriod / 2;
		
		-- Testbench sequence
		process is 
		begin
			wait until rising_edge(Clk);
			wait until rising_edge(Clk);
			
			-- Take the DUT out of reset
			nRST <= '1';
			
			wait;  -- Infinite wait to keep the process alive
		end process;
	end architecture;