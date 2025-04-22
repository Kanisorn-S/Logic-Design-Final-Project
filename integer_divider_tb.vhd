-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 22 April 2025
-- Description: 2147307 Final Project
-- VHDL code for testbench of integer divider 
LIBRARY ieee; -- Specify the use of ieee library
USE ieee.std_logic_1164.ALL; -- Specify the use of standard 1164 logic component 
USE ieee.numeric_std.ALL; -- Specify the use of standard numeric component 

ENTITY divider_tb IS -- Declare the entity to represent the Testbench
END ENTITY; -- End entity declaration

ARCHITECTURE Behavior OF divider_tb IS -- Declare the architecture that is binded to the divider_tb entity

  -- Constants
  CONSTANT N : INTEGER := 8; -- Define a constant N to represent the size of the input/output vector, set to 8

  -- Signals to use with integer divider 
  SIGNAL Clock   	: STD_LOGIC := '0'; -- Clock signal of type STD_LOGIC, initial value '0'
  SIGNAL Resetn  	: STD_LOGIC := '1'; -- Resetn signal of type STD_LOGIC, initial value '1'
  SIGNAL s     	: STD_LOGIC := '0'; -- s (Start) signal of type STD_LOGIC, initial value '0'
  SIGNAL A     	: STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS => '0'); -- A signal of type n-bit STD_LOGIC_VECTOR
  SIGNAL B     	: STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS => '0'); -- B signal of type n-bit STD_LOGIC_VECTOR
  SIGNAL Q     	: STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Q signal of type n-bit STD_LOGIC_VECTOR
  SIGNAL R     	: STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- R signal of type n-bit STD_LOGIC_VECTOR
  SIGNAL EA, EB	: STD_LOGIC := '1'; -- EA, EB signals of type STD_LOGIC, initial value '1'
  SIGNAL Done  	: STD_LOGIC; -- Done signal of type STD_LOGIC
  SIGNAL Err   	: STD_LOGIC; -- Err signal of type STD_LOGIC

  -- Clock period definition
  CONSTANT clk_period : TIME := 10 ns; -- Define a constant clk_period to represent the period of the clock in ns

BEGIN -- Start the logic of the architecture

  -- Clock process
  clock_process : PROCESS -- Clock signal process definitions
  BEGIN -- Begin the clock process 
    Clock <= '0'; -- Begin with teh Clock LOW
    WAIT FOR clk_period/2; -- Hold the Clock LOW for half of the clock period
    Clock <= '1'; -- Set the clock signal to HIGH
    WAIT FOR clk_period/2; -- Hold the clock HIGH for the second half off the clock period 
  END PROCESS; -- End the clock process 

  uut: ENTITY work.integer_divider -- Instantiate the Unit Under Test (UUT)
    GENERIC MAP (N => N) -- Set the generic N of the integer divider to be equal to the constant N
    PORT MAP ( -- Map the signals of the tb architecture to the inputs/outputs of the integer divider component
      Clock  => Clock, -- Map the Clock signal to the Clock signal 
      Resetn   => Resetn, -- Map the Resetn signal to the Resetn signal
		EA => EA, -- Map the EA signal to the EA signal
		EB => EB, -- Map the EB signal to the EB signal
      s     => s, -- Map the s signal to the s signal
      A     => A, -- Map the A signal to the A signal
      B     => B, -- Map the B signal to the B signal
      R     => R, -- Map the R signal to the R signal
		Q     => Q, -- Map the Q signal to the Q signal
		Err   => Err, -- Map the Err signal to the Err signal
      Done  => Done -- Map the Done signal to the Done signal
    );

  -- Stimulus process
  stim_proc: PROCESS -- Stimulus process definitions
  BEGIN -- Begin the stimulus process 
    -- Reset
    Resetn <= '0';
    WAIT FOR clk_period;
    Resetn <= '1';

    -- Test 1: Normal Case: (A = 10, B = 2) -> Q = 5, R = 0
    A <= std_logic_vector(to_unsigned(10, N));
    B <= std_logic_vector(to_unsigned(2, N));
    WAIT FOR clk_period;
    s <= '1';
	 -- Wait for completion
    WAIT UNTIL Done'EVENT;
	 IF Q /= "00000101" THEN REPORT "[X]Test case 1 failed: Incorrect Quotient" SEVERITY error; ELSE REPORT "[O]Test case 1 passed: Correct Quotient"; END IF;
	 IF R /= "00000000" THEN REPORT "[X]Test case 1 failed: Incorrect Remainder" SEVERITY error; ELSE REPORT "[O]Test case 1 passed: Correct Remainder"; END IF;
    WAIT FOR clk_period;
    s <= '0';



    -- Test 2: Edge Case: (A = 1, B = 2) -> Q = 0, R = 1 (B > A)
    A <= std_logic_vector(to_unsigned(1, N));
    B <= std_logic_vector(to_unsigned(2, N));
    WAIT FOR clk_period;
    s <= '1';
    WAIT UNTIL Done'EVENT;
	 IF Q /= "00000000" THEN REPORT "[X]Test case 2 failed: Incorrect Quotient" SEVERITY error; ELSE REPORT "[O]Test case 2 passed: Correct Quotient"; END IF;
	 IF R /= "00000001" THEN REPORT "[X]Test case 2 failed: Incorrect Remainder" SEVERITY error; ELSE REPORT "[O]Test case 2 passed: Correct Remainder"; END IF;
    WAIT FOR clk_period;
    s <= '0';



    -- Test 3: Error Case: (A = 7, B = 0) -> Err = 1 (Invalid: Division by Zero)
    A <= std_logic_vector(to_unsigned(7, N));
    B <= std_logic_vector(to_unsigned(0, N));
    WAIT FOR clk_period;
    s <= '1';
	 WAIT UNTIL Done'EVENT;
	 IF Err /= '1' THEN REPORT "[X]Test case 3 failed: Incorrect Error signal" SEVERITY error; ELSE REPORT "[O]Test case 3 passed: Correct Error signal"; END IF; 
    WAIT FOR clk_period;
    s <= '0';


	 
	 -- Test 4: Large Number Case: (A = 255, B = 16) -> Q = 15, R = 15
    A <= std_logic_vector(to_unsigned(255, N));
    B <= std_logic_vector(to_unsigned(16, N));
    WAIT FOR clk_period;
    s <= '1';
    WAIT UNTIL Done'EVENT;
	 IF Q /= "00001111" THEN REPORT "[X]Test case 4 failed: Incorrect Quotient" SEVERITY error; ELSE REPORT "[O]Test case 4 passed: Correct Quotient"; END IF;
	 IF R /= "00001111" THEN REPORT "[X]Test case 4 failed: Incorrect Remainder" SEVERITY error; ELSE REPORT "[O]Test case 4 passed: Correct Remainder"; END IF;
    WAIT FOR clk_period;
    s <= '0';



	 -- Test 5: Arbitrary Case: (A = 37, B = 5) -> Q = 7, R = 2
    A <= std_logic_vector(to_unsigned(37, N));
    B <= std_logic_vector(to_unsigned(5, N));
    WAIT FOR clk_period;
    s <= '1';
    WAIT UNTIL Done'EVENT;
	 IF Q /= "00000111" THEN REPORT "[X]Test case 5 failed: Incorrect Quotient" SEVERITY error; ELSE REPORT "[O]Test case 5 passed: Correct Quotient"; END IF;
	 IF R /= "00000010" THEN REPORT "[X]Test case 5 failed: Incorrect Remainder" SEVERITY error; ELSE REPORT "[O]Test case 5 passed: Correct Remainder"; END IF;
    WAIT FOR clk_period;
    s <= '0';


    -- Finish simulation
    WAIT;
  END PROCESS;

END ARCHITECTURE Behavior;