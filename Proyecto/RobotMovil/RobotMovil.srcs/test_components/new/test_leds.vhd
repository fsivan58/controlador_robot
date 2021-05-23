library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity test_sem7 is
--  Port ( );
end test_sem7;

architecture testbench of test_sem7 is
  component sem7
   Port ( n_input  : in bit_vector (3 downto 0);
           pos      : in STD_LOGIC;
           display  : out std_logic_vector (6 downto 0);
           pos_out : out STD_LOGIC);
    end component;
    
    SIGNAL number:  bit_vector (3 downto 0);
    SIGNAL  m_display  :  std_logic_vector (6 downto 0);
begin

 led7 : sem7 port map (
        n_input  => number,
        pos    => '1',
        display => m_display
    );
    
     process begin
        number <= "0001";
        wait for 5ns;
        number <= "0010";
        wait for 5ns;
        number <= "0011";
        wait for 5ns;
        number <= "0101";
        wait for 5ns;
    end process;
    
end testbench;
