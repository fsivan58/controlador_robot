----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2021 10:29:33
-- Design Name: 
-- Module Name: test_cuentapulsos - Behavioral
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

entity test_cuentapulsos is
--  Port ( );
end test_cuentapulsos;

architecture testbench of test_cuentapulsos is

component ContadorPulsos
  generic(n : positive := 4);
    Port ( pulso : in STD_LOGIC;
           vector : out std_logic_vector (n-1 downto 0);
           end_counter : out STD_LOGIC );
end component;

    signal pulso: STD_LOGIC;
    signal vector: std_logic_vector (3 downto 0);
    signal end_counter: STD_LOGIC;
    
begin

pulsos_comp : ContadorPulsos
    generic map(4)
    port map (
        pulso => pulso,
        vector => vector,
        end_counter => end_counter
    );

process begin
     pulso <= '1';
     wait for 10ns;
     pulso <= '0';
     wait for 10ns;
end process;

end testbench;










