----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.05.2021 08:30:42
-- Design Name: 
-- Module Name: HardwareMotor - Behavioral
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

entity HardwareMotor is
    Port (
           CLK_FPGA: in std_logic;
           motor_left : out STD_LOGIC;
           motor_right : out STD_LOGIC;
           led_m_l : out std_logic;
           led_m_r : out std_logic;
           sw_in : in STD_LOGIC
              );
end HardwareMotor;

architecture Behavioral of HardwareMotor is


component HardwarePuenteH is
    Port ( CLK_FPGA: in std_logic;
           obj_left : in STD_LOGIC; -- Objeto detectado en el lado izquierdo
           obj_right : in STD_LOGIC;  -- Objeto detectado en el lado derecho
           stop : in STD_LOGIC; -- Objeto detectado de frente o sensor color detecta rojo
           motor_left : out STD_LOGIC; -- Activo motor izquierdo
           motor_right : out STD_LOGIC -- Activo motor derecho
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

component LOGIC_SWICH is
    Port (CLK_PGA : in STD_LOGIC;
           sw_in : in STD_LOGIC;
           sw_out : out STD_LOGIC);
end component;

signal enable_m_l,  enable_m_r: STD_LOGIC;

begin
m_punte_h : HardwarePuenteH port map (CLK_FPGA=> CLK_FPGA,
                                     obj_left=>'0', 
                                     obj_right=>'0', 
                                     stop=> '0',
                                     motor_left=>enable_m_l,
                                     motor_right=>enable_m_r );
                                     
 m_switch: LOGIC_SWICH port map (CLK_PGA=>CLK_FPGA, sw_in=>sw_in, sw_out=>led_m_l);                               
                                                                      
                       

 motor_right <= enable_m_r; 
 motor_left<=enable_m_l;
led_m_r <= enable_m_r;
end Behavioral;
