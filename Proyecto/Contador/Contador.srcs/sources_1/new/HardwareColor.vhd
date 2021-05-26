----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.05.2021 11:58:37
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
         sw1 : in std_logic;
            de_l : out STD_LOGIC;
            s0 : out STD_LOGIC;
            s1 : out STD_LOGIC;
            s2 : out STD_LOGIC;
            s3 : out STD_LOGIC;
            
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic ;
        led : out std_logic
       
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

component Display is
Port (  clk : in STD_LOGIC;
        number : in integer;
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic
        );
end component;



signal clock_color, clock_display,clock_block : STD_LOGIC :='0'; -- Reloj para muestreo

signal finish_count : STD_LOGIC;
 signal recR, recG, RecB: STD_LOGIC;
 signal timeD_O, timeH_O, valueR, valueG, valueB: integer;
 
 signal s2_int, s3_int : STD_LOGIC;
 
 signal color_time, color_current : integer;
 signal signal_register : STD_LOGIC := '1';
 signal sto : STD_LOGIC := '0';
   
begin


m_clock_color : clock generic map (FREQ_G =>100_000) port map (clk=> clk, reset =>'0', clk_out => clock_color);

m_clock_dis : clock generic map (FREQ_G =>120) port map (clk=> clk, reset =>'0', clk_out => clock_display);

m_clock_block : clock generic map (FREQ_G =>4) port map (clk=> clk, reset =>'0', clk_out => clock_block);

-- Seleccionar color
m_selecColor : ColorSelector port map (color => "11", s2=> s2_int, s3=> s3_int);

-- Contar lo que entra del sensor
m_counter_de: ContadorFlancos port map (clk=> clock_color, reset=> '0', flanco=>serial_color, timeH =>timeH_O, timeD=>timeD_O, end_count =>finish_count);

-- Registro color
m_registerRed : MediaRegister port map (enable=> finish_count, time_h=>timeH_O, time_d=>timeD_O, out_media => color_current);

-- Ver lo que sale en el display
m_display : Display port map (clk => clock_display, number => color_time, out_display => out_display, dig_1=>dig_1, dig_2=>dig_2, dig_3 => dig_3);

-- 12khz
s0<='0';
s1<='1';

process (clock_block) begin
if rising_edge(clock_block) then
    color_time <= color_current;
   signal_register <= not signal_register;
end if;
end process;

led <= signal_register;
de_l <= sw1;



end Behavioral;














