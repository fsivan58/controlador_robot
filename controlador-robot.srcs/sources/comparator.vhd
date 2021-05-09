----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2021 10:12:47
-- Design Name: 
-- Module Name: comparator - Behavioral
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

entity comparator is
    port (
        A : in  std_logic_vector(15 downto 0);
        B : in  std_logic_vector(15 downto 0);
        C : out std_logic
    );
end comparator;

architecture Behavioral of comparator is
    component subtractor
        port (
            a     : in  std_logic_vector (15 downto 0);
            b     : in  std_logic_vector(15 downto 0);
            s     : out std_logic_vector (15 downto 0)
        );
    end component;
    signal diff : std_logic_vector (15 downto 0);
    signal zero : std_logic_vector (15 downto 0) := (others => '0');
begin

    subtractor_inst : subtractor port map (
        a => a,
        b => b,
        s => diff
    );

    C <= '0' when diff = zero or diff(15) = '1' else '1';

end Behavioral;
