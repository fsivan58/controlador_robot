----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.06.2021 08:09:53
-- Design Name: 
-- Module Name: Hardaware_UART - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity THardaware_UART is
         Port ( 
                CLK_FPGA : in STD_LOGIC;
                RX_INPUNT : in std_logic;
                    led_r6 : out std_logic;
                    out_display : out std_logic_vector (6 downto 0);
                    dig_1 : out std_logic;
                    dig_2 : out std_logic;
                    dig_3 : out std_logic
        );


end THardaware_UART;

architecture Behavioral of THardaware_UART is

signal clock_display : std_logic; 
signal m_ready : std_logic; 
SIGNAL  RX_DATA_I:  std_logic_vector(7 downto 0); 
signal out_color : integer range 0 to 999 :=0;

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


component UART_RX is
  generic (
        TOTAL_BITS : integer := 5208        -- -- calcular x bauoliod
    );
    Port ( 
    CLK_FPGA : in std_logic;
    RX_INPUNT : in std_logic;
    READY : out std_logic;
    RX_DATA: out std_logic_vector(7 downto 0) 
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

begin

m_clok: clock generic map (FREQ_G=> 120) port map(clk=> CLK_FPGA, reset => '0', clk_out=> clock_display);
m_uart :UART_RX generic map (TOTAL_BITS => 5208) port map (CLK_FPGA =>CLK_FPGA ,RX_INPUNT=> RX_INPUNT, READY => m_ready, RX_DATA=> RX_DATA_I );
m_display :Display port map (clk=>clock_display, number=>out_color, out_display=> out_display, dig_1=>dig_1, dig_2=>dig_2, dig_3=>dig_3);

process (CLK_FPGA)
begin
 if rising_edge(CLK_FPGA) then
    if m_ready = '1' then
        out_color <=  to_integer(unsigned(RX_DATA_I));
    end if;
 end if;
end process;


led_r6 <= m_ready;

end Behavioral;





























