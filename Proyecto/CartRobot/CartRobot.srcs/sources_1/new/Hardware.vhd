----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.05.2021 21:04:06
-- Design Name: 
-- Module Name: Hardware - Behavioral
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

entity Hardware is
    Port ( CLK_FPGA: in std_logic;
            sw_start : in STD_LOGIC;
            echo_left    : in  std_logic;
            echo_right   : in  std_logic;
            echo_front   : in  std_logic; 
         
            trig_left    : out std_logic;
            trig_right   : out std_logic;
            trig_front   : out std_logic;
       
             motor_left : out STD_LOGIC; -- Activo motor izquierdo
             motor_right : out STD_LOGIC; -- Activo motor derecho
             
              out_display : out std_logic_vector (6 downto 0);
              dig_1 : out std_logic;
              dig_2 : out std_logic;
              dig_3 : out std_logic;
              
              led_front : out std_logic;
              led_left : out std_logic;
              led_right : out std_logic; 
              
              led_m_l : out std_logic;
              led_m_r : out std_logic
           );
end Hardware;

architecture Behavioral of Hardware is

component HardwarePuenteH is
    Port ( CLK_FPGA: in std_logic;
           obj_left : in STD_LOGIC; -- Objeto detectado en el lado izquierdo
           obj_right : in STD_LOGIC;  -- Objeto detectado en el lado derecho
           stop : in STD_LOGIC; -- Objeto detectado de frente o sensor color detecta rojo
           motor_left : out STD_LOGIC; -- Activo motor izquierdo
           motor_right : out STD_LOGIC -- Activo motor derecho
           );
end component;

component HardwareUltraSonido is
  Port (  CLK_FPGA: in std_logic;

       echo_left    : in  std_logic;
       echo_right   : in  std_logic;
       echo_front   : in  std_logic;  
       
       trig_left    : out std_logic;
       trig_right   : out std_logic;
       trig_front   : out std_logic;
       
       obst_front   : out std_logic;
       obst_left    : out std_logic;
       obst_right   : out std_logic;
       shock        : out std_logic;
       distance : out integer range 0 to 999
   );
end component;

component LOGIC_SWICH is
    Port (CLK_PGA : in STD_LOGIC;
           sw_in : in STD_LOGIC;
           sw_out : out STD_LOGIC);
end component;

component DISPLAY is
Port (  clk : in STD_LOGIC;
        number : in integer;
        out_display : out std_logic_vector (6 downto 0);
        dig_1 : out std_logic;
        dig_2 : out std_logic;
        dig_3 : out std_logic
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
-- Ultra sonidos
signal obstacule_front, obj_left, obj_right, shock, stop_control: std_logic :='0';

signal clock_display : STD_LOGIC;
signal m_distance : integer range 0 to 999 :=0;

-- Puente H configuracion
signal pwm_left,  pwm_right,  stop: STD_LOGIC;

-- Logic Swicth
signal  start_stop : STD_LOGIC;

begin

 m_switch: LOGIC_SWICH port map (CLK_PGA=>CLK_FPGA, sw_in=>sw_start, sw_out=>start_stop);      

m_clock_display : CLOCK generic map (FREQ_G =>120) port map (clk=> CLK_FPGA, reset =>'0', clk_out => clock_display);

m_display : Display port map (clk => clock_display, number => m_distance, out_display => out_display, dig_1=>dig_1, dig_2=>dig_2, dig_3 => dig_3);

m_ultrasonidos : HardwareUltraSonido port map(CLK_FPGA => CLK_FPGA, 
                                                echo_left => echo_left, 
                                                echo_right=>echo_right, 
                                                echo_front => echo_front, 
                                                
                                                trig_left=>trig_left, 
                                                trig_right=>trig_right, 
                                                trig_front=>trig_front,
                                                
                                                obst_front=>obstacule_front,
                                                obst_left=>obj_left,
                                                obst_right=>obj_right,
                                                shock  => shock,
                                                distance => m_distance
                                                );

m_punte_h : HardwarePuenteH port map (CLK_FPGA=> CLK_FPGA,
                                     obj_left=>obj_left, 
                                     obj_right=>obj_right, 
                                     stop=> stop,
                                     motor_left=>pwm_left,
                                     motor_right=>pwm_right );
                                     
process (CLK_FPGA) 
begin
if rising_edge(CLK_FPGA) then
    if shock = '1' then
         stop_control<='1'; -- Si se ha chocado distancia menor a 4 cm paro el coche
    else 
      if (obstacule_front = '1' ) then
        if (obj_left  nand  obj_right) ='1' then
             stop_control<='0';
          else 
             stop_control<='1';
         end if;
        else
            stop_control<='0';
      end if;
    end if;
end if;

end process;

-- Configuracion leds activos a nivel bajo.
                                     
 led_left<= obj_left;  
 led_right<= obj_right;  
 led_front<=  start_stop; 
 
 led_m_l <= pwm_left;
 led_m_r <= pwm_right;
 
 motor_left  <= pwm_left;
 motor_right <= pwm_right;                             


--  Start_Stop Obstaculo ---- Stop
--      0        0             0
--      0        1             1
--      1        0             1
--      1        1             1
stop <=  start_stop or  stop_control;


end Behavioral;
