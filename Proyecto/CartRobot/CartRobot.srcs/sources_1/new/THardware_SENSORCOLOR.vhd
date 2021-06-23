----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.06.2021 01:17:26
-- Design Name: 
-- Module Name: Hardware_SENSORCOLOR - Behavioral
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

entity THardware_SENSORCOLOR is
 Port ( CLK_FPGA : in STD_LOGIC;
         fr_color : in STD_LOGIC;
         sw_start : in std_logic;
         s0 : out STD_LOGIC;
         s1 : out STD_LOGIC;
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC;
         led_c : out STD_LOGIC;
         
         out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic;
        led_m_l : out std_logic;
        led_m_r : out std_logic;
        out_p16 : out std_logic
       );
end THardware_SENSORCOLOR;

architecture Behavioral of THardware_SENSORCOLOR is

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

component SENSORCOLOR is
  Port ( CLK_FPGA : in STD_LOGIC;
         serial_color : in STD_LOGIC;
         s0 : out STD_LOGIC;
         s1 : out STD_LOGIC;
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC;
         led_c: out std_logic;
         reset : in std_logic;
         dato_listo : out STD_LOGIC; -- Flag para cuando se termina de contar los flancos
         out_color : out integer range 0 to 2_000_000 -- 1024
       );
end component;

component Display is
Port (  clk : in STD_LOGIC;
        number : in integer range 0 to 999;
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic
        );
end component;


signal out_color_reg: integer range 0 to 2_000_000;
signal out_color_disp: integer;
signal de_l : std_logic := '0';

signal clock_display : std_logic; 
signal color_listo : std_logic;

signal m_reset : std_logic;

begin

m_colorh :SENSORCOLOR port map (CLK_FPGA=> CLK_FPGA, serial_color => fr_color, s0=>s0, s1=> s1, s2=>s2, s3=>s3, led_c => led_c,reset=>m_reset, dato_listo => color_listo, out_color=>out_color_reg);

m_clok: clock generic map (FREQ_G=> 120) port map(clk=> CLK_FPGA, reset => '0', clk_out=> clock_display);

m_display :Display port map (clk=>clock_display, number=>out_color_disp, out_display=> out_display, dig_1=>dig_1, dig_2=>dig_2, dig_3=>dig_3);

led_m_l <= not color_listo;

out_p16 <= color_listo;

read_color : process (CLK_FPGA)
begin
    if rising_edge(CLK_FPGA)then
       if(color_listo = '1') then    
            out_color_disp <= out_color_reg;
        end if;
        
        if out_color_reg > 999 then
            led_m_r <='0';
        else
            led_m_r <='1';
        end if;
     
    end if;
end process;

m_reset <= not sw_start;
end Behavioral;



