----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2021 10:18:40
-- Design Name: 
-- Module Name: comparator_test - Behavioral
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

entity test_comparator is
--  Port ( );
end test_comparator;

architecture Behavioral of test_comparator is
    component comparator
        generic (k : integer := 16);
        port (
            A      : in  std_logic_vector(k-1 downto 0);
            B      : in  std_logic_vector(k-1 downto 0);
            C      : out std_logic
        );
    end component;
    signal A : std_logic_vector (16 downto 0) := (
        0 => '0',
        1 => '1',
        2 => '0',
        3 => '1',
        others => '0'
    );
    signal B : std_logic_vector (16 downto 0) := (others => '0');
    signal C : std_logic;
    signal counter : integer := 0;
begin

    comparator_simul : comparator
    generic map(17)
    port map (
        A => A,
        B => B,
        C => C
    );

    process begin
        B <= std_logic_vector(to_unsigned(counter, 17));
        counter <= counter + 1;
        wait for 1us;
    end process;

end Behavioral;
