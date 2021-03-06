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
         led_c: out std_logic;
         reset : in std_logic;
         dato_listo : out STD_LOGIC; -- Flag para cuando se termina de contar los flancos
         out_color : out integer range 0 to 1_000_000 -- 1024
       );
end SENSORCOLOR;

architecture Behavioral of SENSORCOLOR is

component FILTERCOLOR is
  Port ( color : in bit_vector(1 downto 0);
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC
 );
end component;

component PERIODO is
    Port ( CLK_FPGA : in STD_LOGIC;
           reset :in std_logic;
           channel : in STD_LOGIC;
           dato_listo : out STD_LOGIC;
           total_time :  out integer  range 0 to 2_000_000
           );
end component;

signal s2_int, s3_int : STD_LOGIC :='0'; -- Filtro color

begin

-- Seleccionar color
m_selecColor : FILTERCOLOR port map (color => "00", s2=> s2, s3=> s3);

-- Contar lo que entra del sensor
m_periodo: PERIODO port map(CLK_FPGA=> CLK_FPGA,reset=>reset, channel=>serial_color, dato_listo=>dato_listo, total_time=>out_color);

-- Config 12khz s0 <= '1' s1 <= '0'
s0<='1';
s1<='0';

led_c <= not reset; 

end Behavioral;


























