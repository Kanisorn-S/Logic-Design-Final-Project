LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY divider_tb IS
END ENTITY;

ARCHITECTURE Behavior OF divider_tb IS

  -- Constants
  CONSTANT N : INTEGER := 8;

  -- DUT Signals
  SIGNAL Clock   	: STD_LOGIC := '0';
  SIGNAL Resetn  	: STD_LOGIC := '1';
  SIGNAL s     	: STD_LOGIC := '0';
  SIGNAL A     	: STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL B     	: STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL Q     	: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
  SIGNAL R     	: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
  SIGNAL EA, EB	: STD_LOGIC := '1';
  SIGNAL Done  	: STD_LOGIC;
  SIGNAL Err   	: STD_LOGIC;

  -- Clock period definition
  CONSTANT clk_period : TIME := 10 ns;
  
  -- Helper signal
  SIGNAL Passed : INTEGER := 0;
  SIGNAL Failed : INTEGER := 0;

BEGIN

  -- Clock process
  clock_process : PROCESS
  BEGIN
    Clock <= '0';
    WAIT FOR clk_period/2;
    Clock <= '1';
    WAIT FOR clk_period/2;
  END PROCESS;

  -- Instantiate the Unit Under Test (UUT)
  uut: ENTITY work.integer_divider
    GENERIC MAP (N => N)
    PORT MAP (
      Clock  => Clock,
      Resetn   => Resetn,
		EA => EA,
		EB => EB,
      s     => s,
      A     => A,
      B     => B,
      R     => R,
		Q     => Q,
		Err   => Err,
      Done  => Done
    );

  -- Stimulus process
  stim_proc: PROCESS
  BEGIN
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