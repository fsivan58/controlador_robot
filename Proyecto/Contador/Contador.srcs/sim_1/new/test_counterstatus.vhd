----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2021 15:41:44
-- Design Name: 
-- Module Name: test_counterstatus - Behavioral
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

entity test_counterstatus is
--  Port ( );
end test_counterstatus;

architecture Behavioral of test_counterstatus is

component CounterStatus is
    Port ( clk : in STD_LOGIC;
           s0 : out STD_LOGIC;
           s1 : out STD_LOGIC);
end component;
signal clk : STD_LOGIC :='0';
signal s0 : STD_LOGIC :='0';
signal s1 : STD_LOGIC :='0';
begin

m_coun: CounterStatus port map(clk => clk, s0=>s0, s1=> s1);

process
begin
  clk<='0';
 wait for 20ns;
  clk<='1';
 wait for 20ns;
end process;


end Behavioral;
