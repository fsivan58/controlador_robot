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
    FREQ_G       : integer := 50        -- Operating frequency in MHz.
    );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clock;

architecture Behavioral of clock is

    signal   count    : integer   range 0 to FREQ_G;
    signal   state    : std_logic := '1';
begin

    frequency_divider: process (clk)
    begin
        if reset = '1' then
            state <= '0';
            count <= 0;
        else 
            if count = FREQ_G then
                state <= not state;
                count <= 0;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    process (state)
    begin
        clk_out <= state;
    end process;

end Behavioral;