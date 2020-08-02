----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.07.2020 13:05:15
-- Design Name: 
-- Module Name: TX - Behavioral
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


entity TX is
               Port (
                    clk_ps2: IN STD_LOGIC; -- señal de reloj del teclado - 20KHz
                    S: IN STD_LOGIC;                   
                    ESC: IN STD_LOGIC;
                    P: IN STD_LOGIC;
                    R: IN STD_LOGIC;
                    UP: IN STD_LOGIC;
                    DOWN: IN STD_LOGIC;
                    LEFT: IN STD_LOGIC;
                    RIGHT: IN STD_LOGIC; 
                    --==========SIMULACION DE MIS ENTRADAS
                    tx_data: OUT STD_LOGIC -- SALIDA DATOS == UART
                    --strobe: OUT STD_LOGIC  -- Pulso new interation                                      
                );
end TX;

architecture Behavioral of TX is

SIGNAL scancode: STD_LOGIC_VECTOR(7 DOWNTO 0); -- Valores de cadqa tecla pulsada SCANCOED

begin

---== CODIFICACION segun SCANCODE ==
scancode <= "00011011"   WHEN S = '1'    ELSE
            "01110110"    WHEN ESC ='1'   ELSE
            "01001101"       WHEN P = '1'    ELSE
            "00101101"        WHEN R = '1'    ELSE
            "01110101"        WHEN UP = '1'   ELSE
            "01101011"       WHEN DOWN = '1' ELSE
            "01110010"        WHEN LEFT = '1' ELSE
            "01110100"        WHEN RIGHT = '1' ELSE
            "00000000";

--== MANDAR DATOS SERIALMENTE

PROCESS(clk_ps2,S,ESC,P,R,UP,DOWN,LEFT,RIGHT,scancode)


VARIABLE  data: STD_LOGIC:='1'; -- dato de transmision , siewmpre en uno0 ----tx_data
VARIABLE startdata: INTEGER:=0;--- para el bit de inicio
VARIABLE verify: STD_LOGIC:='0'; -- Para la VERFICACIO  SI HAY TRANSMISION

VARIABLE i: INTEGER:=0; -- iteraciones
VARIABLE change: BIT:='0'; 

BEGIN
     -- 1. generacion de la transmision  

     IF(S = '0' AND  ESC ='0' AND ESC ='0'AND P = '0' AND R = '0' AND UP = '0' AND DOWN = '0'AND LEFT = '0' AND RIGHT = '0')THEN
             verify:='0';  -- No hay data
             data:='1'; -- siempre en 1
             
     IF(verify='1')THEN
          scancode<="11110000";-- x"F0"
     END IF;        
                         
     ELSIF(S = '1' OR ESC ='1' OR ESC ='1'OR P = '1' OR R = '1' OR UP = '1' OR DOWN = '1'OR LEFT = '1' OR RIGHT = '1' OR verify='1')THEN 
           --verify:='1';  -- HAY DATO DE ENTRADA
          
          IF(change='0')THEN 
              startdata:=0; -- Par la trama de datos
              change:='1';
          END IF;

                    IF(clk_ps2='1' AND clk_ps2'EVENT)THEN  -- DETECTTAR LOS FLANCOS DE SUBIDA PARA CAMBIO DE ESTADO
                    --******* INIT
                         IF(startdata=0)THEN -- bIt de INICIO "UART"
                              startdata:=1;-- solo una vez se hace esto
                              data:='0';
                         ELSIF(startdata=1)THEN
                    --****** DATA
                              IF(i <= 7)THEN   
                                  data:=scancode(i); -- Desde el menos significatryvo empezamos 
                                  i:=i+1;-- aumento por cada floanco de subida
                   --****** STOP               
                              ELSIF(i>7) THEN
                                  i:=0; -- reiniciamos la cuenta
                                  startdata:=0; -- para aterm,inar la comunicacion 
                                  data:='1';  
                                  change:='0'; -- oponemos en bajo la bandera 
                                     
                              END IF;
                   
                         END IF;
     END IF;
    
     END IF;
     
tx_data <= data;
     
END PROCESS;

end Behavioral;
