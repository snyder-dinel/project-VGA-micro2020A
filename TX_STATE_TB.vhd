----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 16:24:07
-- Design Name: 
-- Module Name: TX_STATE_TB - Behavioral
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

entity TX_STATE_TB is
--  Port ( );
end TX_STATE_TB;

architecture Behavioral of TX_STATE_TB is

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
-- INPUTS
SIGNAL SCANCODE: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL CLK_TX: STD_LOGIC; --. SEÑAL DE RELOJ
SIGNAL S:  STD_LOGIC; 
SIGNAL ESC:  STD_LOGIC;
SIGNAL P:  STD_LOGIC;
SIGNAL R:  STD_LOGIC;
SIGNAL UP:  STD_LOGIC;
SIGNAL DOWN:  STD_LOGIC;
SIGNAL LEFT:  STD_LOGIC;
SIGNAL RIGHT:  STD_LOGIC; 
SIGNAL FIN_DATA:  STD_LOGIC; --**

-- PUTPUTS
SIGNAL SCAN_OUT:  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL SELECTION:  STD_LOGIC;
SIGNAL STROBE:  STD_LOGIC;
-- CONSTANT
CONSTANT clk_period:TIME:=100us;

begin

stados: TX_STATE PORT MAP(SCANCODE=>SCANCODE,CLK_TX=>CLK_TX,S=>S,ESC=>ESC,P=>P,R=>R,
                         UP=>UP,DOWN=>DOWN,LEFT=>LEFT,RIGHT=>RIGHT,FIN_DATA=>FIN_DATA,
                         SCAN_OUT=>SCAN_OUT,SELECTION=>SELECTION,STROBE=>STROBE);


PROCESS
BEGIN
     CLK_TX<='0';
     WAIT FOR clk_period/2;
     CLK_TX<='1';
     WAIT FOR clk_period/2;
     
END PROCESS;

PROCESS
BEGIN
 SCANCODE<="00000000" ;
 S<='0'; 
 ESC<='0';
 P<='0';
 R<='0';
 UP<='0';
 DOWN<='0';
 LEFT<='0';
 RIGHT<='0'; 
 FIN_DATA<='0'; --**  
 
 WAIT FOR clk_period*5;
 
  SCANCODE<="00011011" ;
  S<='1'; 
  ESC<='0';
  P<='0';
  R<='0';
  UP<='0';
  DOWN<='0';
  LEFT<='0';
  RIGHT<='0'; 
  FIN_DATA<='0'; --** 
 
    WAIT FOR clk_period*10; 
    
 SCANCODE<="00000000" ;
    S<='0'; 
    ESC<='0';
    P<='0';
    R<='0';
    UP<='0';
    DOWN<='0';
    LEFT<='0';
    RIGHT<='0'; 
    FIN_DATA<='1'; --**  F0
    
    WAIT FOR clk_period*5;    
    
    SCANCODE<="00000000" ;
        S<='0'; 
        ESC<='0';
        P<='0';
        R<='0';
        UP<='0';
        DOWN<='0';
        LEFT<='0';
        RIGHT<='0'; 
        FIN_DATA<='0'; --**  F0
        
        WAIT FOR clk_period*5; 
    
 
 
END PROCESS;

end Behavioral;
