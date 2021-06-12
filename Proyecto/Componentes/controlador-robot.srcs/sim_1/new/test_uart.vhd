----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.06.2021 20:19:25
-- Design Name: 
-- Module Name: test_uart - Behavioral
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

entity test_uart is
--  Port ( );
end test_uart;

architecture Behavioral of test_uart is

signal fpga : std_logic := '0';
signal RX_INPUNT : std_logic := '0';
signal READY : std_logic := '0';
signal RX_DATA: std_logic_vector (7 downto 0);

constant c_BIT_PERIOD : time := 122 us;
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

begin



m_uart :UART_RX generic map (TOTAL_BITS => 5208) port map (CLK_FPGA =>fpga ,RX_INPUNT=> RX_INPUNT, READY => READY, RX_DATA=> RX_DATA );

-- 50MHZ
process begin
        fpga <= '0';
        wait for 10ns;
        fpga <= '1';
        wait for 10ns;
end process;



process begin
        RX_INPUNT <= '1';
        wait for 100us;
        
         RX_INPUNT <= '0';
        wait for c_BIT_PERIOD;
        RX_INPUNT <= '1';
        wait for c_BIT_PERIOD;
          RX_INPUNT <= '0';
        wait for c_BIT_PERIOD;
          RX_INPUNT <= '0';
        wait for c_BIT_PERIOD;
          RX_INPUNT <= '0';
        wait for c_BIT_PERIOD;
          RX_INPUNT <= '1';
        wait for c_BIT_PERIOD;
        RX_INPUNT <= '0';
        wait for c_BIT_PERIOD;
        RX_INPUNT <= '0';
        wait for c_BIT_PERIOD;
end process;






end Behavioral;
