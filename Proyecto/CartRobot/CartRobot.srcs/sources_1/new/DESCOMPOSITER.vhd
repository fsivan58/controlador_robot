----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.05.2021 01:10:36
-- Design Name: 
-- Module Name: DESCOMPOSITER - Behavioral
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

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DESCOMPOSITER is
Port ( in_number : in integer;
           s0 : in STD_LOGIC;
           s1 : in STD_LOGIC;
           out_vector : out std_logic_vector(3 downto 0)
           );
end DESCOMPOSITER;

architecture Behavioral of DESCOMPOSITER is
signal unidades : integer range 0 to 9 := 0;
signal decenas: integer range 0 to 9 := 0;
signal centenas : integer range 0 to 9 :=0;
signal out_vector_inter :  std_logic_vector(3 downto 0) := (others => '0');

begin

process (unidades, decenas,centenas, s0, s1) begin 
    if(s0='0' and s1='0') then
        out_vector_inter <= std_logic_vector(to_unsigned(unidades, 4));
    elsif (s0='1' and s1='0') then 
        out_vector_inter <= std_logic_vector(to_unsigned(decenas, 4));
    elsif (s0='0' and s1='1') then 
        out_vector_inter <= std_logic_vector(to_unsigned(centenas, 4));
    end if;
end process;

process (in_number) begin
    centenas <= in_number / 100;
    decenas <= (in_number - (centenas*100) )/10;
    unidades <= (in_number - centenas*100 - decenas*10);  
end process;

out_vector <= out_vector_inter;

end Behavioral;
