----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2021 01:05:22
-- Design Name: 
-- Module Name: test_colorselector - Behavioral
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

entity test_filtercolor is
--  Port ( );
end test_filtercolor;

architecture testbench of test_filtercolor is


component FILTERCOLOR
  Port ( color : in bit_vector(1 downto 0);
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC
    );
end component;

    signal color_s: bit_vector(1 downto 0);
    signal s2_o: STD_LOGIC;
    signal s3_o: STD_LOGIC;

begin

color_filter: FILTERCOLOR port map (color  => color_s, s2=>s2_o, s3 =>s3_o );

 process begin
     color_s <= "00";
     wait for 10ns;
     color_s <= "01";
     wait for 10ns;
    color_s <= "10";
     wait for 10ns;
      color_s <= "11";
       wait for 10ns;
end process;

end testbench;
