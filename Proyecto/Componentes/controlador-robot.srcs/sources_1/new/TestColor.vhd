----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 15:06:05
-- Design Name: 
-- Module Name: TestColor - Behavioral
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

entity TestColor is
  Port ( clk : in STD_LOGIC;
         serial_color : in STD_LOGIC;
         s0 : out STD_LOGIC;
         s1 : out STD_LOGIC;
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC;
         
         out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic
       );
end TestColor;

architecture Behavioral of TestColor is

component HardwareColor is
  Port ( clk : in STD_LOGIC;
         serial_color : in STD_LOGIC;
         de_l : out STD_LOGIC;  -- Nuestro sensor no funciona este pin
         s0 : out STD_LOGIC;
         s1 : out STD_LOGIC;
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC;
         out_color : out integer -- 1024
       );
end component;

component clock is
    generic (
        FREQ_G : integer := 10        -- -- Operating frequency in Hz.
    );
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
end component;


component Display is
Port (  clk : in STD_LOGIC;
        number : in integer;
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic
        );
end component;

signal out_color: integer;
signal de_l : std_logic;

signal clock_display : std_logic; 

begin

m_colorh :HardwareColor port map (clk=> clk, serial_color => serial_color, de_l=>de_l, s0=>s0, s1=> s1, s2=>s2, s3=>s3, out_color=>out_color);
m_clok: clock generic map (FREQ_G=> 120) port map(clk=> clk, reset => '0', clk_out=> clock_display);

m_display :Display port map (clk=>clock_display, number=>out_color, out_display=> out_display, dig_1=>dig_1, dig_2=>dig_2, dig_3=>dig_3);
end Behavioral;
