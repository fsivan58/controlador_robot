----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2021 14:16:35
-- Design Name: 
-- Module Name: sem7 - Behavioral
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

entity sem7 is
    Port ( n_input  : in bit_vector (3 downto 0);
           pos      : in STD_LOGIC;
           display  : out std_logic_vector (6 downto 0);
           pos_out : out STD_LOGIC);
end sem7;

architecture Behavioral of sem7 is

begin

pos_out <= pos;
		  --GFEDCBA
display <= "1000000" WHEN n_input ="0000" ELSE
           "1111001" WHEN n_input ="0001" ELSE
           "0100100" WHEN n_input ="0010" ELSE
           "0110000" WHEN n_input ="0011" ELSE
           "0011001" WHEN n_input ="0100" ELSE
           "0010010" WHEN n_input ="0101" ELSE
           "0000010" WHEN n_input ="0110" ELSE
           "1111000" WHEN n_input ="0111" ELSE
           "0000000" WHEN n_input ="1000" ELSE
           "0000110"; 

end Behavioral;
