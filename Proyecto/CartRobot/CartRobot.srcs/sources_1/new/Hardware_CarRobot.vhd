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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Hardware_CarRobot is
    Port ( CLK_FPGA: in std_logic;
            sw_start : in STD_LOGIC;
            
            RX_INPUNT : in std_logic;
            -- Ultra sonidos
            echo_left    : in  std_logic;
            echo_right   : in  std_logic;
            echo_front   : in  std_logic; 
            
            trig_left    : out std_logic;
            trig_right   : out std_logic;
            trig_front   : out std_logic;
            
            -- Indicadores de obstaculos
            led_front : out std_logic;
            led_left : out std_logic;
            led_right : out std_logic; 
       
            -- PWM Motores
             motor_left : out STD_LOGIC; 
             motor_right : out STD_LOGIC; 
             
             -- Sensor de color
             fr_color : in STD_LOGIC;
             s0 : out STD_LOGIC;
             s1 : out STD_LOGIC;
             s2 : out STD_LOGIC;
             s3 : out STD_LOGIC;
             led_c : out STD_LOGIC;
             
            -- Display 7 segmentos
             out_display : out std_logic_vector (6 downto 0);
             dig_1 : out std_logic;
             dig_2 : out std_logic;
             dig_3 : out std_logic;
             
             -- Leds indicadores
              led_m_l : out std_logic;
              led_m_r : out std_logic
           );
end Hardware_CarRobot;

architecture Behavioral of Hardware_CarRobot is

------------------------------
-- Definicion de componentes
------------------------------
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
       crash        : out std_logic;
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


component UART_RX is
  generic (
        TOTAL_BITS : integer := 5208        -- -- calcular x bauoliod
    );
    Port ( 
    CLK_FPGA : in std_logic;
    RX_INPUNT : in std_logic;
    READY : out std_logic;
    RX_DATA: out std_logic_vector(7 downto 0) 
    );
end component;

component SENSORCOLOR is
  Port ( CLK_FPGA : in STD_LOGIC;
         serial_color : in STD_LOGIC;
         s0 : out STD_LOGIC;
         s1 : out STD_LOGIC;
         s2 : out STD_LOGIC;
         s3 : out STD_LOGIC;
         dato_listo : out STD_LOGIC; 
         out_color : out integer range 0 to 1_000_000 -- 1024
       );
end component;

------------------------------
-- Definicion de señales
------------------------------

-- Ultra sonidos
signal obj_front, obj_left, obj_right, m_crash, stop_control: std_logic :='0';

signal clock_display : STD_LOGIC;
signal m_distance : integer range 0 to 999 :=0;

-- Puente H configuracion
signal pwm_left,  pwm_right,  stop: STD_LOGIC;

-- Logic Swicth
signal  start_stop : STD_LOGIC :='1';

--UART
signal m_ready : std_logic; 
SIGNAL  RX_DATA_I:  std_logic_vector(7 downto 0); 
signal data_uart : integer range 0 to 50 :=0; -- Solo el 48 => 0 y 49 = 1

-- Sensor color
signal dato_listo_color :  STD_LOGIC; 
signal  m_color_detected :  integer range 0 to 1_000_000; -- 1024
signal color_detected : STD_LOGIC := '0';

constant COLOR_SCAN_MIN : integer range 0 to 1000 := 150;
constant COLOR_SCAN_MAX : integer range 0 to 1000 := 160;


begin

-- m_switch: LOGIC_SWICH port map (CLK_PGA=>CLK_FPGA, sw_in=>sw_start, sw_out=>start_stop);      

m_clock_display : CLOCK generic map (FREQ_G =>120) port map (clk=> CLK_FPGA, reset =>'0', clk_out => clock_display);

m_display : Display port map (clk => clock_display, number => m_color_detected, out_display => out_display, dig_1=>dig_1, dig_2=>dig_2, dig_3 => dig_3);

m_ultrasonidos : HardwareUltraSonido port map(CLK_FPGA => CLK_FPGA, 
                                                echo_left => echo_left, 
                                                echo_right=>echo_right, 
                                                echo_front => echo_front, 
                                                
                                                trig_left=>trig_left, 
                                                trig_right=>trig_right, 
                                                trig_front=>trig_front,
                                                
                                                obst_front=>obj_front, -- Distancia menos de 10 cm
                                                obst_left=>obj_left,
                                                obst_right=>obj_right,
                                                crash  => m_crash, -- Disntancia menos de 4 cm
                                                distance => m_distance
                                                );

m_punte_h : HardwarePuenteH port map (CLK_FPGA=> CLK_FPGA,
                                     obj_left=>obj_left, 
                                     obj_right=>obj_right, 
                                     stop=> stop,
                                     motor_left=>pwm_left,
                                     motor_right=>pwm_right );
                                     
                                     
m_uart :UART_RX generic map (TOTAL_BITS => 5208) port map (CLK_FPGA =>CLK_FPGA ,RX_INPUNT=> RX_INPUNT, READY => m_ready, RX_DATA=> RX_DATA_I );                                     
                                     
m_sensor_color :SENSORCOLOR port map(CLK_FPGA => CLK_FPGA,serial_color=> fr_color, s0=>s0, s1=>s1, s2=>s2, s3=>s3, dato_listo => dato_listo_color, out_color=>m_color_detected );                                    
                                     
read_uart : process (CLK_FPGA, m_ready)
begin
 if rising_edge(CLK_FPGA) then
    if m_ready = '1' then
        data_uart <=  to_integer(unsigned(RX_DATA_I));
        if data_uart = 49 then
            start_stop <= '0'; -- Start
        else
            start_stop <= '1'; -- Stop
        end if;
     end if;
 end if;
end process;

read_color : process (CLK_FPGA, dato_listo_color)
begin
 if rising_edge(CLK_FPGA) then
    if dato_listo_color = '1' then
        if m_color_detected > COLOR_SCAN_MIN and m_color_detected < COLOR_SCAN_MAX then
            color_detected<='1';
        else 
            color_detected<='0';
        end if;
         
     end if;
 end if;
end process;

-- Configuracion leds activos a nivel bajo.
                                     
 led_left  <= not obj_left;  
 led_right <= not obj_right;  
 led_front <= not obj_front; 
 
 led_m_l <= not color_detected;
 led_m_r <= start_stop;
 
 motor_left  <= pwm_left;
 motor_right <= pwm_right; 
  
 --led_c <=  not stop; -- Si esta a stop = 0 ce enciende el led de color
 led_c <=  '1'; -- Si esta a stop = 0 ce enciende el led de color
                       
--  Start_Stop Obstaculo  COLOR  |Stop|
--	     0	      0	      0	       0
--		 0	      0	      1	       1
--	     0	      1	      0	       1
--	     0	      1	      1	       1
--	     1	      0	      0	       1
--	     1	      0	      1        1
--	     1	      1	      0	       1
--	     1	      1	      1	       1
stop <=  start_stop or  m_crash or color_detected;


end Behavioral;
