----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2021 17:03:20
-- Design Name: 
-- Module Name: test_hardware - Behavioral
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

entity test_hardware is
--  Port ( );
end test_hardware;

architecture Behavioral of test_hardware is

component HardwareCounter is
 Port ( clk : in STD_LOGIC;
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic );
end component;

signal clk : STD_LOGIC;
signal out_display :  std_logic_vector (6 downto 0);


begin
m_hardware : HardwareCounter port map(clk=>clk, out_display=> out_display);

process begin
clk<='0';
wait for 1ns;
clk<='1';
wait for 1ns;
end process;


end Behavioral;
