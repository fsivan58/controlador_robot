----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2021 10:18:25
-- Design Name: 
-- Module Name: ContadorPulsos - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ContadorPulsos is
    generic(n : positive := 4);
    Port ( pulso : in STD_LOGIC;
           vector : out std_logic_vector (n-1 downto 0);
           end_counter : out STD_LOGIC );
end ContadorPulsos;

architecture Behavioral of ContadorPulsos is
 signal count : integer := 0;
  signal end_counter_int : STD_LOGIC := '0';
begin

process (pulso) begin
        if rising_edge(pulso) then
         if count = n-1 then
            count <= 0;
            end_counter_int <= '1';
         else
            end_counter_int <='0';
            count <= count + 1;
            end if;     
        end if;
end process;
    
vector <= std_logic_vector(to_unsigned(count, n));
end_counter <= end_counter_int;

end Behavioral;




