----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2021 16:57:21
-- Design Name: 
-- Module Name: Descompositer - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Descompositer is
    Port (  CLK_FPGA : in STD_LOGIC;
    in_number : in integer range 0 to 999;
           s0 : in STD_LOGIC;
           s1 : in STD_LOGIC;
           out_vector : out std_logic_vector(3 downto 0)
           );
          
           
end Descompositer;

architecture Behavioral of Descompositer is

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



signal unidades : integer range 0 to 9 := 0;
signal decenas: integer range 0 to 9 := 0;
signal centenas : integer range 0 to 9 :=0;
signal out_vector_inter :  std_logic_vector(3 downto 0) := (others => '0');

signal init_div : std_logic :='0';
signal div_ok : std_logic :='0';

signal estado_div : integer range 0 to 6 :=0;


signal  DIVIDENDO :   STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operador dividendo.
signal	DIVISOR   :   STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operador divisor.
signal RESULTADO :  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Resultado de la división.

begin


m_divisor: DIVISOR_ULTRASONIDO PORT MAP(CLK=>CLK_FPGA, INI=> init_div, DIVIDENDO=>dividendo, DIVISOR=>divisor, RESULTADO=>resultado, OK =>div_ok);

process (unidades, decenas,centenas, s0, s1) begin 
    if(s0='0' and s1='0') then
        out_vector_inter <= std_logic_vector(to_unsigned(unidades, 4));
    elsif (s0='1' and s1='0') then 
        out_vector_inter <= std_logic_vector(to_unsigned(decenas, 4));
    elsif (s0='0' and s1='1') then 
        out_vector_inter <= std_logic_vector(to_unsigned(centenas, 4));
    end if;
end process;



process (in_number) begin
   centenas <= in_number / 100;
   decenas <= (in_number - (centenas*100) )/10;
   unidades <= (in_number - centenas*100 - decenas*10);  
end process;

out_vector <= out_vector_inter;

end Behavioral;







