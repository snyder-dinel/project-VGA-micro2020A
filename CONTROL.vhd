----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 22:39:34
-- Design Name: 
-- Module Name: CONTROL - Behavioral
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

entity CONTROL is
                     Port ( 
                     CLK_C: IN STD_LOGIC;
                     RESET: IN STD_LOGIC;
                     DIV_1: OUT STD_LOGIC            
                     );
end CONTROL;

architecture Behavioral of CONTROL is

begin
PROCESS(CLK_C,RESET)

VARIABLE count: INTEGER:=0; -- PARA LA CUENTA DEL DIVISOR
VARIABLE pix: STD_LOGIC:='0';

BEGIN
      IF( RESET = '0' )THEN -- ENYTRADA ASINCRONA
         DIV_1<='0'; -- SALIDA bajo
         
     ELSIF(CLK_C='1' AND CLK_C'EVENT)THEN
         count:=count+1; -- cuenta los ESTADOS
         pix:='0'; -- estado bajo 
         
         IF(count=100000000)THEN -- count= 4 ESTDOS  3 estado cambia la salida(IMMEDIATO)
             pix:='0'; -- Cmbio de estado
             count:=0; 
         END IF;
         
         IF(count>=50000000)THEN
             pix:='1';
         END IF;
       
     END IF;
     
DIV_1<=pix;-- SEÑLA DIVIDIDA
     
END PROCESS;

end Behavioral;
