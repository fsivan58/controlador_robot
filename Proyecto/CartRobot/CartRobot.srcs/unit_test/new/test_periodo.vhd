----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.06.2021 15:14:17
-- Design Name: 
-- Module Name: test_periodo - Behavioral
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

entity test_periodo is
--  Port ( );
end test_periodo;

architecture Behavioral of test_periodo is

component PERIODO is
    Port ( CLK_FPGA : in STD_LOGIC;
           reset :in std_logic;
           channel : in STD_LOGIC;
           dato_listo : out STD_LOGIC;
           total_time :  out integer  range 0 to 2_000_000
           );
end component;

signal CLK_FPGA : std_logic;
signal clock_4Mhzr : std_logic;
signal channel : std_logic;
signal presscale : std_logic;
signal dato_listo : std_logic;
signal total_time : integer;


begin
m_periodo: PERIODO port map(CLK_FPGA=> CLK_FPGA,reset=>'0', channel=>channel, dato_listo=>dato_listo, total_time=>total_time);

-- 50MHZ
process begin
        CLK_FPGA <= '0';
        wait for 10ns;
        CLK_FPGA <= '1';
        wait for 10ns;
end process;


process begin
    channel<='0';
    wait for 100 ns;
   
    channel<='1';  -- 4mhz
    wait for 75us ;
    channel<='0';
    wait for 75us;
    
    
    channel<='1';  -- 2mhz
    wait for 80us;
    channel<='0';
    wait for 80us;
   
    
     channel<='1';  -- 1mhz
    wait for 1 us;
    channel<='0';
    wait for 1 us;
    channel<='1';  -- 1mhz
    wait for 1 us;
    channel<='0';
    wait for 1 us;

end process;
end Behavioral;
