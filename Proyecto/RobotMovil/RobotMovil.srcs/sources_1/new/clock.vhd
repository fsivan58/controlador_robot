----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2021 13:30:55
-- Design Name: 
-- Module Name: clock1hz - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock is
 generic (
    FREQ_G       : integer := 50        -- -- Operating frequency in Hz.
    );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clock;

architecture Behavioral of clock is
    constant   max_count : integer := (50_000_000/FREQ_G) -1;
    signal   count    : integer   range 0 to max_count;
    signal   state    : std_logic := '1';
begin

frequency_divider: process (clk)
    begin
        if reset = '1' then
            state <= '0';
            count <= 0;
         elsif clk'event then
            if count = max_count then
                state <= not state;
                count <= 0;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    
      clk_out <= state;

end Behavioral;