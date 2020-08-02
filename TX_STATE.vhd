----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 12:57:17
-- Design Name: 
-- Module Name: TX_STATE - Behavioral
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


entity TX_STATE is
               Port ( 
                    SCANCODE: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
                    CLK_TX: IN STD_LOGIC; --. SEÑAL DE RELOJ
                    
                    S: IN STD_LOGIC;                   
                    ESC: IN STD_LOGIC;
                    P: IN STD_LOGIC;
                    R: IN STD_LOGIC;
                    UP: IN STD_LOGIC;
                    DOWN: IN STD_LOGIC;
                    LEFT: IN STD_LOGIC;
                    RIGHT: IN STD_LOGIC; 
                    --======FIN
                    FIN_DATA: IN STD_LOGIC;
                    --=====                     
                    SCAN_OUT: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
                    SELECTION: OUT STD_LOGIC;
                    STROBE: OUT STD_LOGIC

               );
               
end TX_STATE;

architecture Behavioral of TX_STATE is

begin

PROCESS(S,ESC,P,R,UP,DOWN,LEFT,RIGHT,FIN_DATA,SCANCODE,CLK_TX)

VARIABLE MAIN_OUT: STD_LOGIC_VECTOR(7 DOWNTO 0);-- SCAN_OUT --- SALIDA PRINCIPAL
VARIABLE SAVE:STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000";

VARIABLE strobe_data: STD_LOGIC:='0'; -- STROBE
VARIABLE PRENDER: STD_LOGIC:='0'; -- PARA PRENDER EL LED
VARIABLE select_mux: STD_LOGIC:='1'; -- en 1 para no envio de datos
VARIABLE dato_final: STD_LOGIC:='0'; -- para FIN_DATA

BEGIN
-- ESTADO 1
     IF(S = '1' OR ESC ='1' OR ESC ='1'OR P = '1' OR R = '1' OR UP = '1' OR DOWN = '1'OR LEFT = '1' OR RIGHT = '1')THEN 
          IF(CLK_TX='1' AND CLK_TX'EVENT)THEN 
              SCAN_OUT<=SCANCODE; -- ASIGNAAICON VALOR ALA SALIDA -********************
              SAVE:=SCANCODE; -- PARA ALMECANAR ESE DATO ayuda poara enviar el dato final
              
              IF(PRENDER='0')THEN 
                    strobe_data:='1';  -- UNA VEZ POR DATO ENVIADO
                    PRENDER:='1';-- SOLO UNA VEZ POR DATO -- SE DEB DE PRNDER POR CADA DATO NUEVO
              END IF;
              
              select_mux:='0'; -- para cambia r de estaodel MUX
              ---dato_final:='0'; es una entreda
              
          END IF;
          
--ESTADO 2     
     ELSIF(S = '0' AND  ESC ='0' AND ESC ='0'AND P = '0' AND R = '0' AND UP = '0' AND DOWN = '0'AND LEFT = '0' AND RIGHT = '0')THEN
          IF(CLK_TX='1' AND CLK_TX'EVENT)THEN 
               IF(SAVE="00011011" OR SAVE="01110110" OR SAVE="01001101" OR SAVE="00101101" OR SAVE="01110101" OR SAVE="01101011" OR SAVE="01110010" OR SAVE="01110100" )THEN  -- PARA ENVIAR EL F0 apenas termino de enviar los datos
                   SCAN_OUT<="11110000"; -- INDICIO QUE NO HAY TECLA PRESIONADA 
                   select_mux:='0';
                   
               ELSIF(FIN_DATA='1')THEN
                    SCAN_OUT<=SAVE; -- asignacion del dato presuionado
                    select_mux:='0';    
               
               ELSIF(SAVE="00000000")THEN
                    select_mux:='1'; -- PONEMOS EN 1 para solo enviar 1 , estado en alto
                    PRENDER:='0'; -- PONEMOS ALA ESPERA el FLAG - laa espera de otro dato nuevo               
               END IF;
               
          END IF; 
          
     END IF;
     
SELECTION<=select_mux;
STROBE<=strobe_data;


END PROCESS;

end Behavioral;
