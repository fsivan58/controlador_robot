----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 14:05:24
-- Design Name: 
-- Module Name: test_hardwarecolor - Behavioral
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

entity test_hardwarecolor is
--  Port ( );
end test_hardwarecolor;

architecture Behavioral of test_hardwarecolor is

component SENSORCOLOR is
  Port ( CLK_FPGA : in STD_LOGIC;
         serial_color : in STD_LOGIC;
         s0 : out STD_LOGIC;
         s1 : out STD_LOGIC;
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC;
         dato_listo : out STD_LOGIC;
         out_color : out integer -- 1024
       );
end component;

signal clk,serial_color,  s0,s1, s3, s2 :std_logic;
signal out_color :integer;

signal color_listo: std_logic;



begin
m_colorh :SENSORCOLOR port map (CLK_FPGA=> clk, serial_color => serial_color, s0=>s0, s1=> s1, s2=>s2, s3=>s3, dato_listo => color_listo, out_color=>out_color);


-- 50MHZ
process begin
        clk <= '0';
        wait for 10ns;
        clk <= '1';
        wait for 10ns;
end process;

process begin
    -- 6,643khz Aprox = 155 us micro segundos
     serial_color <= '0';
     wait for 75us;
     
     serial_color <= '1';
        wait for 75us;
      
end process;
end Behavioral;
