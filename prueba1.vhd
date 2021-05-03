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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prueba1 is
    port (
       clk_in : in std_logic;
       echo   : in  std_logic;
       trig   : out std_logic
    );
end prueba1;

architecture Behavioral of prueba1 is
    component clock is
        port (
            clk_in  : in  std_logic;
            nRST    : in  std_logic;
            clk_out : out std_logic 
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
    component comparator
        port (
            A : in  std_logic_vector(21 downto 0);
            B : in  std_logic_vector(21 downto 0);
            C : out std_logic
        );
    end component;
    signal clk, nRST, C_1, C_2, enable : std_logic;
    signal counter_output : std_logic_vector (21 downto 0);
    signal A_1 : std_logic_vector (21 downto 0) := std_logic_vector(to_unsigned(60, 22)); -- CAMBIAR 60 POR 60_000
    signal A_2 : std_logic_vector (21 downto 0) := std_logic_vector(to_unsigned(10, 22));
begin

    nRST <= not C_1;
    enable <= not echo;

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
            nRST => nRST,
            counter_output => counter_output
        );

    comparator_inst_1 : comparator
        port map (
            A => A_1,
            B => counter_output,
            C => C_1
        );

    comparator_inst_2 : comparator
        port map (
            A => A_2,
            B => counter_output,
            C => trig
        );


end Behavioral;
