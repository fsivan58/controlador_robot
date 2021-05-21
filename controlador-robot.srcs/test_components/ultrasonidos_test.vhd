----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 23:17:45
-- Design Name: 
-- Module Name: prueba1_test - Behavioral
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

entity ultrasonidos_test is
--  Port ( );
end ultrasonidos_test;

architecture Behavioral of ultrasonidos_test is
    component ultrasonidos
        generic (k : integer := 16);
        port (
           clk_in : in    std_logic;
           echo   : in    std_logic;
           trig   : inout std_logic;
           dist   : out   std_logic
        );
    end component;
    signal clk_in, echo, trig, dist : std_logic;
begin

    ultrasonidos_simul : ultrasonidos
        generic map (17)
        port map (
            clk_in => clk_in,
            echo => echo,
            trig => trig,
            dist => dist
        );

    process begin
        clk_in <= '0';
        wait for 10ns;
        clk_in <= '1';
        wait for 10ns;
    end process;
 
    process begin
        echo <= '0';
        wait for 900us;
        echo <= '1';
        wait for 100us;
        echo <= '0';
        wait for 60_000us;
        echo <= '1';
        wait for 20us;
        echo <= '0';
        wait;
    end process;

end Behavioral;
