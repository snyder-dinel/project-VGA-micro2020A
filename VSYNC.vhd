----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.07.2020 09:11:25
-- Design Name: 
-- Module Name: VSYNC - Behavioral
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL; -- INCLUIMOS PARA QUE SE PUEDA USAR OPERACIONES ARITMETICAS EN STD_LOGIC TIPO DE DATOS


entity VSYNC is
          Port ( 
                    CLK_LINE: IN STD_LOGIC; -- FLANCO bajo -- CLK = 32u seconds
                    CLR2: IN STD_LOGIC; -- nivel bajo , asincrono
                    
                    ROW: OUT STD_LOGIC_VECTOR(9 DOWNTO 0); --Contador de cada pixel - COLUMNAS
                    --new_line: OUT STD_LOGIC; -- OJO : este sera como el reloj para VSYNC
                    VSYNCR: OUT STD_LOGIC;-- solo indicara Los porches y la sincronizacion
                    visible_F: OUT STD_LOGIC -- Solo lo visible 0 - 639 -- ZONA VISIBLE
                );
end VSYNC;

architecture Behavioral of VSYNC is

begin

PROCESS(CLR2,CLK_LINE)
---oJO VALOR INICIAL
VARIABLE count: STD_LOGIC_VECTOR(9 DOWNTO 0):="0000000000"; --Valor de para FILAS-  el BARRIDO en columnas
VARIABLE vision: STD_LOGIC:='1'; -- VISBIBLE
VARIABLE sincro: STD_LOGIC:='1'; -- HSYNC
VARIABLE linea: STD_LOGIC:='0';--new_line
VARIABLE aux: STD_LOGIC_VECTOR(9 DOWNTO 0):="0000000000";

BEGIN


     IF(CLR2='0')THEN 
          count:="0000000000"; -- RETORNO A CERO
          --new_line<= '0'; -- DEFAULT
          VSYNCR<='1'; -- NO ESTA EN LA ZONA de sincronizacio HORIZONTAL
          VISIBLE_F<='1'; -- ZONA INICIAL , ZONA VISIBLE 1   
          aux:="0000000001"; 
          
-- parte de BARRIDO DE filas

     ELSIF(CLK_LINE='0' AND CLK_LINE'EVENT) THEN -- rELOJ con flanco de bajada

          IF(aux = 1 AND count= 0)THEN 
              count:="0000000000"; -- mantebnsmos el cero  
              aux:="0000000000"; 
          ELSE
              count:=count+1; 
          END IF; 
         
          
          IF(count = 520)THEN -- RESOLUCION DE 800x520
               count:="0000000000";
          END IF;
     END IF;
-- parte VISIBLE
     IF(count <=479 )THEN -- SOLO POARTE VISIBLE!!!!!!!!!
          vision:='1'; 
     ELSE 
          vision:='0';
     END IF;
     
-- parte PORCHE Y HSYNC
     IF(count>=480 AND count<=488 )THEN
          sincro:='0';
     ELSE
          sincro:='1';
     END IF;
-- NEW LINE
     --IF(count<=399)THEN
          --linea:='0';   
     --ELSIF(count>=399 and count<=799)THEN
         --- linea:='1';     
     --END IF;
-- ASIGNAMENTS

ROW<=count; -- HACE LA MAGIA
--new_line<=linea;
VSYNCR<=sincro;
visible_F<=vision;

END PROCESS;

end Behavioral;
