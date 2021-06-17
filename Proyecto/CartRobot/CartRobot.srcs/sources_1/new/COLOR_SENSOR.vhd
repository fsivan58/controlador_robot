----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.06.2021 01:18:04
-- Design Name: 
-- Module Name: SENSORCOLOR - Behavioral
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

entity SENSORCOLOR is
  Port ( CLK_FPGA : in STD_LOGIC;
         serial_color : in STD_LOGIC;
         s0 : out STD_LOGIC;
         s1 : out STD_LOGIC;
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC;
         dato_listo : out STD_LOGIC; 
         out_color : out integer range 0 to 1_000_000 -- 1024
       );
end SENSORCOLOR;

architecture Behavioral of SENSORCOLOR is

component CLOCK is
    generic (
        FREQ_G : integer := 10        -- -- Operating frequency in Hz.
    );
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
end component;

component FILTERCOLOR is
  Port ( color : in bit_vector(1 downto 0);
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC
 );
end component;

component ContadorFlancos is
    Port ( clk : in STD_LOGIC;
           flanco : in STD_LOGIC;
           dato_listo : out STD_LOGIC;
           timeH :  out integer  range 0 to 1_000_000;
           timeD : out integer  range 0 to 1_000_000
           );
end component;

-- Relojes para muestreo
signal clock_muestreo: STD_LOGIC :='0'; -- Reloj para muestreo

signal s2_int, s3_int : STD_LOGIC :='0'; -- Filtro color

signal timeD_O, timeH_O : integer  range 0 to 1_000_000;
 
 -- Contador de flancos 
signal dato_listo_fr: std_logic := '0';
signal dato_listo_count: std_logic := '0';


begin

-- Configurar reloj al doble de la frecuencia de trabajo. 0-999 
m_clock_color : CLOCK generic map (FREQ_G =>4_000_000) port map (clk=> CLK_FPGA, reset =>'0', clk_out => clock_muestreo);

-- Seleccionar color
m_selecColor : FILTERCOLOR port map (color => "11", s2=> s2_int, s3=> s3_int);

-- Contar lo que entra del sensor
m_counter_de: ContadorFlancos port map (clk=> clock_muestreo, flanco=>serial_color, dato_listo => dato_listo_fr, timeH =>timeH_O, timeD=>timeD_O);


-- Config 12khz s0 <= '1' s1 <= '0'
s0<='1';
s1<='0';

-- Color filtro
s2 <= s2_int;
s3 <= s3_int;

-- Flag para cuando se termina de contar los flancos
dato_listo <= dato_listo_count;

process (CLK_FPGA)
begin 
    if rising_edge(CLK_FPGA) then
            if dato_listo_fr ='1' then
                if timeH_O > timeD_O then
                    out_color <= timeH_O;
                else 
                    out_color <= timeD_O;
                 end if;
                dato_listo_count <= '1';
             else
                dato_listo_count <= '0';
            end if;
    end if;
end process;



end Behavioral;


























