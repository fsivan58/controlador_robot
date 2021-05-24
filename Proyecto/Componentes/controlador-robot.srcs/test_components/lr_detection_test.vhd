----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/23/2021 08:43:02 AM
-- Design Name: 
-- Module Name: lr_detection_test - Behavioral
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

entity lr_detection_test is
--  Port ( );
end lr_detection_test;

architecture Behavioral of lr_detection_test is
    component lr_detection
        port (
            clk    : in    std_logic;
            echo_l : in    std_logic;
            echo_r : in    std_logic;
            echo_f : in    std_logic;
            trig_l : inout std_logic;
            trig_r : inout std_logic;
            trig_f : inout std_logic;
            obs_l  : out   std_logic;
            obs_r  : out   std_logic;
            obs_f  : out   std_logic
        );
    end component;
    signal clk, trig_l, trig_r, trig_f, obs_l, obs_r, obs_f : std_logic;
    signal echo_l, echo_r, echo_f : std_logic := '0';
begin

    lr_detection_test : lr_detection
        port map (
            clk => clk,
            echo_l => echo_l,
            echo_r => echo_r,
            echo_f => echo_f,
            trig_l => trig_l,
            trig_r => trig_r,
            trig_f => trig_f,
            obs_l => obs_l,
            obs_r => obs_r,
            obs_f => obs_f
        );

    process begin
        clk <= '0';
        wait for 10ns;
        clk <= '1';
        wait for 10ns;
    end process;
    
    process begin
        wait for 30us;
        echo_l <= '1';
        echo_f <= '1';
        wait for 125us;
        echo_f <= '0';
        wait for 75us;
        echo_l <= '0';
        wait;
    end process;
    
    process begin
        wait for 80us;
        echo_r <= '1';
        wait for 100us;
        echo_r <= '0';
        wait;
    end process;

end Behavioral;
