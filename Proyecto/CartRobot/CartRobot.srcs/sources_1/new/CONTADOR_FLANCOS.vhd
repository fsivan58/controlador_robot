----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2021 01:24:14
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ContadorFlancos is
    Port ( clk : in STD_LOGIC;
           flanco : in STD_LOGIC;
           dato_listo : out STD_LOGIC;
           timeH :  out integer  range 0 to 1_000_000;
           timeD : out integer  range 0 to 1_000_000
           );
end ContadorFlancos;

architecture Behavioral of ContadorFlancos is
 signal   count_hight   : integer   range 0 to 1_000_000 :=0; -- Funcionamiento 12 Khz y frecuencia de muestreo de 4_000_000/2 = 2_000_000
 signal   count_low     : integer   range 0 to 1_000_000 :=0;
 signal ESTADO : integer:= 0;

begin


process (clk)
begin
if rising_edge(clk) then

    if ESTADO = 0 then
        if flanco = '0'   then  -- Se espera a que flanco se ponga a '0'. para esperar el priemr flanco alto
                ESTADO <= 1;
            end if;
    elsif ESTADO = 1 then 
      if flanco = '1'   then  -- Se espera a que flanco se ponga a '1'.
                ESTADO <= 2;
                count_hight <= count_hight+1;
      end if; 
    elsif ESTADO = 2 then -- Cuenta el número de periodos cuando flanco se encuentra en '1'.
      if flanco = '1' then 
                count_hight <= count_hight+1;
            else
                ESTADO <= 3; -- Empiezo a contar el numero de flancos a nivel bajo
                 count_low <= count_low+1;
            end if;
    elsif ESTADO = 3 then -- Cuenta el número de periodos cuando flanco se encuentra en '1'.
     if flanco = '0' then 
            count_low <= count_low+1;
      else
                ESTADO <= 4; -- Termino de contar
      end if;
    elsif ESTADO = 4 then -- Se almacena durante un ciclo el resultado
      dato_listo <='1';
      timeH <= count_hight;
      timeD <= count_low;
      ESTADO <= 5;
    elsif ESTADO = 5 then
            ESTADO <= 0;
            count_hight <= 0;
            count_low <= 0;
            dato_listo <='0';
    end if;

end if;

end process;


end Behavioral;



















