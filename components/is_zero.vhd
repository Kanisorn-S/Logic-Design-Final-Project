-- is_zero
-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit is_zero comparator

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY is_zero IS
	GENERIC (N: INTEGER := 4);
	PORT (D			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			ZEROS 	: BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			ISZERO	: OUT STD_LOGIC);
END ENTITY is_zero;

ARCHITECTURE Behaviour OF is_zero IS
BEGIN
	ZEROS <= (OTHERS => '0');
	ISZERO <= '1' WHEN (D = ZEROS) ELSE 0;
END ARCHITECTURE Behaviour;