-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit integer divider

LIBRARY ieee; -- Specify the use of ieee library
USE ieee.std_logic_1164.all; -- Specify the use of standard 1164 logic component
USE work.my_components.all; -- Specify the use of components from "my_components" package 

ENTITY integer_divider IS -- Declare the entity to represent an n-bit integer divider 
	GENERIC (N: INTEGER := 4); -- Declare a generic N for the size of the input/output vector, set the default value to 4
	PORT ( -- Specify the input and output of the integer divider and their data types
			Clock 	: IN STD_LOGIC; -- Clock is an input of type STD_LOGIC
			Resetn	: IN STD_LOGIC; -- Resetn is an input of type STD_LOGIC 
			EA,EB, s	: IN STD_LOGIC; -- EA, EB, s (start) are inputs of type STD_LOGIC
			A			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- A is an input of type n-bit STD_LOGIC_VECTOR representing the dividend
			B			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- B is an input of type n-bit STD_LOGIC_VECTOR representing the divisor
			R			: BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- R is an output of type n-bit STD_LOGIC_VECTOR representing the remainder from A/B
			Q			: BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Q is an output of type n-bit STD_LOGIC_VECTOR representing the quotient from A/B
			Err		: OUT STD_LOGIC; -- Err is an output of type STD_LOGIC representing a division by zero error
			Done		: OUT STD_LOGIC); -- Done is an output of type STD_LOGIC representing completion of division 
END ENTITY integer_divider; -- End entity declaration

ARCHITECTURE Behaviour OF integer_divider IS -- Declare the architecture that is binded to the integer_divider entity
	TYPE State_type IS (S0, S1, S2); -- Create new signal type "State_type" to represent the 3 symbolic states from the ASM chart
	SIGNAL y: State_type; -- Create a signal y of type State_type to store the current state of the FSM 
	SIGNAL QA, QB, NQB, DR, DQ, Diff, Sum, One, Zeros: STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Create signals used in the datapath circuit with type STD_LOGIC_VECTOR
	SIGNAL z, RgtB, Rsel, Qsel, ER, EQ, Cout: STD_LOGIC; -- Create signals used in the datapath circuit of type STD_LOGIC 
	BEGIN -- Begin the architecture of integer_divider 
		FSM_transitions: PROCESS(Resetn, Clock) -- Create a process "FSM_transitions" to represent the changing of states of the FSM with sensitiviy list (Resetn, Clock)
		BEGIN -- Begin the process 
			IF Resetn = '0' THEN -- Check for Resetn (asynchronous reset)
				y <= S0; -- Initial state (reset sequence) is S0
			ELSIF (Clock'EVENT AND Clock = '1') THEN -- Check for rising clock edge
				CASE y IS -- Check the current state of the FSM (stored in y)
					WHEN S0 => -- Case when current state is S0
						IF (s = '1' AND z = '0') THEN y <= S1; -- Define the condition for transitioning to S1
						ELSIF (s = '1' AND z = '1') THEN y <= S2; -- Define the condition for transitioning to S2
						ELSE y <= S0; END IF; -- When none of the previous conditions are met, remain at S0
					WHEN S1 => -- Case when current state is S1
						IF RgtB = '0' THEN y <= S2; -- Define the condition for transitioning to S2
						ELSE y <= S1; END IF; -- When the previous condition is not met, remain at S1
					WHEN S2 => -- Case when current state is S2
						IF s = '0' THEN y <= S0; -- Define the condition for transitioning to S0
						ELSE y <= S2; END IF; -- When the previous condition is not met, remain at S2
				END CASE; -- End Switch-case on the current state (y)
			END IF; -- End If-else 
		END PROCESS; -- End the "FSM_transitions" process 
		
		FSM_outputs: PROCESS(y, s, z, RgtB) -- Create a process "FSM_outputs" to represent the changing of states of the FSM with sensitiviy list (y, s, z, RgtB)
		BEGIN -- Begin the process 
			Rsel <= '0'; Qsel <= '0'; Done <= '0'; -- Set all the Moore outputs to 0
			CASE y IS -- Check the current state of the FSM (stored in y)
				WHEN S0 => -- Case when current state is S0
					Rsel <= '0'; Qsel <= '0'; Done <= '0'; -- Set the value for the Moore outputs at S0
					IF (s = '1' AND z = '1') THEN -- Check conditions for Mealy outputs 
						Err <= '1'; -- z is '1' when trying to divide by zero, set Err to 1
					ELSE -- s is '1' and z is '0', start the division process, or s is '0', no start signal yet
						Err <= '0'; -- Set Err to '0'
						ER <= '1'; -- Enable RegR to load A into R
						EQ <= '1'; -- Enable RegQ to load 0 into Q
					END IF; -- End condition check for Mealy outputs 
				WHEN S1 => -- Case when current state is S1
					Rsel <= '1'; Qsel <= '1'; ER <= '0'; EQ <= '0'; -- Set the value for the Moore outputs at S1
					IF (RgtB = '1') THEN -- Check conditions for Mealy outputs, if RgtB is '1'
						ER <= '1'; -- Enable RegR to load R - B into R
						EQ <= '1'; -- Enable RegQ to load Q + 1 into Q
					END IF; -- End condition check for Mealy outputs 
				WHEN S2 => -- Case when current state is S2
					Done <= '1'; -- Set the value for the Moore outputs at S2
			END CASE; -- End Switch-case on current state (y)
		END PROCESS; -- End the "FSM_outputs" process 
		
		-- Define Datapath Circuit
		-- PORT MAP are mappings of inputs/outputs according to the Datapath Circuit 
		One <= (0 => '1', OTHERS => '0'); -- Create n-bit STD_LOGIC_VECTOR with value 1
		Zeros <= (OTHERS => '0'); -- Create n-bit STD_LOGIC_VECTOR with value 0
		RegA: regne GENERIC MAP (N => N) -- Create RegA which is a regne, Map generic of integer_divider to generic of regne 
			PORT MAP (A, Resetn, '1', Clock, QA); -- Map the inputs and outputs of regne component to signals in integer_divider 
		RegB: regne GENERIC MAP (N => N) -- Create RegB which is a regne, Map generic of integer_divider to generic of regne
			PORT MAP (B, Resetn, '1', Clock, QB); -- Map the inputs and outputs of regne component to signals in integer_divider
		RegR: regne GENERIC MAP (N => N) -- Create RegR which is a regne, Map generic of integer_divider to generic of regne
			PORT MAP (DR, Resetn, ER, Clock, R); -- Map the inputs and outputs of regne component to signals in integer_divider
		RegQ: regne GENERIC MAP (N => N) -- Create RegQ which is a regne, Map generic of integer_divider to generic of regne
			PORT MAP (DQ, Resetn, EQ, Clock, Q); -- Map the inputs and outputs of regne component to signals in integer_divider
		IsZero: is_zero GENERIC MAP (N => N) -- Create IsZero which is an is_zero comparator, Map generic of integer_divider to generic of is_zero 
			PORT MAP (QB, Resetn, z); -- Map the inputs and outputs of is_zero component to signals in integer_divider
		NotB: inverter GENERIC MAP (N => N) -- Create NotB which is an inverter, Map generic of integer_divider to generic of inverter
			PORT MAP (QB, NQB); -- Map the inputs and outputs of inverter component to signals in integer_divider
		Subtractor: adder GENERIC MAP (N => N) -- Create Subtractor which is an adder, Map generic of integer_divider to generic of adder
			PORT MAP ('1', R, NQB, Diff, RgtB); -- Map the inputs and outputs of adder component to signals in integer_divider
		QAdder: adder GENERIC MAP (N => N) -- Create Qadder which is a adder, Map generic of integer_divider to generic of adder
			PORT MAP ('0', One, Q, Sum, Cout); -- Map the inputs and outputs of adder component to signals in integer_divider
		RMux: mux GENERIC MAP (N => N) -- Create RMux which is a mux, Map generic of integer_divider to generic of mux
			PORT MAP (Rsel, QA, Diff, DR); -- Map the inputs and outputs of mux component to signals in integer_divider
		QMux: mux GENERIC MAP (N => N) -- Create QMux which is a mux, Map generic of integer_divider to generic of mux
			PORT MAP (Qsel, Zeros, Sum, DQ); -- Map the inputs and outputs of mux component to signals in integer_divider

END ARCHITECTURE Behaviour; -- End the logic of the Behaviour architecture which is the logic for an n-bit integer divider