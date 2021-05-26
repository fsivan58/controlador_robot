----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.05.2021 21:09:06
-- Design Name: 
-- Module Name: HardwarePuenteH - Behavioral
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

entity HardwarePuenteH is
    Port ( CLK_FPGA: in std_logic;
           obj_left : in STD_LOGIC; -- Objeto detectado en el lado izquierdo
           obj_right : in STD_LOGIC;  -- Objeto detectado en el lado derecho
           stop : in STD_LOGIC; -- Objeto detectado de frente o sensor color detecta rojo
           motor_left : out STD_LOGIC; -- Activo motor izquierdo
           motor_right : out STD_LOGIC -- Activo motor derecho
           );
end HardwarePuenteH;

architecture Behavioral of HardwarePuenteH is

component PWM_PROG is
 generic (
        DUTY : integer := 7 
        ); 
    Port ( 
        clk_i   : in  std_logic;            -- Input clock.
        activo  : in  std_logic;            -- Activar Duty.
        pwm : out STD_LOGIC
    );
end component;

signal enable_left : std_logic :='1';
signal enable_right : std_logic :='1';

begin
m_motor_left : PWM_PROG generic map (DUTY=> 2048) port map (clk_i=>CLK_FPGA , activo=>enable_left, pwm=>motor_left);
m_motor_right : PWM_PROG generic map (DUTY=> 2048) port map (clk_i=>CLK_FPGA , activo=>enable_right, pwm=>motor_right);

process (CLK_FPGA, stop) begin 

if(rising_edge(CLK_FPGA)) then
    if(stop='1') then
       enable_left <='0';
       enable_right <='0';
    else
      enable_left <=not obj_right; -- Activo a nivel alto si hay un objeto lo desactivo
      enable_right <=not obj_left; -- Activo a nivel alto si hay un objeto lo desactivo
    end if;
end if;



end process;

end Behavioral;
