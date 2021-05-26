----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.05.2021 11:55:08
-- Design Name: 
-- Module Name: ContadorFlancos - Behavioral
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

entity ContadorFlancos is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           flanco : in STD_LOGIC;
           timeH :  out integer;
           timeD : out integer;
           end_count : out STD_LOGIC
           );
end ContadorFlancos;

architecture Behavioral of ContadorFlancos is
 signal   count_hight   : integer   range 0 to 50_000_000 :=0;
 signal   count_low     : integer   range 0 to 50_000_000 :=0;
 SIGNAL ESTADO : integer:= 0;
begin

timeH <= count_hight;
timeD <= count_low;

process (clk, reset )
begin
if(reset ='1') then
        ESTADO <= 0;
        count_hight <= 0;
        count_low <= 0;
        end_count <='0';
elsif rising_edge(clk) then
    if ESTADO = 0 then
		if flanco = '0'   then  -- Se espera a que flanco se ponga a '0'. para esperar el priemr flanco alto
			ESTADO <= 1;
		end if;
	elsif ESTADO = 1 then 
		if flanco = '1'   then  -- Se espera a que flanco se ponga a '1'.
			ESTADO <= 2;
		end if;
		
    elsif ESTADO = 2 then
    	if flanco = '1' then -- Cuenta el número de periodos cuando flanco se encuentra en '1'.
			count_hight <= count_hight+1;
		else
			ESTADO <= 3; -- Empiezo a contar el numero de flancos a nivel bajo
		end if;
    elsif ESTADO = 3 then
         if flanco = '0' then -- Cuenta el número de periodos cuando flanco se encuentra en '1'.
			count_low <= count_low+1;
		else
			ESTADO <= 4; -- Termino de contar
		end if;
    elsif ESTADO = 4 then  -- Se almacena durante un ciclo el resultado
        end_count <='1';
        ESTADO <= 5;    
    elsif ESTADO = 5 then 
         ESTADO <= 0;
        count_hight <= 0;
        count_low <= 0;
        end_count <='0';
    end if;
end if;
end process;

end Behavioral;

