----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.05.2021 11:53:51
-- Design Name: 
-- Module Name: ColorSelector - Behavioral
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

entity ColorSelector is
  Port ( color : in bit_vector(1 downto 0);
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC
 );
end ColorSelector;

architecture Behavioral of ColorSelector is

begin

PROCESS (color) BEGIN 

CASE color is
    when "00" => 
     -- rojo
     s2 <='0';
     s3 <='0';
   when "01" => 
   -- VERDE
     s2 <='1';
     s3 <='1';
   when "10" => 
   -- azul
     s2 <='0';
     s3 <='1';
   when OTHERS=> 
   -- SIN FILTRO
     s2 <='1';
     s3 <='0';
END CASE;

end PROCESS;

end Behavioral;
