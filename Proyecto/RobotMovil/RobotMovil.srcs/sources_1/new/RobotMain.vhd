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
 Port (clk_int  : in STD_LOGIC;
       reset    : in STD_LOGIC;
            clk_out         : out STD_LOGIC;
            display_out     : out std_logic_vector (6 downto 0);
            pos_out         : out STD_LOGIC);
           
end RobotMain;

architecture Behavioral of RobotMain is

component clock  
   Port( clk, reset     :in STD_LOGIC;
           clk_out      :out STD_LOGIC);
end component;

component sem7
    Port ( n_input  : in bit_vector (3 downto 0);
           pos      : in STD_LOGIC;
           display  : out std_logic_vector (6 downto 0);
           pos_out : out STD_LOGIC);
end component;

   
   SIGNAL w_clk_int, w_reset, w_clk_out : STD_LOGIC;
begin

mclk : clock PORT MAP ( clk => clk_int, reset =>reset, clk_out => clk_out);

led7 : sem7 PORT MAP (n_input => "0001", pos=>'1', display => display_out, pos_out=>pos_out) ;

end Behavioral;




