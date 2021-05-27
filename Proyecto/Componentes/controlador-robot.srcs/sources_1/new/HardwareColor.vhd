----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 13:32:49
-- Design Name: 
-- Module Name: HardwareColor - Behavioral
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

entity HardwareColor is
  Port ( clk : in STD_LOGIC;
         serial_color : in STD_LOGIC;
         de_l : out STD_LOGIC;  -- Nuestro sensor no funciona este pin
         s0 : out STD_LOGIC;
         s1 : out STD_LOGIC;
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC;
         out_color : out integer -- 1024
       );
end HardwareColor;

architecture Behavioral of HardwareColor is

component clock is
    generic (
        FREQ_G : integer := 10        -- -- Operating frequency in Hz.
    );
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
end component;

component ColorSelector is
  Port ( color : in bit_vector(1 downto 0);
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC
 );
end component;

component ContadorFlancos is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           flanco : in STD_LOGIC;
           timeH :  out integer;
           timeD : out integer;
           end_count : out STD_LOGIC
           );
end component;


component MediaRegister is
 Port (
        enable : in std_logic;
        time_h : in integer;
        time_d : in integer;
        out_media : out integer);
end component;
-- Relojes para muestreo
signal clock_color, clock_display,clock_block : STD_LOGIC :='0'; -- Reloj para muestreo

signal s2_int, s3_int : STD_LOGIC :='0';

signal timeD_O, timeH_O, valueR, valueG, valueB: integer;
 
 -- Contador de flancos 
signal finish_count: std_logic := '0';



begin
-- Configurar reloj al doble de la frecuencia de trabajo. 0-999 
m_clock_color : clock generic map (FREQ_G =>5_000_000) port map (clk=> clk, reset =>'0', clk_out => clock_color);

-- Seleccionar color
m_selecColor : ColorSelector port map (color => "11", s2=> s2_int, s3=> s3_int);

-- Contar lo que entra del sensor
m_counter_de: ContadorFlancos port map (clk=> clock_color, reset=> '0', flanco=>serial_color, timeH =>timeH_O, timeD=>timeD_O, end_count =>finish_count);

-- Registro color
m_registerRed : MediaRegister port map (enable=> finish_count, time_h=>timeH_O, time_d=>timeD_O, out_media => out_color);


-- Config 12khz s0 <= '1' s1 <= '0'
s0<='1';
s1<='0';
-- Config 1khz s0 <= '0' s1 <= '1'

s2 <= s2_int;
s3 <= s3_int;

de_l <=finish_count;
end Behavioral;












