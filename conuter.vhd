-- counter.vhd --

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
	Port ( clk : in STD_LOGIC;
			 count : out STD_LOGIC_VECTOR (15 downto 0); --NEED REVISE! 16 bits
			 mpx   : out STD_LOGIC_VECTOR (1 downto 0)); --NEW ONE ADD! send signal to select displays
end counter;

architecture Behavioral of counter is
signal cnt: STD_LOGIC_VECTOR (38 downto 0); -- 39 bit counter
begin
		process(clk)
		begin
				if clk'event and clk='1' then -- on rising edge of clock
									 cnt <= cnt+1; -- increment counter
				end if;
		end process;
		count <= cnt (38 downto 23); -- 16bits
		mpx <= cnt (18 downto 17); -- 2bits
end Behavioral;