-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit ripple carry adder

LIBRARY ieee; -- Specify the use of ieee library
USE ieee.std_logic_1164.all; -- Specify the use of standard 1164 logic component

ENTITY adder IS -- Declare the entity to represent an n-bit ripple carry adder
  GENERIC (N: INTEGER := 4); -- Declare a generic N for the size of the input/output vector, set the default value to 4
  PORT ( -- Specify the input and output of the adder and their data types
		  Cin     : IN STD_LOGIC; -- Carry-in is an input of type STD_LOGIC
        A       : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- A is an input of type n-bit STD_LOGIC_VECTOR 
        B       : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- B is an input of type n-bit STD_LOGIC_VECTOR 
        Result  : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Result is an output of type n-bit STD_LOGIC_VECTOR 
        Cout    : OUT STD_LOGIC); -- Carry-out is an output of type STD_LOGIC
END ENTITY adder; -- End entity declaration

ARCHITECTURE Behaviour OF adder IS -- Declare the architecture that is binded to the adder entity
  COMPONENT full_adder -- Declare the full_adder component to be used in the architecture
    PORT ( -- Specify the input and output of a full_adder and their types
			 Cin   : IN STD_LOGIC; -- Carry-in is an input of type STD_LOGIC
          x     : IN STD_LOGIC; -- x is an input of type STD_LOGIC
          y     : IN STD_LOGIC; -- y is an input of type STD_LOGIC 
          s     : OUT STD_LOGIC; -- s(Sum) is an output of type STD_LOGIC
          Cout  : OUT STD_LOGIC); -- Carry-out is an output of type STD_LOGIC
  END COMPONENT full_adder; -- End the full_adder component declaration
  SIGNAL carry: STD_LOGIC_VECTOR(N DOWNTO 0); -- Declare carry signal with type n-bit STD_LOGIC_VECTOR to store carries
  BEGIN -- Begin the architecture of adder 
    carry(0) <= Cin; -- Set the last bit of the carry signal vector to be equal the Carry-In
    FA_array: FOR i IN 0 TO N-1 GENERATE -- Create an array of N full_adder by using for loop
      FA: full_adder PORT MAP ( -- Initialize each full_adder and define the connection
        Cin => carry(i), -- Connect Cin to the ith bit in the carry array signal
        x   => A(i), -- Connect x to the ith bit of the input vector A
        y   => B(i), -- Connect y to the ith bit of the input vector B
        s   => Result(i), -- Connect s to the ith bit of the output vector Result
        Cout => carry(i+1) -- Connect Cout to the i+1th bit of the carry array signal
      );
    END GENERATE FA_array; -- End the generation of the full_adder array
    Cout <= carry(N); -- Set the final Carry-out to be equal the Nth bit of the carray array signal
END ARCHITECTURE Behaviour; -- End the logic of the Behaviour architecture which is the logic for an n-bit ripple carry adder