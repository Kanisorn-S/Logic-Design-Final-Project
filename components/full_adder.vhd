-- adder/subtractor
-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for a full_adder

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY full_adder is
  PORT (Cin   : IN STD_LOGIC;
        x     : IN STD_LOGIC;
        y     : IN STD_LOGIC;
        s     : OUT STD_LOGIC;
        Cout  : OUT STD_LOGIC);
END ENTITY full_adder;

ARCHITECTURE LogicFunc OF full_adder IS 
BEGIN 
  s <= x XOR y XOR Cin;
  Cout <= (x AND y) OR (Cin AND x) OR (Cin AND y);
END ARCHITECTURE LogicFunc;