----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2021 08:39:36 PM
-- Design Name: 
-- Module Name: detection - Behavioral
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

entity detection is
    Port ( a : in STD_LOGIC_VECTOR (16 downto 0);
           b : in STD_LOGIC_VECTOR (16 downto 0);
           echo : in STD_LOGIC;
           s : in STD_LOGIC);
end detection;

architecture Behavioral of detection is

begin


end Behavioral;
