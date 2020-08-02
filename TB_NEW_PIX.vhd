----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.07.2020 20:25:25
-- Design Name: 
-- Module Name: TB_NEW_PIX - Behavioral
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
USE IEEE.NUMERIC_STD.ALL; -- INCLUIMOS PARA QUE SE PUEDA USAR OPERACIONES ARITMETICAS EN STD_LOGIC TIPO DE DATOS

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_NEW_PIX is
--  Port ( );
end TB_NEW_PIX;

architecture Behavioral of TB_NEW_PIX is
--1. COMPONENTS
COMPONENT PIX_FORM
        Port ( 
                    CLR: IN STD_LOGIC;
                    CLK: IN STD_LOGIC;
                    pix_form: OUT STD_LOGIC            
                );
END COMPONENT;

--2. SIGNALS
-- INPUTS
SIGNAL CLK: STD_LOGIC:='0';
SIGNAL CLR: STD_LOGIC:='0';
-- OUTPUTS
SIGNAL pix_form1: STD_LOGIC; 
-- CONSTANT
CONSTANT clk_period:TIME:=10ns; 

begin
--- INSTANTATION
--COMP - SIG
mod1: PIX_FORM PORT MAP(CLR=>CLR,CLK=>CLK,pix_form=>pix_form1);

PROCESS
BEGIN
    clk<='0';
    WAIT FOR clk_period/2;
    clk<='1';
    WAIT FOR clk_period/2;
END PROCESS;

PROCESS
BEGIN
    CLR<='0';
    WAIT FOR clk_period*2;
    
    CLR<='1';
    WAIT FOR clk_period*1000;
END PROCESS;

end Behavioral;
