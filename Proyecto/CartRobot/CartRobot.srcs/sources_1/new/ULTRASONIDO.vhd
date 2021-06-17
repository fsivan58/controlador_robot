----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.05.2021 21:45:51
-- Design Name: 
-- Module Name: ULTRASONIDO - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ULTRASONIDO is
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
end ULTRASONIDO;

architecture Behavioral of ULTRASONIDO is

CONSTANT VAL_1US 					  : INTEGER := (FPGA_CLK/1_000_000); -- Constante con el número de periodos de CLK que hay en un microsegundo. Se utiliza para el cálculo de la distancia.
CONSTANT ESCALA_PERIODO_TRIGGER : INTEGER := (FPGA_CLK/16);        -- Constante para generar el periodo del Trigger.
CONSTANT ESCALA_TRIGGER 		  : INTEGER := (FPGA_CLK/100_000);   -- Constante para generar el ciclo de trabajo del Trigger.

COMPONENT DIVISOR_ULTRASONIDO
PORT(
	CLK       : IN  std_logic;
	INI       : IN  std_logic;
	DIVIDENDO : IN  std_logic_vector(31 downto 0);
	DIVISOR   : IN  std_logic_vector(31 downto 0);          
	RESULTADO : OUT std_logic_vector(31 downto 0);
	OK        : OUT std_logic
	);
END COMPONENT;

signal ok		  				 : std_logic;                                      -- flag que indica fin de división.
signal ini		  				 : std_logic;                                      -- Bit que inicia el proceso de división.
signal trigger_s 				 : std_logic := '0';                               -- Bit auxiliar para Trigger y también se utiliza como indicador para mandar la distancia.
signal calcular 				 : std_logic := '0';                               -- Bit que indica cuándo calcular la división.
signal dividendo 				 : std_logic_vector(31 downto 0);                  -- num dividendo.
signal divisor   				 : std_logic_vector(31 downto 0);                  -- num divisor.
signal resultado 				 : std_logic_vector(31 downto 0);                  -- Resultado de la división.
signal conta_trigger 		 : integer range 0 to escala_periodo_trigger := 0; -- Contador para la generación del Trigger.
signal conta_eco 				 : integer := 0;                                   -- Contador para el cálculo del tiempo de Eco.
signal escala_total 			 : integer := 0;                                   -- Auxiliar que adquiere el número de periodos que se obtubieron con Eco en '1' y así calcular la distancia.
signal tiempo_microsegundos : integer := 0;                                   -- Señal que guarda el tiempo en microsegundos.
signal edo_res : integer range 0 to 7 := 0;                                   -- Señal para la máquina de estados que calcula la distancia.
signal edo_eco : integer range 0 to 7 := 0;                                   -- Señal para la máquina de estados que calcula los periodos de CLK con Eco en '1'.


begin

m_divisor: DIVISOR_ULTRASONIDO PORT MAP(CLK=>CLK, INI=> ini, DIVIDENDO=>dividendo, DIVISOR=>divisor, RESULTADO=>resultado, OK =>ok);

--PROCESO QUE GENERA SEÑAL DE TRIGGER---
process(CLK)
begin
	if rising_edge(CLK) then
		conta_trigger <= conta_trigger+1;
		if conta_trigger = 0 then
			trigger_s <= '1';
		elsif conta_trigger = escala_trigger then
			trigger_s <= '0';
		elsif conta_trigger = escala_periodo_trigger then
			conta_trigger <= 0;
		end if;
	end if;
end process;

TRIGGER <= trigger_s;
----------------------------------------

--PROCESO QUE OBTIENE ESCALA DE ECO---
process(CLK)
begin
if rising_edge(CLK) then
	if edo_eco = 0 then -- Se espera a que Eco se ponga a '1'.
		if eco = '1' then
			edo_eco <= 1;
		end if;
		
	elsif edo_eco = 1 then
		if eco = '1' then -- Cuenta el número de periodos cuando Eco se encuentra en '1'.
			conta_eco <= conta_eco+1;
		else
			edo_eco <= 2;
		end if;
		
	elsif edo_eco = 2 then -- Se reinicia el contador cuando Eco se hace '0' y se almacena el último valor registrado en "conta_eco". Se pone a '1' "calcular".
		conta_eco <= 0;
		escala_total <= conta_eco;
		calcular <= '1';
		edo_eco <= 3;
			
	elsif edo_eco = 3 then -- Se desactuva el bit "calcular" y se regresa al estado 0.
		calcular <= '0';
		edo_eco <= 0;
		
	end if;
end if;
end process;
--------------------------------------

--Proceso que divide y obtiene el resultado final--
process(CLK)
begin
if rising_edge(CLK) then -- Espera a que transcurra el primer trigger para realizar el primer cálculo y tenerlo listo en el segundo trigger.
	if edo_res = 0 then
		if trigger_s = '1' then
			edo_res <= 1;
		end if;
		
	elsif edo_res = 1 then -- Espera a que se le indique cuándo realizar la división para obtener los microsegundos que duró "Eco".
		if calcular = '1' then
			dividendo <= conv_std_logic_vector(escala_total,32);
			divisor <= conv_std_logic_vector(VAL_1US,32);
			edo_Res <= 3;
		end if;
		
	elsif edo_res = 3 then -- Espera a que finalice el proceso de división.
		if ok = '1' then
			edo_res <= 4;
			ini <= '0';
		else
			ini <= '1';
		end if;
		
	elsif edo_res = 4 then -- Se realiza la división Tmicrosegundos/58 para obtener el valor de la distancia.
		dividendo <= resultado;
		divisor <= conv_std_logic_vector(58,32);
		edo_res <= 5;
		
	elsif edo_res = 5 then -- Espera a que finalice el proceso de división.
		if ok = '1' then
			edo_res <= 6;
			ini <= '0';
		else
			ini <= '1';
		end if;
	
	elsif edo_res = 6 then -- Espera a que Trigger se ponga a '1' y se mande la distancia por el puerto "DISTANCIA_CM". Se activa la bandera "DATO_LISTO".
		if trigger_s = '1' then
			DATO_LISTO <= '1';
			DISTANCIA_CM <= resultado(8 downto 0);
			edo_res <= 7;
		end if;
		
	
	elsif edo_res = 7 then -- Se desactiva la bandera "DATO_LISTO".
		DATO_LISTO <= '0';
		edo_res <= 1;
	
	end if;
end if;
end process;

end Behavioral;
