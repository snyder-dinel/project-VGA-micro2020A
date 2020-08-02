----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.07.2020 22:07:13
-- Design Name: 
-- Module Name: TB_HSYNC - Behavioral
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

entity TB_HSYNC is
--  Port ( );
end TB_HSYNC;

architecture Behavioral of TB_HSYNC is
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

-- INPUTS
SIGNAL CLK_PIX:  STD_LOGIC; -- nivel bajo
SIGNAL CLR1:  STD_LOGIC; -- nivel bajo , asincrono
-- OUTPUTS

SIGNAL COL:  STD_LOGIC_VECTOR(9 DOWNTO 0); --Contador de cada pixel - COLUMNAS
SIGNAL new_line:  STD_LOGIC; -- OJO : este sera como el reloj para VSYNC
SIGNAL HSYNC1:  STD_LOGIC;-- solo indicara Los porches y la sincronizacion
SIGNAL visible:  STD_LOGIC; -- Solo lo visible 0 - 639 -- ZONA VISIBLE

-- CONSTNAT
CONSTANT clk_period:TIME:=40ns;

begin
test: HSYNC PORT MAP(CLK_PIX=>CLK_PIX,CLR1=>CLR1,COL=>COL,new_line=>new_line,HSYNC=>HSYNC1,visible=>visible);

PROCESS
BEGIN
     CLK_PIX<='0';
     WAIT FOR clk_period/2;
     CLK_PIX<='1';
     WAIT FOR clk_period/2;
     
END PROCESS;

PROCESS
BEGIN
     CLR1<='0';
     WAIT FOR clk_period/2;
     
     CLR1<='1';
     WAIT FOR clk_period*10000000;
END PROCESS;

end Behavioral;
