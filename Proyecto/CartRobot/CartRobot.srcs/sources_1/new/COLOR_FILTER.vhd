----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2021 00:20:33
-- Design Name: 
-- Module Name: colorselector - Behavioral
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

entity FilterColor is
  Port ( color : in bit_vector(1 downto 0);
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC
 );
end FilterColor;

architecture Behavioral of FILTERCOLOR is

begin

PROCESS (color) BEGIN 

CASE color is
    when "00" => 
     -- rojo
     s2 <='0';
     s3 <= '0';
   when "01" => 
   -- VERDE
     s2 <='1';
     s3 <= '1';
   when "10" => 
   -- azul
     s2 <='0';
     s3 <= '1';
   when OTHERS=> 
   -- SIN FILTRO
     s2 <='1';
     s3 <= '0';
END CASE;

end PROCESS;

end Behavioral;
