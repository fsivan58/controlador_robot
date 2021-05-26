----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.05.2021 12:44:12
-- Design Name: 
-- Module Name: test_HardwareColor - Behavioral
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

entity test_HardwareColor is
--  Port ( );
end test_HardwareColor;

architecture Behavioral of test_HardwareColor is


component HardwareColor is
  Port ( clk : in STD_LOGIC;
         serial_color : in STD_LOGIC;
         sw1 : in std_logic;
            de_l : out STD_LOGIC;
            s0 : out STD_LOGIC;
            s1 : out STD_LOGIC;
            s2 : out STD_LOGIC;
            s3 : out STD_LOGIC;
            
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic ;
        led : out std_logic
        
            );
end component;

signal clk, serial_color, sw1 : STD_LOGIC;
 signal DISTANCIA_CM_OUT :  STD_LOGIC_VECTOR(8 DOWNTO 0);
  signal numn : integer;
begin

 m_comonent : HardwareColor port map (clk=>clk, serial_color =>serial_color, sw1 =>sw1);

process begin
clk<='0';
wait for 20ns;
clk<='1';
wait for 20ns;
DISTANCIA_CM_OUT <= "000000100";
numn <= to_integer(unsigned(DISTANCIA_CM_OUT));
end process;
end Behavioral;
