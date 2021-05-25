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
       distance : out integer range 0 to 999
   );
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

signal obstacule_front,obj_left, obj_right: std_logic :='0';
signal clock_display : STD_LOGIC;
signal m_number : integer range 0 to 999 :=0;


signal enable_m_d,  enable_m_r: STD_LOGIC;
begin


m_clock_display : CLOCK generic map (FREQ_G =>120) port map (clk=> CLK_FPGA, reset =>'0', clk_out => clock_display);

m_display : Display port map (clk => clock_display, number => m_number, out_display => out_display, dig_1=>dig_1, dig_2=>dig_2, dig_3 => dig_3);

m_ultrasonidos : HardwareUltraSonido port map(CLK_FPGA => CLK_FPGA, 
                                                echo_left => echo_left, 
                                                echo_right=>echo_right, 
                                                echo_front => echo_front, 
                                                
                                                trig_left=>trig_left, 
                                                trig_right=>trig_right, 
                                                trig_front=>trig_front,
                                                
                                                obst_front=>obstacule_front,
                                                obst_left=>obj_left,
                                                obst_right=> obj_right,
                                                distance => m_number
                                                );

m_punte_h : HardwarePuenteH port map (CLK_FPGA=> CLK_FPGA,
                                     obj_left=>obj_left, 
                                     obj_right=>obj_right, 
                                     stop=> obstacule_front,
                                     motor_left=>enable_m_d,
                                     motor_right=>enable_m_r );
                                     
 led_left<= obj_left;  
 led_right<= obj_right;  
 led_front<= obstacule_front; 
   
 motor_left  <=not enable_m_d;
 motor_right <=not enable_m_r;                             

led_m_l <= not enable_m_d;
led_m_r <= not enable_m_r;


end Behavioral;
