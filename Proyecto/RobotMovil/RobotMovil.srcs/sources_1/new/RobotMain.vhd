----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2021 13:28:57
-- Design Name: 
-- Module Name: RobotMain - Behavioral
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

entity RobotMain is
 Port (clk_int : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
           
end RobotMain;

architecture Behavioral of RobotMain is

component clock1hz  
   Port( clk, reset     :in STD_LOGIC;
           clk_out      :out STD_LOGIC);
end component;
   
   SIGNAL w_clk_int, w_reset, w_clk_out : STD_LOGIC;
begin

mclk : clock1hz PORT MAP ( clk => clk_int, reset =>reset, clk_out => clk_out)  ;

end Behavioral;




