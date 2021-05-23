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

contador_flanco: process ( flanco, clk, reset)
begin
    if(reset ='1') then
        ESTADO <= 0;
        count_hight <= 0;
        count_low <= 0;
        end_count <='0';
    elsif clk'event then
        if ESTADO < 2 then
              if flanco = '1' then
                if( ESTADO = 1) then
                    ESTADO <= 2;
                    end_count <='1';
                else
                    count_hight <= count_hight+1;
                    end_count <='0';
                end if;
              else 
                ESTADO <= 1;
                count_low <= count_low+1;
              end if;
        end if;
    end if;

end process;



end Behavioral;



















