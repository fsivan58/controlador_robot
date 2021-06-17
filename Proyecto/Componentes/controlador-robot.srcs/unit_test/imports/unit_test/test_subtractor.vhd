----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2021 08:08:26 PM
-- Design Name: 
-- Module Name: subtractor_test - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_subtractor is
--  Port ( );
end test_subtractor;

architecture Behavioral of test_subtractor is
    component subtractor
        generic (k : integer := 16);
        port (
            a : in  std_logic_vector (k-1 downto 0);
            b : in  std_logic_vector(k-1 downto 0);
            s : out std_logic_vector (k-1 downto 0)
        );
    end component;
    signal a, b, s: std_logic_vector (16 downto 0);
begin

    subtractor_simul: component subtractor port map (
        a => a,
        b => b,
        s => s
    );
    
    process begin
    
        a <= std_logic_vector(to_unsigned(100, 16));
        b <= std_logic_vector(to_unsigned(100, 16));
        wait for 5ns;
    
        a <= std_logic_vector(to_unsigned(100, 16));
        b <= std_logic_vector(to_unsigned(101, 16));
        wait for 5ns;
    
        a <= std_logic_vector(to_unsigned(100, 16));
        b <= std_logic_vector(to_unsigned(60, 16));
        wait for 5ns;

    end process;

end Behavioral;
