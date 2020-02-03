-- hexcount.vhd --

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hexcount is
	Port ( clk_50MHz : in STD_LOGIC;
				  --anode : out STD_LOGIC_VECTOR (3 downto 0);
					 --seg : out STD_LOGIC_VECTOR (6 downto 0)
					 displays : OUT STD_LOGIC_VECTOR (41 DOWNTO 0)
					 );
end hexcount;

architecture Behavioral of hexcount is

component counter is
	Port ( clk : in STD_LOGIC;
			 count : out STD_LOGIC_VECTOR (15 downto 0); --NEED CHANGE! counter now output 16 bits for all 4 displays
			 mpx   : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component leddec is
	Port ( dig : in STD_LOGIC_VECTOR (1 downto 0);
			 data : in STD_LOGIC_VECTOR (3 downto 0); --DONT change, data is fixed 4 bits in leddec for each displays
			 --anode: out STD_LOGIC_VECTOR (3 downto 0);
			 --seg : out STD_LOGIC_VECTOR (6 downto 0)
			 displays : OUT STD_LOGIC_VECTOR (41 DOWNTO 0)
			 );
end component;

signal S: STD_LOGIC_VECTOR (15 downto 0); -- connect C1 and L1 for values of 4 digits
signal md: STD_LOGIC_VECTOR (1 downto 0); -- mpx selects displays
signal display: STD_LOGIC_VECTOR (3 downto 0); -- send digit for only one display to leddec

begin
C1: counter port map (clk=>clk_50MHz, count=>S, mpx=>md);
--L1: leddec port map(dig=>md, data=>display, anode=>anode, seg=>seg);
L1: leddec port map(dig=>md, data=>display, displays=>displays);



--mpx
--process(md)
--begin
--	if md = "00" then
--		display <= S(3 downto 0);
--	elsif md = "01" then
--		display <= S(7 downto 4);
--	elsif md = "10" then
--		display <= S(11 downto 8);
--	elsif md = "11" then
--		display <= S(15 downto 12);
--	end if;
--end process;

display <= S(3 downto 0) when md = "00" else
           S(7 downto 4) when md = "01" else
			  S(11 downto 8) when md = "10" else
			  S(15 downto 12);

end Behavioral;