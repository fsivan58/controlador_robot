----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.06.2021 21:34:27
-- Design Name: 
-- Module Name: THardware_ULTRASONIDO - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity THardware_ULTRASONIDO is
 Port ( 
                CLK_FPGA : in STD_LOGIC;
               echo:  in  std_logic;
               trigger:  out  std_logic;
               
                    led_r6 : out std_logic;
                    out_display : out std_logic_vector (6 downto 0);
                    dig_1 : out std_logic;
                    dig_2 : out std_logic;
                    dig_3 : out std_logic
        );
end THardware_ULTRASONIDO;

architecture Behavioral of THardware_ULTRASONIDO is

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


component Display is
Port (  clk : in STD_LOGIC;
        number : in integer;
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic
        );
end component;


signal dato_listo_reg: std_logic:= '0';
signal distancia_reg  : std_logic_vector(8 downto 0) := (others => '0');
signal clock_display : std_logic; 
signal disntace_num : integer range 0 to 999 :=0;

begin

m_distance: ULTRASONIDO  generic map (FPGA_CLK => 50_000_000) port map (CLK=> CLK_FPGA, ECO=>ECHO, TRIGGER=>trigger,DATO_LISTO=> dato_listo_reg, DISTANCIA_CM=>distancia_reg);

m_display :Display port map (clk=>clock_display, number=>disntace_num, out_display=> out_display, dig_1=>dig_1, dig_2=>dig_2, dig_3=>dig_3);

led_r6 <= not dato_listo_reg;

process (CLK_FPGA)
begin
 if rising_edge(CLK_FPGA) then
    if dato_listo_reg = '1' then
        disntace_num <=  to_integer(unsigned(distancia_reg));
    end if;
 end if;
end process;

end Behavioral;
