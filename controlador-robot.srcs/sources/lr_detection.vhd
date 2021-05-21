----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2021 09:27:52 PM
-- Design Name: 
-- Module Name: lr_detection - Behavioral
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

entity lr_detection is
    Port ( clk    : in    STD_LOGIC;
           echo_l : in    STD_LOGIC;
           echo_r : in    STD_LOGIC;
           trig_l : inout STD_LOGIC;
           trig_r : inout STD_LOGIC;
           obs_l  : out   STD_LOGIC;
           obs_r  : out   STD_LOGIC);
end lr_detection;

architecture Behavioral of lr_detection is
    component ultrasonidos is
        generic (k : integer := 17);
        port (
           clk_in : in    std_logic;
           echo   : in    std_logic;
           trig   : inout std_logic;
           dist   : out   std_logic;
           vcc    : out   std_logic
        );
    end component;
begin

    ultrasonidos_left : ultrasonidos
        generic map (17)
        port map (
            clk_in => clk,
            echo => echo_l,
            trig => trig_l,
            dist => obs_l
        );

    ultrasonidos_right: ultrasonidos
        generic map (17)
        port map (
            clk_in => clk,
            echo => echo_r,
            trig => trig_r,
            dist => obs_r
        );

end Behavioral;
