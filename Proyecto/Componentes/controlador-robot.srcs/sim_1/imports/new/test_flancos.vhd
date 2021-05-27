----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.05.2021 00:13:47
-- Design Name: 
-- Module Name: test_flancos - Behavioral
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

entity test_flancos is
--  Port ( );
end test_flancos;

architecture Behavioral of test_flancos is

component ContadorFlancos is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           flanco : in STD_LOGIC;
           timeH :  out integer;
           timeD : out integer;
           end_count : out STD_LOGIC
           );
end component;

signal clk, flanco,end_count : std_logic:='0';
signal timeH, timeD: integer;

begin


m_contador : ContadorFlancos port map (clk=>clk,reset=>'0', flanco =>flanco, timeH=>timeH, timeD => timeD, end_count => end_count);

process begin
clk<='0';
wait for 10 ns;
clk<='1';
wait for 10 ns;
end process;

process begin
flanco<='0';
wait for 100 ns;
flanco<='1';
wait for 100 ns;
end process;

end Behavioral;






















