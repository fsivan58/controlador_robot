----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 13:31:09
-- Design Name: 
-- Module Name: MediaRegister - Behavioral
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

entity MediaRegister is
 Port ( enable : in std_logic;
        time_h : in integer;
        time_d : in integer;
        out_media : out integer);
end MediaRegister;

architecture Behavioral of MediaRegister is
signal result : integer :=0;
signal bloqueado : std_logic :='0';
begin

process (enable) 
begin
if rising_edge(enable) then
    if(bloqueado = '1') then
         bloqueado <= '0';
    else
    bloqueado <='1';
     --  result <= (time_h + time_d)/2;
    result <= time_h;
    -- result <= time_d;
    end if;

end if;

end process;
out_media <= result;


end Behavioral;
