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
  Port ( CLK_FPGA : in STD_LOGIC;
         serial_color : in STD_LOGIC;
         s0 : out STD_LOGIC;
         s1 : out STD_LOGIC;
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC;
         dato_listo : out STD_LOGIC; 
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
           flanco : in STD_LOGIC;
           dato_listo : out STD_LOGIC;
           timeH :  out integer;
           timeD : out integer
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

signal data_listo_internal: std_logic := '0';


begin
-- Configurar reloj al doble de la frecuencia de trabajo. 0-999 
m_clock_color : clock generic map (FREQ_G =>4_000_000) port map (clk=> CLK_FPGA, reset =>'0', clk_out => clock_color);

-- Seleccionar color
m_selecColor : ColorSelector port map (color => "11", s2=> s2_int, s3=> s3_int);

-- Contar lo que entra del sensor
m_counter_de: ContadorFlancos port map (clk=> clock_color, flanco=>serial_color, dato_listo => finish_count, timeH =>timeH_O, timeD=>timeD_O);


-- Config 12khz s0 <= '1' s1 <= '0'
s0<='1';
s1<='0';
-- Config 1khz s0 <= '0' s1 <= '1'

s2 <= s2_int;
s3 <= s3_int;
-- Finaliza la cuenta y envia el de mayor valor
dato_listo <= data_listo_internal;

process (CLK_FPGA)
begin 
if rising_edge(CLK_FPGA) then
        IF finish_count ='1' THEN
            if timeH_O > timeD_O then
                out_color <= timeH_O;
            else 
                out_color <= timeD_O;
             end if;
             data_listo_internal <='1';
         else
            data_listo_internal <='0';
        END IF;
end if;
end process;


end Behavioral;












