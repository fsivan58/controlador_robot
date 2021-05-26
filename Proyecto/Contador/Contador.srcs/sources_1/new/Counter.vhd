----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2021 16:07:22
-- Design Name: 
-- Module Name: Counter - Behavioral
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

entity Counter is
    Port ( clk : in STD_LOGIC;
           out_c : out integer);
end Counter;

architecture Behavioral of Counter is
signal mcounter  : integer :=0;
signal max : integer :=999;

begin

m_counter: process (clk)
 begin
    if rising_edge(clk) then
        if(mcounter = max) then
            mcounter <=0;
        else 
            mcounter <= mcounter +1;
        end if;
    end if;
end process;

out_c <= mcounter;

end Behavioral;








