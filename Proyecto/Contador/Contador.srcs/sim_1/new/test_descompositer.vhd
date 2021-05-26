----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2021 17:13:14
-- Design Name: 
-- Module Name: test_descompositer - Behavioral
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

entity test_descompositer is
--  Port ( );
end test_descompositer;

architecture Behavioral of test_descompositer is

component Descompositer is
    Port ( in_number : in integer;
           s0 : in STD_LOGIC;
           s1 : in STD_LOGIC;
           out_vector : out std_logic_vector  (3 downto 0));
end component;
    signal m_number: integer :=0;
    signal s0, s1: std_logic;
    signal out_vector : std_logic_vector (3 downto 0);

begin

com_descompositer: Descompositer port map(in_number=>m_number, s0=>s0, s1=> s1, out_vector => out_vector);

process begin
    m_number<=897;
    wait for 100ns;
end process;

process begin
     s0<='0';
     s1<='0';
    wait for 10ns;
     s0<='1';
     s1<='0';
    wait for 10ns;
     s0<='0';
     s1<='1';
    wait for 10ns;
end process;



end Behavioral;








