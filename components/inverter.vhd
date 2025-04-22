-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit inverter

LIBRARY ieee; -- Specify the use of ieee library
USE ieee.std_logic_1164.ALL; -- Specify the use of standard 1164 logic component

ENTITY inverter IS -- Declare the entity to represent an n-bit inverter
  GENERIC (N : INTEGER := 4); -- Declare a generic N for the size of the input/output vector, set the default value to 4
  PORT ( -- Specify the input and output of the inverter and their data types
		  A : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- A is an input of type n-bit STD_LOGIC_VECTOR
		  Y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)); -- Y is an output of type n-bit STD_LOGIC_VECTOR
END ENTITY inverter; -- End entity declaration

ARCHITECTURE Behaviour OF inverter IS -- Declare the architecture that is binded to the inverter entity
BEGIN -- Begin the architecture of inverter
  Y <= NOT A; -- Set the output Y to be the inverse of the input A
END ARCHITECTURE Behaviour; -- End the logic of the Behaviour architecture which is the logic for an n-bit inverter