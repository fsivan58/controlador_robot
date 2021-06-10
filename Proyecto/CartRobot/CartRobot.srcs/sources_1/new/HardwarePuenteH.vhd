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
constant potencia : integer range 0 to 99 := 40; -- Potencia de los motores al 70% 100-70 logica negativa
signal enable_left : std_logic :='1';
signal enable_right : std_logic :='1';
signal clock_pwm: std_logic :='0';

signal pwm_left, pwm_right: std_logic :='0';

begin

m_clock_pwm : CLOCK generic map (FREQ_G => 20_000) port map (clk => CLK_FPGA, reset=>'0', clk_out => clock_pwm);

m_motor_left : PWM_PROG generic map (DUTY=> 35) port map (clk_i=>clock_pwm , activo=>enable_left, pwm=>pwm_left);
m_motor_right : PWM_PROG generic map (DUTY=> potencia) port map (clk_i=>clock_pwm , activo=>enable_right, pwm=>pwm_right);

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

-- bridge is negative logic
motor_left <=  pwm_left;
motor_right<=  pwm_right;


end process;

end Behavioral;
