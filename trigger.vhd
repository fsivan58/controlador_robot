----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 16:55:28
-- Design Name: 
-- Module Name: trigger - Behavioral
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

entity trigger is
    Port (
        count  : in  std_logic_vector (21 downto 0);
        enable : in  std_logic;
        trig   : out std_logic
    );
end trigger;

architecture Behavioral of trigger is
    signal max_count : std_logic_vector(21 downto 0) := (
        0 => '0',
        1 => '1',
        2 => '0',
        3 => '1',
        others => '0'
    );
begin

    process (count) begin
        if count < max_count and enable = '1' then
            trig <= '1';
        else
            trig <= '0';
        end if;
    end process;

end Behavioral;
