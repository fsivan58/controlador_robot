----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.06.2021 19:29:32
-- Design Name: 
-- Module Name: UART_RX - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- TOTAL_BITS = CLK_FPGA / FR_UART
--Ejemplo 50MHz FPGA , 9600 baulios UART
-- 50_000_000 / 9600 = 5208.33
-- Se usa la mitad para alto y otro para bajo => 2604 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_RX is
  generic (
        TOTAL_BITS : integer := 5208        -- -- Operating frequency in Hz.
    );
    Port ( 
    CLK_FPGA : in std_logic;
    RX_INPUNT : in std_logic;
    READY : out std_logic;
    RX_DATA: out std_logic_vector(7 downto 0) 
    );
end UART_RX;

architecture Behavioral of UART_RX is

signal RX_DATA_I : std_logic :='0';

type STATE_RX is (S_ESPERA, S_START, S_COUNTER_DATA, S_STOP, S_CLEAR);

SIGNAL M_STATE : STATE_RX  := S_ESPERA;

signal NUM_DATA : integer range 0 to TOTAL_BITS -1 :=0;
signal BIT_INDEX : integer range 0 to 7 := 0;
signal RX_DATA_R : std_logic_vector (7 downto 0) := (others =>  '0');
signal M_READY : std_logic := 'X';
 

begin

-- Capturamos los datos
process (CLK_FPGA)
begin
    if rising_edge(CLK_FPGA) then
         RX_DATA_I <= RX_INPUNT;
    end if;
end process;


---  UART 
--   H
--  ---------
--           \   L
--            \_____ 

-- Maquina de estados
process (CLK_FPGA)
begin
 if rising_edge(CLK_FPGA) then
    case M_STATE is
        when S_ESPERA =>
            NUM_DATA <=0;
            BIT_INDEX <=0;
            M_READY <= 'X';
            
            if RX_DATA_I = '0' then -- Si llega el cero empiezo a contar
                M_STATE <= S_START;
            else 
                M_STATE <= S_ESPERA; -- Caso contrario vuelvo a esperar
            end if;
         when S_START =>
            if NUM_DATA = (TOTAL_BITS -1) / 2 then
              if RX_DATA_I ='0' then
                NUM_DATA <= 0; -- Reinicio el contado porque encontro la mitad
                M_STATE <= S_COUNTER_DATA;
                M_READY <= '0';
              else 
                 M_STATE <= S_ESPERA;
              end if;
            else 
                NUM_DATA <= NUM_DATA +1;
                M_STATE <= S_START;
            end if; 
            
         when  S_COUNTER_DATA =>
            if NUM_DATA  < TOTAL_BITS -1 then
                NUM_DATA <= NUM_DATA+1;
                M_STATE <= S_COUNTER_DATA;
            else
                NUM_DATA <= 0;
                RX_DATA_R(BIT_INDEX) <= RX_DATA_I; -- Start save position
                    if BIT_INDEX < 7 then
                         BIT_INDEX <= BIT_INDEX +1;
                         M_STATE <= S_COUNTER_DATA;
                    else 
                        BIT_INDEX <=0;
                        M_STATE <= S_STOP;
                    end if;
           end if;
        
        when  S_STOP =>   
          if NUM_DATA  < TOTAL_BITS -1 then
                NUM_DATA <= NUM_DATA+1;
                M_STATE <= S_STOP;
            else
             M_READY <= '1';
             NUM_DATA<= 0;
             M_STATE <= S_CLEAR;
            end if;
            
        when S_CLEAR =>    
            M_STATE <= S_ESPERA;
        
        when others =>
             M_STATE <= S_ESPERA;
    end case;
 
 end if;
end process;

RX_DATA <= RX_DATA_R;
READY <= M_READY;

end Behavioral;
