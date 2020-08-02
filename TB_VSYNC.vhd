----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.07.2020 09:23:20
-- Design Name: 
-- Module Name: TB_VSYNC - Behavioral
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

entity TB_VSYNC is
--  Port ( );
end TB_VSYNC;

architecture Behavioral of TB_VSYNC is
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

-- INPUTS
SIGNAL CLK_LINE:  STD_LOGIC; -- nivel bajo
SIGNAL CLR2:  STD_LOGIC; -- nivel bajo , asincrono
-- OUTPUTS

SIGNAL ROW:  STD_LOGIC_VECTOR(9 DOWNTO 0); --Contador de cada pixel - COLUMNAS
--SIGNAL new_line:  STD_LOGIC; -- OJO : este sera como el reloj para VSYNC
SIGNAL VSYNCR:  STD_LOGIC;-- solo indicara Los porches y la sincronizacion
SIGNAL visible_F:  STD_LOGIC; -- Solo lo visible 0 - 639 -- ZONA VISIBLE

-- CONSTNAT
CONSTANT clk_period:TIME:=32us;

begin
test: VSYNC PORT MAP(CLK_LINE=>CLK_LINE,CLR2=>CLR2,ROW=>ROW,VSYNCR=>VSYNCR,visible_F=>visible_F);

PROCESS
BEGIN
     CLK_LINE<='0';
     WAIT FOR clk_period/2;
     CLK_LINE<='1';
     WAIT FOR clk_period/2;
     
END PROCESS;

PROCESS
BEGIN
     CLR2<='0';
     WAIT FOR clk_period/2;
     
     CLR2<='1';
     WAIT FOR clk_period*10000000;
END PROCESS;

end Behavioral;
