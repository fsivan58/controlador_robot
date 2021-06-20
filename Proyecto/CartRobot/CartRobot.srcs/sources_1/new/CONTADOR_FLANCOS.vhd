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
            reset :in std_logic;
           flanco : in STD_LOGIC;
           dato_listo : out STD_LOGIC;
           timeH :  out integer  range 0 to 2_000_000;
           timeD : out integer  range 0 to 2_000_000
           );
end ContadorFlancos;

architecture Behavioral of ContadorFlancos is
 signal   count_hight   : integer   range 0 to 2_000_000 :=0; -- Funcionamiento 12 Khz y frecuencia de muestreo de 4_000_000/2 = 2_000_000
 signal   count_low     : integer   range 0 to 2_000_000 :=0;
 signal ESTADO : integer  range 0 to 5 := 0;
 
 type STATE_FR is (S_ESPERA, S_START, S_COUNTER_H,S_COUNTER_L, S_STOP, S_CLEAR);

signal M_STATE : STATE_FR  := S_ESPERA;
signal M_READY :std_logic :='0';

begin

process (clk,reset)
begin
if reset = '1' then
  M_STATE <= S_STOP;
  M_READY <='0';
  count_hight <= 0;
  count_low <= 0;
elsif rising_edge(clk) then
    case M_STATE is
        when S_ESPERA =>
           M_READY <='0';
           count_hight <= 0;
           count_low <= 0;
            if flanco = '0'   then  -- Se espera a que flanco se ponga a '0'. para esperar el priemr flanco alto
                M_STATE <= S_START;
            end if;  
         when S_START =>
            if flanco = '1'   then  -- Se espera a que flanco se ponga a '1'.
                M_STATE <= S_COUNTER_H;
                count_hight <= count_hight+1;
            end if; 
         when S_COUNTER_H =>
           if flanco = '1' then 
                count_hight <= count_hight+1;
            else
                M_STATE <= S_COUNTER_L; -- Empiezo a contar el numero de flancos a nivel bajo
                 count_low <= count_low+1;
            end if;
         when S_COUNTER_L =>
              if flanco = '0' then 
                count_low <= count_low+1;
              else
                 M_STATE <= S_STOP; -- Termino de contar
              end if;
         when S_STOP =>
            timeH <= count_hight;
            timeD <= count_low;
            M_READY <='1';
            M_STATE <= S_CLEAR; -- Termino de contar
         when S_CLEAR =>    
            M_STATE <= S_ESPERA;
         when others =>
             M_STATE <= S_ESPERA;
    end case;

end if;

end process;

dato_listo <= M_READY;


end Behavioral;



















