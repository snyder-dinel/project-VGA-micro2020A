----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 11:25:15
-- Design Name: 
-- Module Name: DRAW_VGA - Behavioral
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


entity DRAW_VGA is
                Port ( 
                COL: IN STD_LOGIC_VECTOR(9 DOWNTO 0); 
                ROW: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
                R: OUT STD_LOGIC;
                G: OUT STD_LOGIC;
                B: OUT STD_LOGIC
                );
end DRAW_VGA;

architecture Behavioral of DRAW_VGA is

begin
PROCESS(COL,ROW)
BEGIN
     IF(COL>=0 AND COL<=640)THEN
          R<='1';
          G<='0';
          B<='0';    
     END IF;
     
     IF(ROW>=0 AND ROW<=480)THEN
               R<='1';
               G<='0';
               B<='0';    
     END IF;
     
     IF(COL>=0 AND COL<=49)THEN
               R<='0';
               G<='0';
               B<='1';    
     END IF;
     
     IF(COL>=0 AND COL<=49)THEN
                    R<='1';
                    G<='1';
                    B<='0';    
     END IF;
     
     
     IF(ROW>=50 AND ROW<=59)THEN
                         R<='1';
                         G<='1';
                         B<='0';    
     END IF;
     
END PROCESS;

end Behavioral;
