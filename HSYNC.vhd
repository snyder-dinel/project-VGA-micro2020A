----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.07.2020 21:15:13
-- Design Name: 
-- Module Name: HSYNC - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HSYNC is
                Port ( 
                    CLK_PIX: IN STD_LOGIC; -- nivel bajo
                    CLR1: IN STD_LOGIC; -- nivel bajo , asincrono
                    
                    COL: OUT STD_LOGIC_VECTOR(9 DOWNTO 0); --Contador de cada pixel - COLUMNAS
                    new_line: OUT STD_LOGIC; -- OJO : este sera como el reloj para VSYNC
                    HSYNC: OUT STD_LOGIC;-- solo indicara Los porches y la sincronizacion
                    visible: OUT STD_LOGIC -- Solo lo visible 0 - 639 -- ZONA VISIBLE
                );
end HSYNC;

--  Orden:
--  1) video activo, 2) porche delantero, 3) sincro H - V 4) porche trasero
--  Empezamos por el visible para que sea mas facil saber en que pixel visible
--  estamos, ya que si no, habria que realizar una resta

--  Por ejemplo para 640x480@60 Hz:

-----***************SINCRONIZACION HOEIZONTAL***************
---------- Pixeles (horizontal, columnas) ---------------------------------|
-- |                        |             |                 |              |
-- |      video activo      |   porche    |     sincro      |    porche    |
-- |                        | delantero   |   horizontal    |    trasero   |
-- |                        |             |                 |              |
-- |<--------- 640 -------->|<--- 16 ---->|<------ 96 ----->|<---- 48 ---->|
-- |                        |             |                 |              |
-- |                        |             |                 |              |
-- |<------------------------- c_pxl_total: 800 -------------------------->| 

architecture Behavioral of HSYNC is

begin

PROCESS(CLR1,CLK_PIX)
---oJO VALOR INICIAL
VARIABLE count: STD_LOGIC_VECTOR(9 DOWNTO 0):="0000000000"; --Valor de para COLUMNAS-  el BARRIDO en columnas
VARIABLE vision: STD_LOGIC:='1'; -- VISBIBLE
VARIABLE sincro: STD_LOGIC:='1'; -- HSYNC
VARIABLE linea: STD_LOGIC:='0';--new_line
VARIABLE aux: STD_LOGIC_VECTOR(9 DOWNTO 0):="0000000000";

BEGIN


     IF(CLR1='0')THEN 
          count:="0000000000"; -- RETORNO A CERO
          new_line<= '0'; -- DEFAULT
          HSYNC<='1'; -- NO ESTA EN LA ZONA de sincronizacio HORIZONTAL
          VISIBLE<='1'; -- ZONA INICIAL , ZONA VISIBLE 1   
          aux:="0000000001"; 
-- parte de BARRIDO DE COLUMNAS
     ELSIF(CLK_PIX='0' AND CLK_PIX'EVENT) THEN -- rELOJ con flanco de bajada

          IF(aux = 1 AND count= 0)THEN 
              count:="0000000000"; -- mantebnsmos el cero  
              aux:="0000000000"; 
          ELSE
              count:=count+1; 
          END IF; 
         
          
          IF(count = 800)THEN -- RESOLUCION DE 800x520
               count:="0000000000";
          END IF;
     END IF;
-- parte VISIBLE
     IF(count <=639 )THEN -- SOLO POARTE VISIBLE!!!!!!!!!
          vision:='1'; 
     ELSE 
          vision:='0';
     END IF;
     
-- parte PORCHE Y HSYNC
     IF(count>=656 AND count<=751 )THEN
          sincro:='0';
     ELSE
          sincro:='1';
     END IF;
-- NEW LINE
     IF(count<=399)THEN
          linea:='0';   
     ELSIF(count>=399 and count<=799)THEN
          linea:='1';     
     END IF;
-- ASIGNAMENTS
COL<=count; -- HACE LA MAGIA
new_line<=linea;
HSYNC<=sincro;
visible<=vision;

END PROCESS;

end Behavioral;
