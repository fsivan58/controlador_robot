----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 17:46:08
-- Design Name: 
-- Module Name: counter_test - Behavioral
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

entity counter_test is
--  Port ( );
end counter_test;

architecture Behavioral of counter_test is
    component counter is
        generic(n : positive := 10);
        port(
            clk            : in  std_logic;
            nRST           : in  std_logic;
            enable         : in  std_logic;
            counter_output : out std_logic_vector (n-1 downto 0)
        );
    end component;
    signal clk, nRST, enable : std_logic;
    signal counter_output : std_logic_vector (15 downto 0);
    signal count : integer := 0;
begin
    counter_simul :
        counter generic map (16)
        port map (
            clk => clk,
            nRST => nRST,
            enable => enable,
            counter_output => counter_output
        );
    
    process (counter_output) begin
        count <= to_integer(unsigned(counter_output));
        if count < 9 then
            nRST <= '0';
        else
            nRST <= '1';
        end if;
    end process;

    process begin
        clk <= '1';
        wait for 500ns;
        clk <= '0';
        wait for 500ns;
    end process;

end Behavioral;
