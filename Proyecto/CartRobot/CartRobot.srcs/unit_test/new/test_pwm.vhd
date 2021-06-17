
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_pwm is
--  Port ( );
end test_pwm;

architecture Behavioral of test_pwm is

component pwm_prog
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
end component;

    signal clk, activo, salida : STD_LOGIC;
    
begin

pwm_progsimul : pwm_prog generic map (DUTY => 12)
        port map (
          clk_i  => clk,
          activo => activo,
          pwm    => salida
        );

process begin
    clk <= '1';
    wait for 10ns;
    clk <= '0';
    wait for 10ns;
end process;

process begin
    activo <= '1';
    wait for 10 us;
    activo <= '0';
    wait for 500 ns;
    activo <= '1';
    wait for 500 ns;
    activo <= '0';
    wait for 4 us;
end process;


end Behavioral;



