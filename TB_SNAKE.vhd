----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 23:52:59
-- Design Name: 
-- Module Name: TB_SNAKE - Behavioral
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

entity TB_SNAKE is
--  Port ( );
end TB_SNAKE;

architecture Behavioral of TB_SNAKE is
COMPONENT SNAKE
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

END COMPONENT;
-- SIGNAL
-- INPUT

SIGNAL SCANCODE_IN:  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL CLK_VGA:  STD_LOGIC;
SIGNAL CLK_KEY:  STD_LOGIC;
                
SIGNAL S:  STD_LOGIC;                   
SIGNAL ESC:  STD_LOGIC;
SIGNAL P:  STD_LOGIC;
SIGNAL R:  STD_LOGIC;
SIGNAL UP:  STD_LOGIC;
SIGNAL DOWN:  STD_LOGIC;
SIGNAL LEFT:  STD_LOGIC;
SIGNAL RIGHT:  STD_LOGIC;

--OUTPUT
SIGNAL R_OUT:  STD_LOGIC;
SIGNAL G_OUT:  STD_LOGIC;
SIGNAL B_OUT:  STD_LOGIC;
                
SIGNAL COL:  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL ROW:  STD_LOGIC_VECTOR(9 DOWNTO 0);
                  
SIGNAL VSYNC_OUT:  STD_LOGIC;
SIGNAL HSYNC_OUT:  STD_LOGIC;

SIGNAL STROBE_OUT:  STD_LOGIC;
SIGNAL seg0:  STD_LOGIC_VECTOR(6 DOWNTO 0); --***
SIGNAL seg1:  STD_LOGIC_VECTOR(6 DOWNTO 0); --***

-- CONSTANT CLK1
CONSTANT clk_period2:TIME:=100us;

-- CONSTANT CLK2
CONSTANT clk_period1:TIME:=10ns;

begin
OSITO: SNAKE PORT MAP(SCANCODE_IN=>SCANCODE_IN,CLK_VGA=>CLK_VGA,CLK_KEY=>CLK_KEY,S=>S,
                         ESC=>ESC,P=>P,R=>R,UP=>UP,DOWN=>DOWN,LEFT=>LEFT,RIGHT=>RIGHT,R_OUT=>R_OUT,
                         G_OUT=>G_OUT,B_OUT=>B_OUT,COL=>COL,ROW=>ROW,VSYNC_OUT=>VSYNC_OUT,HSYNC_OUT=>HSYNC_OUT,STROBE_OUT=>STROBE_OUT,
                         seg0=>seg0,seg1=>seg1);

PROCESS
BEGIN
     CLK_VGA<='0';
     WAIT FOR clk_period1/2;
     CLK_VGA<='1';
     WAIT FOR clk_period1/2;
     
END PROCESS;


PROCESS
BEGIN
     CLK_KEY<='0';
     WAIT FOR clk_period2/2;
     CLK_KEY<='1';
     WAIT FOR clk_period2/2;
     
END PROCESS;

PROCESS
BEGIN
SCANCODE_IN<="00000000" ;
S<='0'; 
ESC<='0';
P<='0';
R<='0';
UP<='0';
DOWN<='0';
LEFT<='0';
RIGHT<='0'; 

WAIT FOR clk_period2*50;

SCANCODE_IN<="00011011" ;
S<='1'; 
ESC<='0';
P<='0';
R<='0';
UP<='0';
DOWN<='0';
LEFT<='0';
RIGHT<='0'; 

WAIT FOR clk_period2*80;
END PROCESS;


end Behavioral;
