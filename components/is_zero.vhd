-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit is_zero comparator

LIBRARY ieee; -- Specify the use of ieee library
USE ieee.std_logic_1164.all; -- Specify the use of standard 1164 logic component
USE ieee.std_logic_misc.all; -- Specify the use of standard logic misc component (OR_REDUCE)

ENTITY is_zero IS -- Declare the entity to represent an n-bit zero comparator
	GENERIC (N: INTEGER := 4); -- Declare a generic N for the size of the input/output vector, set the default value to 4
	PORT ( -- Specify the input and output of the comparator and their data types
			D			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- D is an input of type n-bit STD_LOGIC_VECTOR
			Resetn 	: IN STD_LOGIC; -- Resetn is an input of type STD_LOGIC
			ISZERO	: OUT STD_LOGIC); -- ISZERO is an output of type STD_LOGIC
END ENTITY is_zero; -- End entity declaration

ARCHITECTURE Behaviour OF is_zero IS -- Declare the architecture that is binded to the is_zero entity
BEGIN -- Begin the architecture of is_zero comparator
	ISZERO <= (NOT OR_REDUCE(D)) AND Resetn; -- D is zero when its OR_REDUCE is 0, if resetted, should output 0
END ARCHITECTURE Behaviour; -- End the logic of the Behaviour architecture which is the logic for an n-bit is_zero comparator