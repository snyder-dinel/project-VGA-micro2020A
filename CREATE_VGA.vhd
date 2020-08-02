----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2020 11:38:04
-- Design Name: 
-- Module Name: CREATE_VGA - Behavioral
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

entity CREATE_VGA is
               Port ( 
                                         --- OUTS    
                                         COL_P: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
                                         ROW_P: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
                                        R: OUT STD_LOGIC;
                                        G: OUT STD_LOGIC;
                                        B: OUT STD_LOGIC
                                         );
                                         
end CREATE_VGA;

architecture Behavioral of CREATE_VGA is

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

COMPONENT DRAW_VGA
          Port ( 
                COL: IN STD_LOGIC_VECTOR(9 DOWNTO 0); 
                ROW: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
                R: OUT STD_LOGIC;
                G: OUT STD_LOGIC;
                B: OUT STD_LOGIC
                );

END COMPONENT;

SIGNAL S1,S2,S3,S4,S5,S6,S7,S8,S9: STD_LOGIC;

begin

uut1: SYNCHRONIZER PORT MAP(CLK_S=>S1,RESET=>S2,COL=>COL,ROW=>ROW,VISIBLE_S=>S3,HSYNC_S=>S4,VSYNC_S=>S5,pix_count_S=>S6)
uut5: DRAW_VGA PORT MAP(COL=>COL_P,ROW=>ROW_P,R=>R,G=>G,B=>B)


end Behavioral;
