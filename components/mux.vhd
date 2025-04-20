-- mux
-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for n-bit 2-to-1 MUX

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux IS
	GENERIC (N: INTEGER := 4);
	PORT (SEL	: IN STD_LOGIC;
		   D0		: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			D1		: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			X		: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY mux;

ARCHITECTURE Behaviour OF mux IS
BEGIN
	X <= D1 WHEN (SEL = '1') ELSE D0;
END ARCHITECTURE Behaviour;