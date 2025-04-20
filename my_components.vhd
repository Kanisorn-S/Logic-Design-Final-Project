-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code containing all components

LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE my_components IS
	COMPONENT regne
		GENERIC (N: INTEGER := 4);
		PORT (R			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				Resetn	: IN STD_LOGIC;
				E, Clock	: IN STD_LOGIC;
				Q			: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT regne;
	
	COMPONENT mux
		GENERIC (N: INTEGER := 4);
		PORT (SEL	: IN STD_LOGIC;
				D0		: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				D1		: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				X		: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT mux;

	COMPONENT adder
		GENERIC (N: INTEGER := 4);
		PORT (Cin		: IN STD_LOGIC;
				A			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				B			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				Result	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				Cout		: OUT STD_LOGIC);
	END COMPONENT adder;

	COMPONENT is_zero IS 
		GENERIC (N: INTEGER := 4);
		PORT (D			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				Resetn 	: IN STD_LOGIC;
				ISZERO	: OUT STD_LOGIC);
	END COMPONENT is_zero;
	
	COMPONENT inverter 
		GENERIC (N : INTEGER := 4);
		PORT (A : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				Y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT inverter;

END PACKAGE my_components;