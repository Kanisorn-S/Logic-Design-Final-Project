-- full adder 
-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for a full_adder

LIBRARY ieee; -- Specify the use of ieee library
USE ieee.std_logic_1164.all; -- Specify the use of standard 1164 logic component

ENTITY full_adder is -- Declare the entity to represent a full adder
  PORT ( -- Specify the input and output of the full adder and their data types
		  Cin   : IN STD_LOGIC; -- Carry-in is an input of type STD_LOGIC
        x     : IN STD_LOGIC; -- x is an input of type STD_LOGIC
        y     : IN STD_LOGIC; -- y is an input of type STD_LOGIC
        s     : OUT STD_LOGIC; -- s is an output of type STD_LOGIC
        Cout  : OUT STD_LOGIC); -- Carry-out is an output of type STD_LOGIC
END ENTITY full_adder; -- End entity declaration

ARCHITECTURE LogicFunc OF full_adder IS -- Declare the architecture that is binded to the full_adder entity
BEGIN -- Begin the architecture of the full adder
  s <= x XOR y XOR Cin; -- Expression for the sum of x, y 
  Cout <= (x AND y) OR (Cin AND x) OR (Cin AND y); -- Expression for the Carry-out from x + y
END ARCHITECTURE LogicFunc; l-- End the logic of the Behaviour architecture which is the logic for a full adder