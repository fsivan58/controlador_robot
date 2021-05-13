----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2021 08:01:21 PM
-- Design Name: 
-- Module Name: subtractor - Behavioral
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
use ieee.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity subtractor is
    generic (k : integer := 16);
    port (
        a : in  std_logic_vector (k-1 downto 0);
        b : in  std_logic_vector(k-1 downto 0);
        s : out std_logic_vector (k-1 downto 0)
    );
end subtractor;

architecture Behavioral of subtractor is

begin

    s <= a - b;

end Behavioral;
