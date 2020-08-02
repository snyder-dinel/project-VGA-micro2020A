----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.07.2020 10:28:15
-- Design Name: 
-- Module Name: COUNT_PIX - Behavioral
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


entity COUNT_PIX is
                     Port ( 
                         CLK_COUNT: IN STD_LOGIC; -- flanco bajada SEÑAL DE RELOJ DE 40ns = T
                         CLR_C: IN STD_LOGIC; -- Active LOW
                         pix_count: OUT STD_LOGIC_VECTOR(19 DOWNTO 0)-- CONTADOR DE PIXELES
                     );
end COUNT_PIX;

architecture Behavioral of COUNT_PIX is

begin
PROCESS(CLK_COUNT,CLR_C)

VARIABLE count: STD_LOGIC_VECTOR(19 DOWNTO 0):="00000000000000000000"; -- CONTADOR DE PIXELES
VARIABLE aux_count: STD_LOGIC_VECTOR(19 DOWNTO 0); -- CONTADOR DE PIXELES


BEGIN
     IF(CLR_C = '0') THEN
          count:="00000000000000000000"; -- contador de pixel
          aux_count:="00000000000000000001";
          
     ELSIF(CLK_COUNT='0' AND CLK_COUNT'EVENT)THEN   
     
       IF(count=0 AND aux_count=1 )THEN 
          count:="00000000000000000000";
          aux_count:="00000000000000000000";
       ELSE
          count:= count+1;
       END IF;
       
     IF(count=307200)THEN 
          count:="00000000000000000000";
     END IF;
     
     END IF;
pix_count<=count;     

END PROCESS;


end Behavioral;
