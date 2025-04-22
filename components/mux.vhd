-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for n-bit 2-to-1 MUX

LIBRARY ieee; -- Specify the use of ieee library
USE ieee.std_logic_1164.all; -- Specify the use of standard 1164 logic component

ENTITY mux IS -- Declare the entity to represent an n-bit 2:1 MUX 
	GENERIC (N: INTEGER := 4); -- Declare a generic N for the sie of the input/output vector, set the default value to 4
	PORT ( -- Specify the input and output of the MUX and their data types
			SEL	: IN STD_LOGIC; -- SEL is an input of type STD_LOGIC
		   D0		: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- D0 is an input of type n-bit STD_LOGIC_VECTOR
			D1		: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- D1 is an input of type n-bit STD_LOGIC_VECTOR
			X		: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)); -- X is an output of type n-bit STD_LOGIC_VECTOR
END ENTITY mux; -- End entity declaration

ARCHITECTURE Behaviour OF mux IS -- Declare the architecture that is binded to the mux entity
BEGIN -- Begin the architecture of MUX
	X <= D1 WHEN (SEL = '1') ELSE D0; -- The output X is equal to D1 when the select input is 1, else it is equal to D0
END ARCHITECTURE Behaviour; -- End the logic of the Behaviour architecture which is the logic for an n-bit 2:1 MUX