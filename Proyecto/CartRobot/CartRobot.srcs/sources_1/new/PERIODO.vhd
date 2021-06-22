----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2021 01:24:14
-- Design Name: 
-- Module Name: ContadorFlancos - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PERIODO is
    Port ( CLFK_FPGA : in STD_LOGIC;
           reset :in std_logic;
           channel : in STD_LOGIC;
           dato_listo : out STD_LOGIC;
           total_time :  out integer  range 0 to 2_000_000
           );
end PERIODO;

architecture Behavioral of ContadorFlancos is


signal channelDiv :std_logic :='0';
signal reset_prescaler : std_logic := '0';

signal clock_4Mhz : std_logic := '0';
signal counter_240ns : integer range 0 to 12 :=0;
signal counter: integer:=0;
signal total_count : integer:=0;
signal start_count : std_logic :='0';



begin

frecuencia_muestreo: process (CLFK_FPGA, reset)
begin 
    if (reset = '1') then
        counter_240ns <= 0;
    elsif rising_edge(channel) then
        if(counter_240ns = 12) then
            counter_240ns <= 0;
            clock_4Mhz <= not clock_4Mhz;
        else
            counter_240ns <= counter_240ns + 1;
        end if;
    end if;

end process;


prescaler : process (channel, reset)
begin
    if (reset = '1') then
        channelDiv <= '0';
    elsif rising_edge(channel) then
        channelDiv <= not channelDiv;
    end if;
end process;

process_count : process (channelDiv, reset)
begin

    if (reset = '1') then
        total_count <= 0;
        M_READY <= '1';
        start_count <= '0';
    elsif channelDiv = '1' then
        M_READY <= '0';
        start_count <= '1';
    elsif channelDiv = '0' tnen
        total_count <= counter;
        M_READY <= '1';
        start_count <='0';
    end if;
end process;



counter_duty : process (clock_4Mhz, reset, start_count)
begin
    if (reset = '1') then
        counter <= '0';
    elsif rising_edge(clock_4Mhz) then
        if start_count = '1' then
            counter <= counter +1;
        else 
            counter <= '0' ;
        end if;
    end if;
end process;



dato_listo <= M_READY;
total_time <= total_count;

end Behavioral;



















