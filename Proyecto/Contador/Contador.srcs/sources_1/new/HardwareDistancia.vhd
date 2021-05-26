----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.05.2021 18:48:37
-- Design Name: 
-- Module Name: HardwareDistancia - Behavioral
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

entity HardwareDistancia is
  
    port (
       clk_in : in    std_logic;
       echo   : in    std_logic;
       trig   : out std_logic;
       
       out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic ;
        led : out std_logic
    );
end HardwareDistancia;

architecture Behavioral of HardwareDistancia is

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

component Display is
Port (  clk : in STD_LOGIC;
        number : in integer;
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic
        );
end component;


component INTESC_LIB_ULTRASONICO_RevC is

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

    signal  clk_display: std_logic;
   
    signal numn : integer range 0 to 999;
    
    signal dato_listo   : std_logic := '0';
    signal distancia_cm : std_logic_vector(8 downto 0) := (others => '0');

begin

m_clk_display : clock generic map (FREQ_G =>120) port map (clk=> clk_in,reset =>'0', clk_out => clk_display);

m_display : Display port map (clk => clk_display, number => numn, out_display => out_display, dig_1=>dig_1, dig_2=>dig_2, dig_3 => dig_3);

m_distance : INTESC_LIB_ULTRASONICO_RevC   generic map (FPGA_CLK => 50_000_000) port map (CLK=> clk_in, ECO=>echo, TRIGGER=>trig,DATO_LISTO=> dato_listo, DISTANCIA_CM=>distancia_cm);

numn <= to_integer(unsigned(distancia_cm));

process(clk_in)
begin
if rising_edge(clk_in) then
    if DATO_LISTO = '1' then
        if distancia_cm < "000011110" then -- 30cm en binario en 9 bits
           led <= '1';
        else
           led <= '0';
        end if;
    end if;
end if;
end process;

end Behavioral;
