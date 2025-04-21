LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY divider_tb IS
END ENTITY;

ARCHITECTURE Behavior OF divider_tb IS

  -- Constants
  CONSTANT N : INTEGER := 4;

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

    -- Test 1: 10 / 3
    A <= std_logic_vector(to_unsigned(10, N));
    B <= std_logic_vector(to_unsigned(3, N));
    WAIT FOR clk_period/2;
    s <= '1';
    WAIT FOR clk_period;
    s <= '0';

    -- Wait for completion
    WAIT UNTIL Done = '1';
    WAIT FOR clk_period;

    -- Test 2: 7 / 2
    A <= std_logic_vector(to_unsigned(7, N));
    B <= std_logic_vector(to_unsigned(2, N));
    WAIT FOR clk_period/2;
    s <= '1';
    WAIT FOR clk_period;
    s <= '0';

    WAIT UNTIL Done = '1';
    WAIT FOR clk_period;

    -- Test 3: Division by zero (expect Err = '1')
    A <= std_logic_vector(to_unsigned(5, N));
    B <= std_logic_vector(to_unsigned(0, N));
    WAIT FOR clk_period/2;
    s <= '1';
    WAIT FOR clk_period;
    s <= '0';

    WAIT UNTIL Done = '1';
    WAIT FOR clk_period;

    -- Finish simulation
    WAIT;
  END PROCESS;

END ARCHITECTURE Behavior;
