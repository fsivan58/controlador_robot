----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.05.2021 01:07:39
-- Design Name: 
-- Module Name: DISPLAY - Behavioral
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

entity DISPLAY is
Port (  clk : in STD_LOGIC;
        number : in integer;
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic
        );
end DISPLAY;

architecture Behavioral of DISPLAY is

component SHOWDIGIT is
    Port ( clk : in STD_LOGIC;
           s0 : out STD_LOGIC;
           s1 : out STD_LOGIC);
end component;

component DESCOMPOSITER is
    Port ( in_number : in integer;
           s0 : in STD_LOGIC;
           s1 : in STD_LOGIC;
           out_vector : out std_logic_vector  (3 downto 0));
end component;

component Led7Seg is
    Port ( n_input :  in std_logic_vector (3 downto 0);
            display : out std_logic_vector (6 downto 0)
           );
end component;


signal s0 : STD_LOGIC :='0';
signal s1 : STD_LOGIC :='0';
signal current_number : std_logic_vector (3 downto 0);

begin

m_digit: SHOWDIGIT port map(clk => clk, s0=>s0, s1=> s1);
m_descompositer: DESCOMPOSITER port map(in_number=>number, s0=>s0, s1=> s1, out_vector => current_number);
m_led : Led7Seg port map (n_input => current_number, display=> out_display);

process (s0, s1)
begin

if(s0='0' and s1='0') then
      dig_1 <= '0';
      dig_2 <= '0';
      dig_3 <= '1';
elsif (s0='1' and s1='0') then 
       dig_1 <= '0';
      dig_2 <= '1';
      dig_3 <= '0';
elsif (s0='0' and s1='1') then 
      dig_1 <= '1';
      dig_2 <= '0';
      dig_3 <= '0';
end if;

end process;


end Behavioral;
