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

entity prueba1_test is
--  Port ( );
end prueba1_test;

architecture Behavioral of prueba1_test is
    component prueba1
        port (
           clk_in : in STD_LOGIC;
           echo : in STD_LOGIC;
           trig : out STD_LOGIC
        );
    end component;
    signal clk_in, echo, trig : std_logic;
begin

    prueba1_simul : prueba1
        port map (
            clk_in => clk_in,
            echo => echo,
            trig => trig
        );

    process begin
        clk_in <= '1';
        wait for 5ns;
        clk_in <= '0';
        wait for 5ns;
    end process;
    
    process begin
        echo <= '0';
        wait for 30us;
        echo <= '1';
        wait for 10us;
        echo <= '0';
    end process;

end Behavioral;
