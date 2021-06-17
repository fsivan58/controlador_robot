----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2021 01:01:18
-- Design Name: 
-- Module Name: test_clock - Behavioral
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

entity test_clock is
--  Port ( );
end test_clock;

architecture testbench of test_clock is

 component clock
  generic (
    FREQ_G       : integer     -- Operating frequency in Hz.
    );
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
    end component;
    signal clk, reset, clk_out: STD_LOGIC;

begin

clock_1mhz : clock generic map (FREQ_G => 1_000_000)
        port map (
        clk  => clk,
        reset => reset,
        clk_out => clk_out
    );
    process begin
        clk <= '0';
        wait for 10ns;
        clk <= '1';
        wait for 10ns;
    end process;
    
--    process begin
--        reset <= '0';
--        wait for 200ns;
--       -- nRST <= '1';
--       -- wait for 200ns;
--    end process;

end architecture testbench;
