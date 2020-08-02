----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 23:07:13
-- Design Name: 
-- Module Name: SNAKE - Behavioral
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

entity SNAKE is
                Port ( 
                SCANCODE_IN: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
                CLK_VGA: IN STD_LOGIC;
                CLK_KEY: IN STD_LOGIC;
                
                 S: IN STD_LOGIC;                   
                 ESC: IN STD_LOGIC;
                 P: IN STD_LOGIC;
                 R: IN STD_LOGIC;
                 UP: IN STD_LOGIC;
                 DOWN: IN STD_LOGIC;
                 LEFT: IN STD_LOGIC;
                 RIGHT: IN STD_LOGIC; 
                 ---=====
                  R_OUT: OUT STD_LOGIC;
                  G_OUT: OUT STD_LOGIC;
                  B_OUT: OUT STD_LOGIC;
                
                  COL: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
                  ROW: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
                  
                  VSYNC_OUT: OUT STD_LOGIC;
                  HSYNC_OUT: OUT STD_LOGIC;
                  ----========= 
                  STROBE_OUT: OUT STD_LOGIC;
                  seg0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0); --***
                  seg1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0) --***
                 );
end SNAKE;

architecture Behavioral of SNAKE is
COMPONENT PINTA_VGA
    Port ( 
                    COL_PINTA: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
                    ROW_PINTA: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
                    COLOR: IN STD_LOGIC; -- CADA SECOND
                    RED: OUT STD_LOGIC;
                    GREEN: OUT STD_LOGIC;
                    BLUE: OUT STD_LOGIC    
                    ); 

END COMPONENT;

---
COMPONENT CONTROL
     Port ( 
                     CLK_C: IN STD_LOGIC;
                     RESET: IN STD_LOGIC;
                     DIV_1: OUT STD_LOGIC            
                     );

END COMPONENT;
---
COMPONENT TRANSMISOR
     Port ( 
                    SCANCODE: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
                    CLK: IN STD_LOGIC; --. SEÑAL DE RELOJ
                    
                    S: IN STD_LOGIC;                   
                    ESC: IN STD_LOGIC;
                    P: IN STD_LOGIC;
                    R: IN STD_LOGIC;
                    UP: IN STD_LOGIC;
                    DOWN: IN STD_LOGIC;
                    LEFT: IN STD_LOGIC;
                    RIGHT: IN STD_LOGIC; 
     --=====                     
                    OUT_HEX: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
                    TX: OUT STD_LOGIC;
                    
                    FINAL:OUT STD_LOGIC; -- PARA VISUALIZAR COMO ESTA HABEINDO INTERACCION
                    SELECIONADOR: OUT STD_LOGIC; ---PARA VER LA SALIDA DE SELECCIONADOR
                    
                    STROBE: OUT STD_LOGIC
                    

               );

END COMPONENT;
---
COMPONENT SYNCHRONIZER
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

END COMPONENT;

SIGNAL S1: STD_LOGIC;
SIGNAL S2,S3: STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL S4: STD_LOGIC;
-----BCD - 7 SEGMEMTS
SIGNAL first: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL second: STD_LOGIC_VECTOR(3 DOWNTO 0);

begin

DRAW: PINTA_VGA PORT MAP(COL_PINTA=>S3,ROW_PINTA=>S2,COLOR=>S1,RED=>R_OUT,GREEN=>G_OUT,BLUE=>B_OUT);
COUNT:  CONTROL PORT MAP(CLK_C=>CLK_VGA,RESET=>'1',DIV_1=>S1);---
SENDDATA: TRANSMISOR  PORT MAP(SCANCODE=>SCANCODE_IN,CLK=>CLK_KEY,S=>S,ESC=>ESC,P=>P,R=>R,
                              UP=>UP,DOWN=>DOWN,LEFT=>LEFT,RIGHT=>RIGHT,STROBE=>STROBE_OUT);

SYNC: SYNCHRONIZER PORT MAP(CLK_S=>CLK_VGA,RESET=>'1',COL=>S3,ROW=>S2,HSYNC_S=>HSYNC_OUT,VSYNC_S=>VSYNC_OUT);

COL<=S3;
ROW<=S2;


-------
first<= SCANCODE_IN(3 DOWNTO 0);
second<= SCANCODE_IN(7 DOWNTO 4);

WITH first SELECT
    seg0  <= "0000001"    WHEN "0000", --0
             "0000001"    WHEN "0001", --1
             "1001111"    WHEN "0010",-- 2
             "0010010"    WHEN "0011",---3
             "0000110"    WHEN "0100",---4
             "1011000"    WHEN "0101",---5
             "0100100"    WHEN "0110",---6
             "0001111"    WHEN "0111",---7
             "0000000"    WHEN "1000",---8
             "0000100"    WHEN "1001",---9***
             "0001000"    WHEN "1010",---A
             "0000000"    WHEN "1011",---B
             "0000111"    WHEN "1100",---C
             "0000000"    WHEN "1101",---D
             "0001010"    WHEN "1110",---E
             "0001011"    WHEN OTHERS;---F
             
WITH SECOND SELECT
                 seg1  <= "0000001"    WHEN "0000", --0
                          "0000001"    WHEN "0001", --1
                          "1001111"    WHEN "0010",-- 2
                          "0010010"    WHEN "0011",---3
                          "0000110"    WHEN "0100",---4
                          "1011000"    WHEN "0101",---5
                          "0100100"    WHEN "0110",---6
                          "0001111"    WHEN "0111",---7
                          "0000000"    WHEN "1000",---8
                          "0000100"    WHEN "1001",---9***
                          "0001000"    WHEN "1010",---A
                          "0000000"    WHEN "1011",---B
                          "0000111"    WHEN "1100",---C
                          "0000000"    WHEN "1101",---D
                          "0001010"    WHEN "1110",---E
                          "0001011"    WHEN OTHERS;---F


end Behavioral;
