
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: DENILSON V.G
-- 
-- Create Date: 15.07.2020 18:58:43
-- Design Name: 
-- Module Name: PIX_FORM - Behavioral
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



--- DESCRIPCION: DIVISOR DE FRECUENCIAS PARA FORMAR PIXEL

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL; -- INCLUIMOS PARA QUE SE PUEDA USAR OPERACIONES ARITMETICAS EN STD_LOGIC TIPO DE DATOS


entity PIX_FORM is
                Port ( 
                    CLR: IN STD_LOGIC;
                    CLK: IN STD_LOGIC;
                    pix_form: OUT STD_LOGIC            
                );
end PIX_FORM;

architecture Behavioral of PIX_FORM is


begin
PROCESS(CLR,CLK)--- LISTA DE SENSIBILIDAD 

VARIABLE pix: STD_LOGIC:='0'; -- Valores uniciales
VARIABLE count: INTEGER:=0;

BEGIN --- T=10ns F=100MHz divisor de frecuencias
    IF( CLR = '0' )THEN -- ENYTRADA ASINCRONA
        pix:='0'; -- SALIDA bajo
        
    ELSIF(CLK='1' AND CLK'EVENT)THEN
        count:=count+1; -- cuenta los ESTADOS
        pix:='0'; -- estado bajo 
        
        IF(count=4)THEN -- count= 4 ESTDOS  3 estado cambia la salida(IMMEDIATO)
            pix:='0'; -- Cmbio de estado
            count:=0; 
        END IF;
        
        IF(count>=2)THEN
            pix:='1';
        END IF;
      
    END IF;
pix_form<=pix; -- ASIGNACION DE LA SALIDA
    
END PROCESS;
end Behavioral;

