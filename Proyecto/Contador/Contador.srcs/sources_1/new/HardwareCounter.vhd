----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2021 16:53:13
-- Design Name: 
-- Module Name: HardwareCounter - Behavioral
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

entity HardwareCounter is
 Port ( clk : in STD_LOGIC;
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic ;
        led : out std_logic);
end HardwareCounter;

architecture Behavioral of HardwareCounter is

component Display is
Port (  clk : in STD_LOGIC;
        number : in integer;
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic
        );
end component;

component clock is
    generic (
        FREQ_G : integer := 10        -- -- Operating frequency in Hz.
    );
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
end component;

component  Counter is
 Port ( clk : in STD_LOGIC;
        out_c : out integer);
end component;


signal clock_1hz : STD_LOGIC;
signal clock_dis : STD_LOGIC;
signal m_number : integer:=0;
begin

m_clock_1hz : clock generic map (FREQ_G =>1) port map (clk=> clk,reset =>'0', clk_out => clock_1hz);
m_clock_led : clock generic map (FREQ_G =>120) port map (clk=> clk,reset =>'0', clk_out => clock_dis);

m_seconds : Counter port map (clk => clock_1hz, out_c => m_number);
m_display : Display port map (clk => clock_dis, number => m_number, out_display => out_display, dig_1=>dig_1, dig_2=>dig_2, dig_3 => dig_3);


led <=clock_1hz;
end Behavioral;









