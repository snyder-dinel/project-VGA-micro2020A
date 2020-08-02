----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.07.2020 10:46:22
-- Design Name: 
-- Module Name: SYNCHRONIZER - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:sadasd
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--********* REUNE TODOS LOS COMPENNTES DEL SIMNCRONIZADOR

entity SYNCHRONIZER is
                    Port ( 
                          CLK_S: IN STD_LOGIC;
                          RESET: IN STD_LOGIC;
                          --- OUTS    
                          COL: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
                          ROW: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
                          VISIBLE_S: OUT STD_LOGIC;
                          HSYNC_S: OUT STD_LOGIC;
                          VSYNC_S: OUT STD_LOGIC;
                          pix_count_S: OUT STD_LOGIC_VECTOR(19 DOWNTO 0)-- CONTADOR DE PIXELES
                    );
end SYNCHRONIZER;

architecture Behavioral of SYNCHRONIZER is
--- FORMADOR DEL PIXEL
COMPONENT PIX_FORM
          Port ( 
                    CLR: IN STD_LOGIC;
                    CLK: IN STD_LOGIC;
                    pix_form: OUT STD_LOGIC            
                );

END COMPONENT;
---BARRIDO COLUMNAS

COMPONENT HSYNC
           Port ( 
                    CLK_PIX: IN STD_LOGIC; -- nivel bajo
                    CLR1: IN STD_LOGIC; -- nivel bajo , asincrono
                    
                    COL: OUT STD_LOGIC_VECTOR(9 DOWNTO 0); --Contador de cada pixel - COLUMNAS
                    new_line: OUT STD_LOGIC; -- OJO : este sera como el reloj para VSYNC
                    HSYNC: OUT STD_LOGIC;-- solo indicara Los porches y la sincronizacion
                    visible: OUT STD_LOGIC -- Solo lo visible 0 - 639 -- ZONA VISIBLE
                );
END COMPONENT;

--- BARRIDO FILAS
COMPONENT VSYNC
     Port ( 
                    CLK_LINE: IN STD_LOGIC; -- FLANCO bajo -- CLK = 32u seconds
                    CLR2: IN STD_LOGIC; -- nivel bajo , asincrono
                    
                    ROW: OUT STD_LOGIC_VECTOR(9 DOWNTO 0); --Contador de cada pixel - COLUMNAS
                    --new_line: OUT STD_LOGIC; -- OJO : este sera como el reloj para VSYNC
                    VSYNCR: OUT STD_LOGIC;-- solo indicara Los porches y la sincronizacion
                    visible_F: OUT STD_LOGIC -- Solo lo visible 0 - 639 -- ZONA VISIBLE
                );
END COMPONENT;
-- CONTADOR DE PIXELES
COMPONENT COUNT_PIX
     Port ( 
                         CLK_COUNT: IN STD_LOGIC; -- flanco bajada SEÑAL DE RELOJ DE 40ns = T
                         CLR_C: IN STD_LOGIC; -- Active LOW
                         pix_count: OUT STD_LOGIC_VECTOR(19 DOWNTO 0)-- CONTADOR DE PIXELES
                     );
END COMPONENT;
-- SEÑALES DE UNION
SIGNAL S1,S3,S4,S2:STD_LOGIC; -- UNION

begin

UUT1: PIX_FORM PORT MAP(CLR=>RESET,CLK=>CLK_S,pix_form=>S1);
UUT2: HSYNC PORT MAP(CLK_PIX=>S1,CLR1=>RESET,COL=>COL,new_line=>S3,HSYNC=>HSYNC_S,visible=>S2); ---BARRIDO COLUMNAS
UUT3: VSYNC PORT MAP(CLK_LINE=>S3,CLR2=>RESET,ROW=>ROW,VSYNCR=>VSYNC_S,visible_F=>S4); --- BARRIDO FILAS
UUT4: COUNT_PIX PORT MAP(CLK_COUNT=>S1,CLR_C=>RESET,pix_count=>pix_count_S);

VISIBLE_S<=S2 AND S4;



                    
end Behavioral;
