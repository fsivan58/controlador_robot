----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2021 05:59:44 PM
-- Design Name: 
-- Module Name: clock - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock is
port (
    clk_in : in  std_logic;
    nRST   : in  std_logic;
    clk_out: out std_logic
);
end clock;

architecture Behavioral of clock is
    constant max_count: integer   := 49;
    signal   count    : integer   range 0 to max_count;
    signal   state    : std_logic := '1';
begin
    frequency_divider: process (clk_in, nRST) begin
        if nRST = '1' then
            state <= '0';
            count <= 0;
        elsif clk_in'event and clk_in = '1' then
                count <= count + 1;
            if count = max_count then
                state <= not state;
                count <= 0;
            end if;
        end if;
        clk_out <= state;
    end process;
end Behavioral;