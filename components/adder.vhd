-- adder/subtractor
-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for a full_adder and an n-bit ripple carry adder

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY full_adder is
  PORT (Cin   : IN STD_LOGIC;
        x     : IN STD_LOGIC;
        y     : IN STD_LOGIC;
        s     : OUT STD_LOGIC;
        Cout  : OUT STD_LOGIC);
END ENTITY full_adder

ARCHITECTURE LogicFunc OF full_adder IS 
BEGIN 
  s <= x XOR y XOR Cin;
  Cout <= (x AND y) OR (Cin AND x) OR (Cin AND y);
END ARCHITECTURE LogicFunc;

ENTITY adder IS 
  GENERIC (N: INTEGER := 4);
  PORT (Cin     : IN STD_LOGIC;
        A       : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        B       : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        Result  : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        Cout    : OUT STD_LOGIC);
END ENTITY adder;

ARCHITECTURE Behaviour OF adder IS 
  COMPONENT full_adder
    PORT (Cin   : IN STD_LOGIC;
          x     : IN STD_LOGIC;
          y     : IN STD_LOGIC;
          s     : OUT STD_LOGIC;
          Cout  : OUT STD_LOGIC);
  END COMPONENT full_adder;
  SIGNAL carry: STD_LOGIC_VECTOR(N DOWNTO 0);
  BEGIN 
    carry(0) <= Cin;
    FA_array: FOR i IN 0 TO N-1 GENERATE
      FA: full_adder PORT MAP (
        Cin => carry(i),
        x   => A(i),
        y   => B(i),
        s   => Result(i),
        Cout => carry(i+1)
      );
    END GENERATE FA_array;
    Cout <= carry(N);
END ARCHITECTURE Behaviour;