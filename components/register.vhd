-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit register

LIBRARY ieee; -- Specify the use of ieee library
USE ieee.std_logic_1164.all; -- Specify the use of standard 1164 logic component

ENTITY regne IS -- Declare the entity to represent an n-bit register (D-flipflops)
	GENERIC (N: INTEGER := 4); -- Declare a generic N for the size of the input/output vector, set the default value to 4
	PORT ( -- Specify the input and output of the register and their data types
			R			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- R is an input of type n-bit STD_LOGIC_VECTOR
		   Resetn	: IN STD_LOGIC; -- Resetn is an input of type STD_LOGIC
			E			: IN STD_LOGIC; -- E (Enable) is an input of type STD_LOGIC
			Clock		: IN STD_LOGIC; -- Clock is an input of type STD_LOGIC
			Q			: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)); -- Q is an output of type n-bit STD_LOGIC_VECTOR
END ENTITY regne; -- End entity declaration

ARCHITECTURE Behaviour OF regne IS -- Declare the architecture that is binded to the register entity
BEGIN -- Begin the architecture of register
	PROCESS (Resetn, Clock) -- Initialize a process with sensitivity list (Resetn, Clock)
	BEGIN -- Begin the process 
		IF Resetn = '0' THEN -- Check for Resetn (asynchronous reset)
			Q <= (OTHERS => '0'); -- Set Q to be 0
		ELSIF Clock'EVENT AND Clock = '1' THEN -- Check for rising clock edge
			IF E = '1' THEN -- Check if the register is enabled
				Q <= R; -- Update Q to be equal to R
			END IF; -- End If-else 
		END IF; -- End If-elsE
	END PROCESS; -- End the process 
END ARCHITECTURE Behaviour; -- End the logic of the Behaviour architecture which is the logic for an n-bit register