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

entity ultrasonidos is
    generic (k : integer := 16);
    port (
       clk_in : in    std_logic;
       echo   : in    std_logic;
       trig   : inout std_logic;
       dist   : out   std_logic;
       vcc    : out   std_logic
    );
end ultrasonidos;

architecture Behavioral of ultrasonidos is
    component clock is
        generic (
            FREQ_G : integer := 10
        );
        port (
            clk     : in  std_logic;
            reset   : in  std_logic;
            clk_out : out std_logic 
        );
    end component;
    component counter is
        generic (n : positive := 10);
        port (
            clk            : in  std_logic;
            nRST           : in  std_logic;
            enable         : in  std_logic;
            counter_output : out std_logic_vector (n-1 downto 0)
        );
    end component;
    component comparator
        generic (k : integer := 17);
        port (
            A : in  std_logic_vector(k-1 downto 0);
            B : in  std_logic_vector(k-1 downto 0);
            C : out std_logic
        );
    end component;
    signal clk_out, nRST, C_1, C_2, enable : std_logic;
    signal dist_aux : std_logic := '1';
    signal counter_output, distance : std_logic_vector (k-1 downto 0);
    signal A_1 : std_logic_vector (k-1 downto 0) := std_logic_vector(to_unsigned(60_000, k)); -- CAMBIAR 60 POR 60_000
    signal A_2 : std_logic_vector (k-1 downto 0) := std_logic_vector(to_unsigned(10, k));
    signal A_3 : std_logic_vector (k-1 downto 0) := std_logic_vector(to_unsigned(158, k));
    signal state : integer := 0;
begin

    nRST <= not C_1;
    enable <= echo;

    clock_inst : clock
        generic map (FREQ_G => 1_000_000)
        port map (
            clk => clk_in,
            reset => '0',
            clk_out => clk_out
        );

    counter_inst : counter
        generic map (k)
        port map (
            clk => clk_out,
            nRST => nRST,
            enable => '1',
            counter_output => counter_output
        );
     
    counter_dist : counter
        generic map(k)
        port map (
            clk => clk_out,
            nRST => nRST,
            enable => enable,
            counter_output => distance   
        );

    comparator_inst_1 : comparator
        generic map (k)
        port map (
            A => A_1,
            B => counter_output,
            C => C_1
        );

    comparator_inst_2 : comparator
        generic map (k)
        port map (
            A => A_2,
            B => counter_output,
            C => trig
        );
        
     comparator_inst_3 : comparator
        generic map (k)
        port map (
            A => A_3,
            B => distance,
            C => dist_aux
        );
        
    process (clk_in, echo) begin
        if echo'event then
            state <= state + 1;
        end if;
        if state = 3 then
            dist <= dist_aux and not echo;
        else
            dist <= '0';
        end if;
        if trig = '1' then
            state <= 1;
            dist <= '0';
        end if;
    end process;

end Behavioral;
