-- register
-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit register

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY regne IS
	GENERIC (N: INTEGER := 4);
	PORT (R			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		   Resetn	: IN STD_LOGIC;
			E, Clock	: IN STD_LOGIC;
			Q			: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY regne;

ARCHITECTURE Behaviour OF regne IS
BEGIN
	PROCESS (Resetn, Clock)
	BEGIN
		IF Resetn = '0' THEN
			Q <= (OTHERS => '0');
		ELSIF Clock'EVENT AND Clock = '1' THEN
			IF E = '1' THEN
				Q <= R;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE Behaviour;