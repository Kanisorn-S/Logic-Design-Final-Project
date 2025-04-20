-- is_zero
-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit is_zero comparator

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_misc.all;

ENTITY is_zero IS
	GENERIC (N: INTEGER := 4);
	PORT (D			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Resetn 	: IN STD_LOGIC;
			ISZERO	: OUT STD_LOGIC);
END ENTITY is_zero;

ARCHITECTURE Behaviour OF is_zero IS
BEGIN
	ISZERO <= (NOT OR_REDUCE(D)) AND Resetn;
END ARCHITECTURE Behaviour;