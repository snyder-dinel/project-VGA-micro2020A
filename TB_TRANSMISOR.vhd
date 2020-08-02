----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 19:16:57
-- Design Name: 
-- Module Name: TB_TRANSMISOR - Behavioral
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

entity TB_TRANSMISOR is
--  Port ( );
end TB_TRANSMISOR;

architecture Behavioral of TB_TRANSMISOR is
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
-- INPUTS
SIGNAL SCANCODE:  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL CLK:  STD_LOGIC; --. SEÑAL DE RELOJ                   
SIGNAL S:  STD_LOGIC;                   
SIGNAL ESC:  STD_LOGIC;
SIGNAL P:  STD_LOGIC;
SIGNAL R:  STD_LOGIC;
SIGNAL UP:  STD_LOGIC;
SIGNAL DOWN:  STD_LOGIC;
SIGNAL LEFT:  STD_LOGIC;
SIGNAL RIGHT:  STD_LOGIC; 
--OUTPUTS
 SIGNAL OUT_HEX:  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL TX:  STD_LOGIC;
SIGNAL STROBE:  STD_LOGIC;
SIGNAL SELECIONADOR:  STD_LOGIC;
SIGNAL FINAL: STD_LOGIC; -- PARA VISUALIZAR COMO ESTA HABEINDO INTERACCION

-- CONSTANT
CONSTANT clk_period:TIME:=100us;


begin

DATA1: TRANSMISOR PORT MAP(SCANCODE=>SCANCODE,CLK=>CLK,S=>S,ESC=>ESC,P=>P,R=>R,UP=>UP,
                              DOWN=>DOWN,LEFT=>LEFT,RIGHT=>RIGHT,OUT_HEX=>OUT_HEX,TX=>TX,STROBE=>STROBE,
                              SELECIONADOR=>SELECIONADOR,FINAL=>FINAL);

              
PROCESS
BEGIN
     CLK<='0';
     WAIT FOR clk_period/2;
     CLK<='1';
     WAIT FOR clk_period/2;
     
END PROCESS;


PROCESS
BEGIN
---* INICIO
SCANCODE<="00000000" ; --- 
S<='0'; 
ESC<='0';
P<='0';
R<='0';
UP<='0';
DOWN<='0';
LEFT<='0';
RIGHT<='0'; 
WAIT FOR clk_period*50;
--APRETAMOS TECLA S
SCANCODE<="00011011" ;-- 1B
S<='1'; 
ESC<='0';
P<='0';
R<='0';
UP<='0';
DOWN<='0';
LEFT<='0';
RIGHT<='0'; 
WAIT FOR clk_period*100;




END PROCESS;















end Behavioral;
