----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2021 15:36:25
-- Design Name: 
-- Module Name: CounterStatus - Behavioral
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

entity CounterStatus is
    Port ( clk : in STD_LOGIC;
           s0 : out STD_LOGIC;
           s1 : out STD_LOGIC);
end CounterStatus;

architecture Behavioral of CounterStatus is
signal mcounter  : integer :=0;
begin

m_counter: process (clk)
 begin
    if rising_edge(clk) then
        if(mcounter = 2) then
            mcounter <=0;
        else 
            mcounter <= mcounter +1;
        end if;
        
         if(mcounter = 0) then
            s0 <='0';
            s1 <='0';
         elsif mcounter =1 then
            s0 <='1';
            s1 <='0';
         else 
           s0 <='0';
           s1 <='1';
         end if; 
    end if;
end process;








end Behavioral;
