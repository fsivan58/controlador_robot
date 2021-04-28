----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 19:11:21
-- Design Name: 
-- Module Name: trigger_test - Behavioral
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

entity trigger_test is
--  Port ( );
end trigger_test;

architecture Behavioral of trigger_test is
    component trigger
        port (
            count  : in  std_logic_vector (21 downto 0);
            enable : in  std_logic;
            trig   : out std_logic
        );
    end component;
    signal count        : std_logic_vector (21 downto 0);
    signal trig, enable : std_logic;
    signal counter      : integer := 0;
begin

    trigger_simul : trigger port map (
        count => count,
        enable => enable,
        trig => trig
    );

    process begin
        enable <= '1';
        count <= std_logic_vector(to_unsigned(counter, 22));
        counter <= counter + 1;
        wait for 1us;
    end process;

end Behavioral;
