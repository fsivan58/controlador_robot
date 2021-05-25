----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: PWM_PROG - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.MATH_REAL.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWM_PROG is
 generic (
        DUTY : integer := 50 
        ); -- default value is 76 = 30%
    Port ( 
        clk_i   : in  std_logic;            -- Input clock.
        activo  : in  std_logic;            -- Activar Duty.
        pwm : out STD_LOGIC
    );
end PWM_PROG;

architecture Behavioral of PWM_PROG is


component CLOCK is
    generic (
        FREQ_G : integer := 10        -- -- Operating frequency in Hz.
    );
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
end component;

 --constant SENSE_PERIOD_C  : natural := natural(ceil(FREQ_G * 1.0E6 / SENSE_FREQ_G));
    --signal counter  : natural range 0 to SENSE_PERIOD_C;
    constant SENSE_PERIOD_C  : integer := 15;
    signal counter  : integer range 0 to SENSE_PERIOD_C;
    --signal counter : std_logic_vector(7 downto 0) := "00000000";
    signal pwm_signal : std_logic;
    signal enable_d :std_logic :='0';
    
begin

-- m_pulso : CLOCK generic map (FREQ_G =>DUTY) port map (clk=> clk_i, reset =>enable_d, clk_out => pwm_signal); 

    enable_d<= not activo;
    pwm <= enable_d;

end Behavioral;
