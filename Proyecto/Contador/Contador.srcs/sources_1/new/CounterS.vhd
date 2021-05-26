----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.05.2021 18:53:13
-- Design Name: 
-- Module Name: CounterS - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CounterS is
 generic(n : positive := 10);
    port(
        clk            : in  std_logic;
        nRST           : in  std_logic;
        enable         : in  std_logic;
        counter_output : out std_logic_vector (n-1 downto 0)
    );
end CounterS;

architecture Behavioral of CounterS is
  signal count : integer := 0; 
begin
  process (clk, nRST, enable) begin
        if nRST = '1' then
            count <= 0;
        end if;
        if rising_edge(clk) and enable = '1' then
            count <= count + 1;
        end if;
    end process;
    counter_output <= std_logic_vector(to_unsigned(count, n));

end Behavioral;
