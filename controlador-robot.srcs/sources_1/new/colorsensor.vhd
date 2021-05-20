----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2021 00:18:42
-- Design Name: 
-- Module Name: colorsensor - Behavioral
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

entity colorsensor is
    Port ( clk : in STD_LOGIC;
           serial_color : in STD_LOGIC;
           start: in STD_LOGIC;
           de_l : out STD_LOGIC;
           s0 : out STD_LOGIC;
           s1 : out STD_LOGIC;
           s2 : out STD_LOGIC;
           s3 : out STD_LOGIC;
           vector_filtro : out bit_vector(1 downto 0) );
end colorsensor;

architecture Behavioral of colorsensor is
 
  component colorselector
         Port ( color : in bit_vector(1 downto 0);
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC);
    end component;
    
   component ContadorFlancos   
     Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           flanco : in STD_LOGIC;
           timeH :  out integer;
           timeD : out integer;
           end_count : out STD_LOGIC
           );
    end component;
    
    component ContadorPulsos
        generic(n : positive := 3);
        Port ( pulso : in STD_LOGIC;
               vector : out std_logic_vector (n-1 downto 0);
               end_counter : out STD_LOGIC );
    end component;
        
  -- Señales
     signal type_color_input : bit_vector (1 downto 0);
     signal vector_contador : std_logic_vector (2 downto 0);
     signal end_count_fl, end_count_pulsos: STD_LOGIC;
     signal timeD_O, timeH_O: integer;
     
begin

 comp_colorselector : colorselector
        port map (
            color => type_color_input,
            s2 => s2,
            s3 => s3
        );
        
 comp_flancos : ContadorFlancos 
        port map (
        clk  => clk, 
        reset=>end_count_fl, 
        flanco=>serial_color, 
        timeH =>timeH_O, 
        timeD =>timeD_O, 
        end_count=>  end_count_fl 
        );
 
 comp_pulsos : ContadorPulsos
    generic map(3)
    port map (
        pulso => end_count_fl,
        vector => vector_contador,
        end_counter => end_count_pulsos
    );
    
-- 12Khz
s0<='1';
s1<='0';
de_l <= not start;

type_color_input(0) <= to_bit(vector_contador(0));
type_color_input(1) <= to_bit(vector_contador(1));

vector_filtro <= type_color_input;

process (clk)
begin
case vector_contador is
    when "00"=>
    -- Red color
    
    when "01"=>
    -- Green color
    when "10"=>
    -- Blue color
end case;


end process;





end Behavioral;






















