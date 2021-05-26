----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2021 16:12:19
-- Design Name: 
-- Module Name: test_counter - Behavioral
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

entity test_counter is
--  Port ( );
end test_counter;

architecture testbech of test_counter is

component  Counter is
 Port ( clk : in STD_LOGIC;
        out_c : out integer);
end component;

    signal m_out: integer;
    signal clk: STD_LOGIC;

begin

m_component : Counter port map (clk => clk, out_c => m_out);

process  begin
    clk <='0';
 wait for 60ns;
  clk <='1';
 wait for 60ns;
end process;

end testbech;
