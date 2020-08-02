----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.07.2020 22:33:46
-- Design Name: 
-- Module Name: TB_TX - Behavioral
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


entity TB_TX is
--  Port ( );
end TB_TX;

architecture Behavioral of TB_TX is
COMPONENT TX
     Port (
                    clk_ps2: IN STD_LOGIC; -- señal de reloj del teclado - 20KHz
                    S: IN STD_LOGIC;                   
                    ESC: IN STD_LOGIC;
                    P: IN STD_LOGIC;
                    R: IN STD_LOGIC;
                    UP: IN STD_LOGIC;
                    DOWN: IN STD_LOGIC;
                    LEFT: IN STD_LOGIC;
                    RIGHT: IN STD_LOGIC; 
                    --==========SIMULACION DE MIS ENTRADAS
                    tx_data: OUT STD_LOGIC -- SALIDA DATOS == UART
                    --strobe: OUT STD_LOGIC  -- Pulso new interation                                      
                );
END COMPONENT;

--INPUTS
SIGNAL clk_ps2: STD_LOGIC;
SIGNAL S:  STD_LOGIC; 
SIGNAL ESC:  STD_LOGIC;
SIGNAL P:  STD_LOGIC;
SIGNAL R:  STD_LOGIC;
SIGNAL UP:  STD_LOGIC;
SIGNAL DOWN:  STD_LOGIC;
SIGNAL LEFT:  STD_LOGIC;
SIGNAL RIGHT:  STD_LOGIC; 
-- OUTPUTS
SIGNAL tx_data: STD_LOGIC;

--CONSTANT
CONSTANT clk_period:TIME:=100us;
begin
test3: TX PORT MAP(clk_ps2=>clk_ps2,S=>S,ESC=>ESC,P=>P,R=>R,UP=>UP,DOWN=>DOWN,LEFT=>LEFT,RIGHT=>RIGHT,tx_data=>tx_data);

PROCESS
BEGIN
     clk_ps2<='0';
     WAIT FOR clk_period/2;
     clk_ps2<='1';
     WAIT FOR clk_period/2;
     
END PROCESS;

PROCESS
BEGIN
     S<='0';
     R<='0';
     ESC<='0';
     P<='0';
     UP<='0';
     DOWN<='0';
     LEFT<='0';
     RIGHT<='0';
     WAIT FOR clk_period*4;
      
    S<='1';
    R<='0';
    ESC<='0';
    P<='0';
          UP<='0';
          DOWN<='0';
          LEFT<='0';
          RIGHT<='0';
     WAIT FOR clk_period*30;

END PROCESS;
 

end Behavioral;
