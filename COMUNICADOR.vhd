----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 18:05:45
-- Design Name: 
-- Module Name: COMUNICADOR - Behavioral
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

entity COMUNICADOR is
                Port (
                clk_shift: IN STD_LOGIC; 
                datain: in STD_LOGIC_VECTOR(7 DOWNTO 0); -- datos de entrada
                ending: OUT STD_LOGIC;-- ojo este valor
                tx_data: OUT STD_LOGIC
               
                 );
end COMUNICADOR;

architecture Behavioral of COMUNICADOR is



begin
-- ENCARGADO ENVIAR DATOS SERIALMENBTE - ENVIAR LOS DATOS RECONOCIMEINTO F0 Y SALIDA_FINAL

PROCESS(clk_shift,datain)
VARIABLE DOUT: STD_LOGIC; -- tx_data
VARIABLE COUNT: INTEGER:=0; -- CUENTE LOS BITS ENVIADOS
VARIABLE i: INTEGER:=0; -- para los bit de datos
VARIABLE value_f:STD_LOGIC; -- para enviar a mi maestro que ya m,e esta llegando el F0 y su valor anteior
VARIABLE ayuda:STD_LOGIC:='0'; -- srirve para que se establesca la la continuida de F0 Y LUEGO MI DATo
 
BEGIN
     IF(clk_shift='1' AND clk_shift'EVENT)THEN-- RIDING EDGE
          
          COUNT:=COUNT+1; -- SUMA POR CADA ITERACION
          IF(COUNT=1)THEN -- 1ER BIT
              DOUT:='0';
                             
          ELSIF(COUNT>=2 AND COUNT<=9)THEN -- SEGUNDO BIT
               DOUT:=datain(i);
               i:=i+1; -- las iteraciones de para (8 bits)    
              
          ELSIF(COUNT<=10)THEN-- ULTIMO BIT DE TRANSMICION
               DOUT:='1'; -- BIT DE STOP
               COUNT:=0; -- PARA INICIAR OTRA VEZ LA MOVIDA          
               i:=0;
               IF(datain="11110000")THEN -- para atrapar ese valor de F0 y enviarselo a mi salida ENDING 
                  value_f:='1'; -- para enviar al maestro
                  ayuda:='1';
                  
               ELSIF(ayuda='1') THEN -- PARA CONTUNUAR DEL F0 A MI DATO QUE LLEGA
                     value_f:='0'; -- para enviar al maestro  
                     ayuda:='0';  -- CON ESTOVERIFICAMOS QUE SIGUE LA SECUANIA F0 Y DATA    
                  
               END IF;     
               
          END IF;
     

     END IF;
 ending<=value_f;
 tx_data<=DOUT;
     
END PROCESS;

end Behavioral;
