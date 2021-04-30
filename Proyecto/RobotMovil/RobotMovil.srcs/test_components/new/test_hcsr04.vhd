----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2021 16:31:02
-- Design Name: 
-- Module Name: test_hcsr04 - Behavioral
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

entity test_hcsr04 is
--  Port ( );
end test_hcsr04;

architecture Behavioral of test_hcsr04 is
component hcsr04
  generic (
    FREQ_G       : real := 12.0;        -- Operating frequency in MHz.
    SENSE_FREQ_G : real := 20.0  -- Number of times distance is sensed per second.
    );
  port (
    clk_i   : in  std_logic;            -- Input clock.
    trig_o  : out std_logic;
    echo_i  : in  std_logic;
    dist_o  : out std_logic_vector (31 downto 0)
    );
end component;
   signal clk,  echo_i, trig_o: STD_LOGIC;
   signal dist_s : std_logic_vector(31 downto 0);

begin

hcsr04simul : hcsr04 generic map (FREQ_G => 12.0, SENSE_FREQ_G => 20.0)  
        port map (
        clk_i  => clk,
        trig_o  => trig_o,
        echo_i => echo_i,
        dist_o => dist_s
    );

process begin
    clk <= '1';
    wait for 10ns;
    clk <= '0';
    wait for 10ns;
end process;

process begin
    wait for 5 us;
    echo_i <= '1';
    wait for 1 us;
    echo_i <= '0';
    wait for 1 us;
    echo_i <= '1';
    wait for 10 us;
end process;


end Behavioral;







