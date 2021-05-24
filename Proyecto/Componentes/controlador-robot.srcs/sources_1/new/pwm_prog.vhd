library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.MATH_REAL.all;

entity pwm_prog is
    generic (
        --FREQ_G       : real := 12.0; -- Operating frequency in MHz.
        --SENSE_FREQ_G : real := 20.0; -- Number of times distance is sensed per second.
        --DUTY : integer := 76 
        DUTY : integer := 7 
        ); -- default value is 76 = 30%
    Port ( 
        clk_i   : in  std_logic;            -- Input clock.
        activo  : in  std_logic;            -- Activar Duty.
        pwm : out STD_LOGIC
    );
end pwm_prog;

architecture Behavioral of pwm_prog is
    --constant SENSE_PERIOD_C  : natural := natural(ceil(FREQ_G * 1.0E6 / SENSE_FREQ_G));
    --signal counter  : natural range 0 to SENSE_PERIOD_C;
    constant SENSE_PERIOD_C  : integer := 15;
    signal counter  : integer range 0 to SENSE_PERIOD_C;
    --signal counter : std_logic_vector(7 downto 0) := "00000000";
    signal pwm_signal : std_logic;
    
begin

    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if counter >= SENSE_PERIOD_C then
                counter <= 0;
            else
                counter <= counter + 1;
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
