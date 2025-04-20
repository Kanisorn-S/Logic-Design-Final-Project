-- register
-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit greater-than comparator

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY greater_than IS
	GENERIC (N: INTEGER := 4);
	PORT (D0			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		   D1			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			GT			: OUT STD_LOGIC);
END ENTITY greater_than;

ARCHITECTURE Behaviour OF greater_than IS
BEGIN
	GT <= '1' WHEN (D0 > D1) ELSE 0;
END ARCHITECTURE Behaviour;