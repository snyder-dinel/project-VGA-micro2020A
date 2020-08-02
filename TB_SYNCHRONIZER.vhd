----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.07.2020 11:11:38
-- Design Name: 
-- Module Name: TB_SYNCHRONIZER - Behavioral
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


entity TB_SYNCHRONIZER is
                        
end TB_SYNCHRONIZER;

architecture Behavioral of TB_SYNCHRONIZER is

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
-- INPUTS
SIGNAL CLK_S: STD_LOGIC;
SIGNAL RESET: STD_LOGIC;
-- OUTPUTS

SIGNAL COL:  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL ROW:  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL VISIBLE_S:  STD_LOGIC;
SIGNAL HSYNC_S:  STD_LOGIC;
SIGNAL VSYNC_S:  STD_LOGIC;
SIGNAL pix_count_S: STD_LOGIC_VECTOR(19 DOWNTO 0);-- CONTADOR DE PIXELES

-- CONSTNAT
CONSTANT clk_period:TIME:=10ns;

begin
sync: SYNCHRONIZER PORT MAP(CLK_S=>CLK_S,RESET=>RESET,COL=>COL,ROW=>ROW,VISIBLE_S=>VISIBLE_S,HSYNC_S=>HSYNC_S,VSYNC_S=>VSYNC_S,pix_count_S=>pix_count_S);

PROCESS
BEGIN
     CLK_S<='0';
     WAIT FOR clk_period/2;
     CLK_S<='1';
     WAIT FOR clk_period/2;
     
END PROCESS;

PROCESS
BEGIN
     RESET<='0';
     WAIT FOR clk_period/2;
     
     RESET<='1';
     WAIT FOR clk_period*1000000000;
     
END PROCESS;

end Behavioral;
