----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 18:53:10
-- Design Name: 
-- Module Name: TRANSMISOR - Behavioral
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

entity TRANSMISOR is
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
end TRANSMISOR;

architecture Behavioral of TRANSMISOR is
COMPONENT TX_STATE
          Port ( 
                    SCANCODE: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
                    CLK_TX: IN STD_LOGIC; --. SEÑAL DE RELOJ
                    
                    S: IN STD_LOGIC;                   
                    ESC: IN STD_LOGIC;
                    P: IN STD_LOGIC;
                    R: IN STD_LOGIC;
                    UP: IN STD_LOGIC;
                    DOWN: IN STD_LOGIC;
                    LEFT: IN STD_LOGIC;
                    RIGHT: IN STD_LOGIC; 
                    --======FIN
                    FIN_DATA: IN STD_LOGIC;
                    --=====                     
                    SCAN_OUT: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
                    SELECTION: OUT STD_LOGIC;
                    STROBE: OUT STD_LOGIC

               );

END COMPONENT;

COMPONENT COMUNICADOR
          Port (
                clk_shift: IN STD_LOGIC; 
                datain: in STD_LOGIC_VECTOR(7 DOWNTO 0); -- datos de entrada
                ending: OUT STD_LOGIC;-- ojo este valor
                tx_data: OUT STD_LOGIC
               
                 );
END COMPONENT;

--SIGNALS
SIGNAL S1,S2,S3,S4,S6: STD_LOGIC;
SIGNAL S5: STD_LOGIC_VECTOR(7 DOWNTO 0);

begin

STATE: TX_STATE  PORT MAP(SCANCODE=>SCANCODE,CLK_TX=>CLK,S=>S,ESC=>ESC,P=>P,R=>R,
                         UP=>UP,DOWN=>DOWN,LEFT=>LEFT,RIGHT=>RIGHT,FIN_DATA=>S6,
                         SCAN_OUT=>S5,SELECTION=>S3,STROBE=>STROBE);
OUT_HEX<=S5;


COMUNICADOR_TX: COMUNICADOR PORT MAP(clk_shift=>CLK,datain=>S5,ending=>S6,tx_data=>S4);
---===============
FINAL<=S6;
SELECIONADOR<=S3;
--================

WITH S3 SELECT
         TX <= S4  WHEN '0',
                '1'  WHEN OTHERS;
     

end Behavioral;
