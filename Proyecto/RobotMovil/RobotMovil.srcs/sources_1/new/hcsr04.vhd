

library IEEE, UNISIM, XESS;
use IEEE.MATH_REAL.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use UNISIM.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Hcsr04 is
  generic (
    FREQ_G       : real := 12.0;        -- Operating frequency in MHz.
    SENSE_FREQ_G : real := 20.0  -- Number of times distance is sensed per second.
    );
  port (
    clk_i   : in  std_logic;            -- Input clock.
    trig_o  : out std_logic;
    echo_i  : in  std_logic;
    dist_o  : out std_logic_vector;
    clear_o : out std_logic;
    done_o  : out std_logic
    );
end entity;

architecture arch of Hcsr04 is
  constant MAX_ECHO_TIME_C : real    := 38.0;  -- Maximum echo pulse width when no obstructions (ms).
  constant TRIG_WIDTH_C    : real    := 20.0;  -- Trigger width (us).
  constant SENSE_PERIOD_C  : natural := natural(ceil(FREQ_G * 1.0E6 / SENSE_FREQ_G));
  signal timer_r, dist_r   : natural range 0 to SENSE_PERIOD_C;
begin

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      timer_r <= timer_r + 1;
      trig_o  <= '0';
      dist_o  <= std_logic_vector(TO_UNSIGNED(dist_r, dist_o'length));
      clear_o <= '0';
      done_o  <= '0';
      if timer_r < integer(ceil(TRIG_WIDTH_C * FREQ_G)) then
        trig_o <= '1';
        dist_r <= 0;
      elsif echo_i = '1' then
        dist_r <= dist_r + 1;
      end if;
      if timer_r = SENSE_PERIOD_C then
        timer_r <= 0;
        done_o  <= '1';
        if dist_r >= integer(ceil(MAX_ECHO_TIME_C * FREQ_G * 1000.0)) then
          clear_o <= '1';
          dist_o  <= (dist_o'range => '1');
        else
          clear_o <= '0';
        end if;
      end if;
    end if;
  end process;
  
end architecture;
