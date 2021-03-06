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

entity CLOCK is
    generic (
        FREQ_G : integer := 10        -- -- Operating frequency in Hz.
    );
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
end CLOCK;

architecture Behavioral of CLOCK is
    constant max_count : integer   := (50_000_000/FREQ_G)/2 - 1;
    signal   count     : integer   range 0 to max_count;
    signal   state     : std_logic := '1';
begin

process (clk, reset)
begin
 if rising_edge(clk) then
     if reset = '1' then
        state <= '0';
        count <= 0;
      else
        if count = max_count then
           state <= not state;
           count <= 0;
        else
            count <= count + 1;
        end if;
      end if;
 end if;
 
        
end process;

 clk_out <= state;


end Behavioral;

