----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.05.2021 16:00:21
-- Design Name: 
-- Module Name: LOGIC_SWICH - Behavioral
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

entity LOGIC_SWICH is
    Port ( CLK_PGA : in STD_LOGIC;
             sw_in : in STD_LOGIC;
           sw_out : out STD_LOGIC);
end LOGIC_SWICH;

architecture Behavioral of LOGIC_SWICH is
signal last_state : std_logic :='0';
begin

process (CLK_PGA) begin
 if rising_edge(CLK_PGA) then
     if(sw_in ='0') then
     last_state <= not last_state;
     end if;
 end if; 
end process;

sw_out <= last_state;
end Behavioral;




