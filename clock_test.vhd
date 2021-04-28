----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2021 06:02:46 PM
-- Design Name: 
-- Module Name: clockTest - Behavioral
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

entity clockTest is
--  Port ( );
end clockTest;

architecture testbench of clockTest is
    component clock
    port (
        clk_in : in  std_logic;
        nRST   : in  std_logic;
        clk_out: out std_logic
    );
    end component;
    signal clk_in, nRST, clk_out: STD_LOGIC;
begin
    clocksimul : clock port map (
        clk_in  => clk_in,
        nRST    => nRST,
        clk_out => clk_out
    );
    process begin
        clk_in <= '1';
        wait for 5ns;
        clk_in <= '0';
        wait for 5ns;
    end process;
    
    process begin
        wait for 100ns;
        nRST <= '1';
        wait for 100ns;
        nRST <= '0';
        wait;
    end process;
end architecture testbench;
