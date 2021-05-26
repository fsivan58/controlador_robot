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
            --FREQ_G       : real := 12.0; -- Operating frequency in MHz.
            --SENSE_FREQ_G : real := 20.0; -- Number of times distance is sensed per second.
            --DUTY : integer := 76 
            DUTY : integer := 12 
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
    constant SENSE_PERIOD_C  : integer := 2048;
    signal counter  : integer range 0 to SENSE_PERIOD_C;
    --signal counter : std_logic_vector(7 downto 0) := "00000000";
    signal pwm_signal : std_logic;
    
begin

    process(clk_i, activo)
    begin
        if activo='0' then
            counter <= 0;
        else 
            if rising_edge(clk_i) then
                if counter >= SENSE_PERIOD_C then
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;
            end if;
         end if;
    end process;
    
    --if activo = '1' then
    --    pwm <= '1' when counter > DUTY else '0';
    --else 
    --    pwm <= '0';
    --end if;
    
    pwm <= '1' when activo='1' AND (DUTY > counter) else '0';

end Behavioral;
