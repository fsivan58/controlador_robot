----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.05.2021 16:00:21
-- Design Name: 
-- Module Name: LOGIC_SWICH - Behavioral
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

entity LOGIC_SWICH is
    Port ( CLK_PGA : in STD_LOGIC;
             sw_in : in STD_LOGIC;
           sw_out : out STD_LOGIC);
end LOGIC_SWICH;

architecture Behavioral of LOGIC_SWICH is


component CLOCK is
    generic (
        FREQ_G : integer := 10        -- -- Operating frequency in Hz.
    );
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
end component;

signal last_state : std_logic :='1';
signal bloquedo : std_logic :='0';
signal clk_out : std_logic:='0';
begin
m_clock_1hz : CLOCK generic map (FREQ_G => 5) port map (clk=> CLK_PGA, reset =>'0',clk_out=> clk_out );

process (clk_out) begin
 if rising_edge(clk_out) then
     if bloquedo = '1' and sw_in ='1' then
             bloquedo<='0';
     elsif bloquedo = '0' and sw_in ='0' then
           bloquedo<='1';
           last_state <= not last_state;
     end if;
 end if; 
end process;

sw_out <= last_state;
end Behavioral;




