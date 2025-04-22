-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code containing all components

LIBRARY ieee; -- Specify the use of ieee library 
USE ieee.std_logic_1164.all; -- Specify the use of standard 1164 logic component 

PACKAGE my_components IS -- Declare a package name "my_components"
	COMPONENT regne -- Include the regne component in my_components package  
		GENERIC (N: INTEGER := 4); -- Declare a generic N for the size of the input/output vector, set the default value to 4
		PORT ( -- Specify the input and output of a register and their types
				R			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- R is an input of type n-bit STD_LOGIC_VECTOR
				Resetn	: IN STD_LOGIC; -- Resetn is an input of type STD_LOGIC
				E			: IN STD_LOGIC; -- E (Enable) is an input of type STD_LOGIC
				Clock		: IN STD_LOGIC; -- Clock is an input of type STD_LOGIC
				Q			: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)); -- Q is an output of type n-bit STD_LOGIC_VECTOR
	END COMPONENT regne; -- End the regne component declaration
	
	COMPONENT mux -- Include the mux component in my_components package
		GENERIC (N: INTEGER := 4); -- Declare a generic N for the size of the input/output vector, set the default value to 4
		PORT ( -- Specify the input and output of a mux and their types
				SEL	: IN STD_LOGIC; -- SEL is an input of type STD_LOGIC
				D0		: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- D0 is an input of type n-bit STD_LOGIC_VECTOR
				D1		: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- D1 is an input of type n-bit STD_LOGIC_VECTOR
				X		: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)); -- X is an output of type n-bit STD_LOGIC_VECTOR
	END COMPONENT mux; -- End the mux component declaration

	COMPONENT adder -- Include the adder component in my_components package
		GENERIC (N: INTEGER := 4); -- Declare a generic N for the size of the input/output vector, set the default value to 4
		PORT ( -- Specify the input and output of a adder and their types
			   Cin     : IN STD_LOGIC; -- Carry-in is an input of type STD_LOGIC
			   A       : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- A is an input of type n-bit STD_LOGIC_VECTOR 
			   B       : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- B is an input of type n-bit STD_LOGIC_VECTOR 
			   Result  : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Result is an output of type n-bit STD_LOGIC_VECTOR 
			   Cout    : OUT STD_LOGIC); -- Carry-out is an output of type STD_LOGIC
	END COMPONENT adder; -- End the adder component declaration

	COMPONENT is_zero IS -- Include the is_zero comparator component in my_components package
		GENERIC (N: INTEGER := 4); -- Declare a generic N for the size of the input/output vector, set the default value to 4
		PORT ( -- Specify the input and output of an is_zero comparator and their types
				D			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- D is an input of type n-bit STD_LOGIC_VECTOR
				Resetn 	: IN STD_LOGIC; -- Resetn is an input of type STD_LOGIC
				ISZERO	: OUT STD_LOGIC); -- ISZERO is an output of type STD_LOGIC
	END COMPONENT is_zero; -- End the is_zero comparator component declaration
	
	COMPONENT inverter -- Include the inverter component in my_components package
		GENERIC (N : INTEGER := 4); -- Declare a generic N for the size of the input/output vector, set the default value to 4
		PORT ( -- Specify the input and output of a inverter and their types
			   A : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- A is an input of type n-bit STD_LOGIC_VECTOR
			   Y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)); -- Y is an output of type n-bit STD_LOGIC_VECTOR
	END COMPONENT inverter; -- End the inverter component declaration

END PACKAGE my_components; -- End the package declaration