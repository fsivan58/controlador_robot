----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 22:56:03
-- Design Name: 
-- Module Name: prueba1 - Behavioral
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

entity prueba1 is
    port (
       clk_in : in STD_LOGIC;
       echo : in STD_LOGIC;
       trig : out STD_LOGIC
    );
end prueba1;

architecture Behavioral of prueba1 is
    component clock is
        port (
            clk_in : in  std_logic;
            nRST   : in  std_logic;
            clk_out: out std_logic 
        );
    end component;
    component counter is
        generic (n : positive := 10);
        port (
            clk            : in  std_logic;
            nRST           : in  std_logic;
            counter_output : out std_logic_vector (n-1 downto 0)
        );
    end component;
    component trigger
        port (
            count  : in  std_logic_vector (21 downto 0);
            enable : in  std_logic;
            trig   : out std_logic
        );
    end component;
    signal clk, trig_out : std_logic;
    signal counter_output : std_logic_vector (21 downto 0);
begin

    clock_inst : clock
        port map (
            clk_in => clk_in,
            nRST => '0',
            clk_out => clk
        );

    counter_inst : counter
        generic map (22)
        port map (
            clk => clk,
            nRST => (trig_out nand echo),
            counter_output => counter_output
        );
        
    trigger_inst : trigger
        port map (
            count => counter_output,
            enable => not echo,
            trig => trig_out
        );

end Behavioral;
