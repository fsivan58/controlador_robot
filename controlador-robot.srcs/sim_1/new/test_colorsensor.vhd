----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2021 14:50:01
-- Design Name: 
-- Module Name: test_colorsensor - Behavioral
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

entity test_colorsensor is
--  Port ( );
end test_colorsensor;

architecture testbench of test_colorsensor is

 component colorsensor
    Port ( clk : in STD_LOGIC;
           serial_color : in STD_LOGIC;
           start: in STD_LOGIC;
           de_l : out STD_LOGIC;
           s0 : out STD_LOGIC;
           s1 : out STD_LOGIC;
           s2 : out STD_LOGIC;
           s3 : out STD_LOGIC;
           vector_filtro : out bit_vector(1 downto 0) );
 end component;
   
     -- Externas
 signal s0, s1,  s2, s3,  clk, de_l, serial_color, mstart: STD_LOGIC;
 signal vector_filtro: bit_vector(1 downto 0);
 

begin

 comp_colorsensor : colorsensor
        port map (
            clk => clk,
            serial_color => serial_color,
            start => mstart,
            de_l => de_l,
            s0 => s0,
            s1 => s1,
            s2 => s2,
            s3 => s3,
            vector_filtro => vector_filtro
        );

process  begin
    clk <= '0';
    wait for 10ns;
    clk <= '1';
    wait for 10ns;
end process;


process  begin
    mstart <= '0';
    wait for 50ns;
    mstart <= '1';
    wait for 120ns;
end process;

process  begin
    serial_color <= '0';
    wait for 50ns;
    serial_color <= '1';
    wait for 20ns;
    if(mstart = '1') then
        serial_color <= '0';
        wait for 20ns;
        serial_color <= '1';
        wait for 20ns;
        serial_color <= '0';
        wait for 20ns;
        serial_color <= '1';
        wait for 20ns;
        serial_color <= '0';
        wait for 20ns;
    end if;
    
  
end process;


 

end testbench;



















