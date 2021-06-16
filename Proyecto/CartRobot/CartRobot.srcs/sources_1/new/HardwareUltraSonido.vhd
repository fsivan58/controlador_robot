----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.05.2021 21:50:48
-- Design Name: 
-- Module Name: HardwareUltraSonido - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HardwareUltraSonido is
  Port (  CLK_FPGA: in std_logic;

       echo_left    : in  std_logic;
       echo_right   : in  std_logic;
       echo_front   : in  std_logic;  
       
       trig_left    : out std_logic;
       trig_right   : out std_logic;
       trig_front   : out std_logic;
       
       obst_front   : out std_logic;
       obst_left    : out std_logic;
       obst_right   : out std_logic;
       crash        : out std_logic;
       distance : out integer range 0 to 999
   );
end HardwareUltraSonido;

architecture Behavioral of HardwareUltraSonido is

component ULTRASONIDO is
generic(
			FPGA_CLK : INTEGER := 50_000_000
);
PORT(
		CLK 			 : IN  STD_LOGIC;                   -- Reloj del FPGA.
		ECO 			 : IN  STD_LOGIC;                   -- Eco del sensor ultrasónico.
		TRIGGER 		 : OUT STD_LOGIC;                   -- Trigger del sensor ultrasónico.
		DATO_LISTO 	 : OUT STD_LOGIC;                   -- Bandera que indica cuando el valor de la distancia es correcto.
		DISTANCIA_CM : OUT STD_LOGIC_VECTOR(8 DOWNTO 0) -- Valor de la distancia en centímetros-
);
end component;

CONSTANT MIN_DISTANCE 		  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000001010"; 

CONSTANT MIN_DISTANCE_LADOS   : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000001110"; 

 signal dato_left_listo, dato_right_listo, dato_front_listo   : std_logic := '0';
 signal distancia_left,distancia_right, distancia_front : std_logic_vector(8 downto 0) := (others => '0');
 
 
begin

m_distance_left : ULTRASONIDO  generic map (FPGA_CLK => 50_000_000) port map (CLK=> CLK_FPGA, ECO=>echo_left, TRIGGER=>trig_left,DATO_LISTO=> dato_left_listo, DISTANCIA_CM=>distancia_left);

m_distance_right : ULTRASONIDO  generic map (FPGA_CLK => 50_000_000) port map (CLK=> CLK_FPGA, ECO=>echo_right, TRIGGER=>trig_right,DATO_LISTO=> dato_right_listo, DISTANCIA_CM=>distancia_right);

m_distance_front : ULTRASONIDO  generic map (FPGA_CLK => 50_000_000) port map (CLK=> CLK_FPGA, ECO=>echo_front, TRIGGER=>trig_front,DATO_LISTO=> dato_front_listo, DISTANCIA_CM=>distancia_front);

---- Detectar obstaculo izquierdo
process(CLK_FPGA)
begin
if rising_edge(CLK_FPGA) then
    if dato_left_listo = '1' then
        if distancia_left < MIN_DISTANCE_LADOS then -- 10cm en binario en 9 bits
           obst_left <= '1';
        else
           obst_left <= '0';
        end if;
    end if;
end if;
end process;
------------------------

---- Detectar obstaculo frontal
process(CLK_FPGA)
begin
if rising_edge(CLK_FPGA) then
    if dato_front_listo = '1' then
        if distancia_front < MIN_DISTANCE then -- 10cm en binario en 9 bits
            obst_front <= '1';
            if(distancia_front <= "000000011") then -- 4 cm en binario
                crash <='1';
            else 
                 crash <='0';
            end if;
        else
           obst_front <= '0';
        end if;
    end if;
end if;
end process;
------------------------

---- Detectar obstaculo derecho
process(CLK_FPGA)
begin
if rising_edge(CLK_FPGA) then
    if dato_right_listo = '1' then
        if distancia_right < MIN_DISTANCE_LADOS then -- 10cm en binario en 9 bits
           obst_right <= '1';
        else
           obst_right <= '0';
        end if;
    end if;
end if;
end process;
------------------------

-- medir distancia 
distance <= to_integer(unsigned(distancia_front));


end Behavioral;
