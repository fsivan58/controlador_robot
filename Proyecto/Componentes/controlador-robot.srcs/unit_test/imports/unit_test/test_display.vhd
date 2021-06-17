----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2021 16:43:09
-- Design Name: 
-- Module Name: test_display - Behavioral
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

entity test_display is
--  Port ( );
end test_display;

architecture Behavioral of test_display is


component Led7Seg is
    Port ( n_input :  in std_logic_vector (3 downto 0);
            display : out std_logic_vector (6 downto 0)
           );
end component;
signal n_input :std_logic_vector (3 downto 0);
signal display :std_logic_vector (6 downto 0);


begin

m_led : Led7Seg port map (n_input=> n_input, display => display);

process begin

 n_input<="0000";
 wait for 10ns;
 
 n_input<="0001";
 wait for 10ns;
 
 n_input<="0010";
 wait for 10ns;
 
  n_input<="0011";
 wait for 10ns;
 
  n_input<="0100";
 wait for 10ns;
 
   n_input<="0101";
 wait for 10ns;
   n_input<="0110";
 wait for 10ns;
 
    n_input<="0111";
 wait for 10ns;
 
     n_input<="1000";
 wait for 10ns;
     n_input<="1001";
 wait for 10ns;
 
 
 
end process;





end Behavioral;
