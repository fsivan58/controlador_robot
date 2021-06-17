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

    --constant SENSE_PERIOD_C  : natural := natural(ceil(FREQ_G * 1.0E6 / SENSE_FREQ_G));
    --signal counter  : natural range 0 to SENSE_PERIOD_C;
    constant SENSE_PERIOD_C  : integer := 99;
    signal counter  : integer range 0 to SENSE_PERIOD_C;
      
begin

    process(clk_i, activo)
    begin
        if activo='0' then
            counter <= 0;
        else 
            if rising_edge(clk_i) then
                if counter = SENSE_PERIOD_C then
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;
            end if;
         end if;
    end process;

    pwm <= '1' when (counter < DUTY ) else '0';
    
end Behavioral;
