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
    Port ( CLK_FPGA : in STD_LOGIC;
           reset :in std_logic;
           channel : in STD_LOGIC;
           dato_listo : out STD_LOGIC;
           total_time :  out integer  range 0 to 2_000_000
           );
end PERIODO;

architecture Behavioral of PERIODO is

 type STATE_FR is (S_ESPERA,S_COUNTER_H,S_STOP, S_CLEAR);

signal M_STATE : STATE_FR  := S_ESPERA;

 

signal channelDiv :std_logic :='0';
signal clock_4Mhz : std_logic := '0';

signal counter: integer:=0;
signal total_count : integer:=0;


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


begin
m_clock_muestreo : CLOCK generic map (FREQ_G =>2_000_000) port map (clk=> CLK_FPGA, reset =>'0', clk_out => clock_4Mhz);

prescaler : process (channel, reset)
begin
    if (reset = '1') then
        channelDiv <= '0';
    elsif rising_edge(channel) then
        channelDiv <= not channelDiv;
    end if;
end process;

counter_periode : process (clock_4Mhz, reset)
begin
    if (reset = '1') then
        counter <= 0;
        M_STATE <= S_ESPERA;
    elsif rising_edge(clock_4Mhz) then
     case M_STATE is
        when S_ESPERA =>
            dato_listo <='0';
            counter <= 0;
           if channelDiv = '1'   then  -- Se espera a que flanco se ponga a '0'. para esperar el priemr flanco alto
                M_STATE <= S_COUNTER_H;
            end if;
         when S_COUNTER_H =>
           if channelDiv = '1'   then  -- Se espera a que flanco se ponga a '0'. para esperar el priemr flanco alto
                counter <= counter +1;
           else
               M_STATE <= S_STOP;
           end if;
          when S_STOP =>
            total_time <= counter;
            dato_listo <='1';
            M_STATE <= S_CLEAR; -- Termino de contar
         when S_CLEAR =>    
            M_STATE <= S_ESPERA;
         when others =>
             M_STATE <= S_ESPERA;             
     end case;

    end if;
end process;


end Behavioral;



















