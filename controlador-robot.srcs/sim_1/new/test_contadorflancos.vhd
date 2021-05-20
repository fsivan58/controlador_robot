----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2021 01:35:22
-- Design Name: 
-- Module Name: test_contadorflancos - Behavioral
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

entity test_contadorflancos is
--  Port ( );
end test_contadorflancos;

architecture testbench of test_contadorflancos is

component ContadorFlancos
    Port ( clk : in STD_LOGIC;
           flanco : in STD_LOGIC;
           timeH :  out integer;
           timeD : out integer
           );
end component;
    signal clk, flanco: STD_LOGIC;
    signal timeD_O, timeH_O: integer;

begin

flancos_comp : ContadorFlancos port map (clk  => clk, flanco=>flanco, timeH =>timeH_O, timeD =>timeD_O );

process begin
     clk <= '1';
     wait for 10ns;
     clk <= '0';
     wait for 10ns;
end process;

process begin
     flanco <= '1';
     wait for 40ns;
     flanco <= '0';
     wait for 40ns;
end process;

end testbench;



















