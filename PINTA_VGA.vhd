----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 22:16:21
-- Design Name: 
-- Module Name: PINTA_VGA - Behavioral
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

entity PINTA_VGA is
                    Port ( 
                    COL_PINTA: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
                    ROW_PINTA: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
                    COLOR: IN STD_LOGIC; -- CADA SECOND
                    RED: OUT STD_LOGIC;
                    GREEN: OUT STD_LOGIC;
                    BLUE: OUT STD_LOGIC    
                    );
end PINTA_VGA;

architecture Behavioral of PINTA_VGA is

begin
PROCESS(COL_PINTA,ROW_PINTA,COLOR)

VARIABLE INCREASE: INTEGER:=0; --- SE 

BEGIN
     -- INICIO 
     IF(COLOR='0')THEN
          IF(COL_PINTA>=0 AND COL_PINTA<=639)THEN -- FONDO FILA
               RED<='1';
               GREEN<='0';
               BLUE<='0';    
          END IF;
          
          IF(ROW_PINTA>=0 AND ROW_PINTA<=519)THEN -- FONDO COLUMNA
                         RED<='1';
                         GREEN<='0';
                         BLUE<='0';    
          END IF;
          -- SNAKE
          IF(ROW_PINTA>=400 AND ROW_PINTA<=409)THEN -- FONDO COLUMNA
                                   RED<='1';
                                   GREEN<='1';
                                   BLUE<='0';    
          END IF;
          
          IF(ROW_PINTA>=0 AND ROW_PINTA<=39)THEN -- FONDO COLUMNA
                                             RED<='1';
                                             GREEN<='1';
                                             BLUE<='0';    
          END IF;

     ELSIF(COLOR>='1')THEN
          INCREASE:=INCREASE+50;
          
          IF(ROW_PINTA>=400 AND ROW_PINTA<=409)THEN -- FONDO COLUMNA
                                    RED<='1';
                                    GREEN<='1';
                                    BLUE<='0';    
           END IF;
           
           IF(ROW_PINTA>=0 AND ROW_PINTA<=39+INCREASE)THEN -- FONDO COLUMNA
                                              RED<='1';
                                              GREEN<='1';
                                              BLUE<='0';    
           END IF;
     END IF;

END PROCESS;

end Behavioral;
