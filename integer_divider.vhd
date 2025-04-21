-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit integer divider

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;

ENTITY integer_divider IS
	GENERIC (N: INTEGER := 4);
	PORT (Clock 	: IN STD_LOGIC;
			Resetn	: IN STD_LOGIC;
			EA,EB, s	: IN STD_LOGIC;
			A			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			B			: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			R			: BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Q			: BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Err		: OUT STD_LOGIC;
			Done		: OUT STD_LOGIC);
END ENTITY integer_divider;

ARCHITECTURE Behaviour OF integer_divider IS
	TYPE State_type IS (S0, S1, S2);
	SIGNAL y: State_type;
	SIGNAL QA, QB, NQB, DR, DQ, Diff, Sum, One, Zeros: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL z, RgtB, Rsel, Qsel, ER, EQ, Cout: STD_LOGIC;
	BEGIN
		FSM_transitions: PROCESS(Resetn, Clock)
		BEGIN
			IF Resetn = '0' THEN
				y <= S0;
			ELSIF (Clock'EVENT AND Clock = '1') THEN
				CASE y IS
					WHEN S0 =>
						IF (s = '1' AND z = '0') THEN y <= S1;
						ELSIF (s = '1' AND z = '1') THEN y <= S2;
						ELSE y <= S0; END IF;
					WHEN S1 =>
						IF RgtB = '0' THEN y <= S2;
						ELSE y <= S1; END IF;
					WHEN S2 =>
						IF s = '0' THEN y <= S0;
						ELSE y <= S2; END IF;
				END CASE;
			END IF;
		END PROCESS;
		
		FSM_outputs: PROCESS(y, s, z, RgtB)
		BEGIN
			Rsel <= '0'; Qsel <= '0'; ER <= '0'; EQ <= '0'; Done <= '0';
			CASE y IS
				WHEN S0 =>
					Rsel <= '0'; Qsel <= '0'; ER <= '1'; EQ <= '1'; Err <= '0'; Done <= '0';
					IF (s = '1' AND z = '1') THEN Err <= '1'; END IF;
				WHEN S1 =>
					Rsel <= '1'; Qsel <= '1'; ER <= '0'; EQ <= '0';
					IF (RgtB = '1') THEN 
						ER <= '1';
						EQ <= '1';
					END IF;
				WHEN S2 =>
					Done <= '1';
			END CASE;
		END PROCESS;
		
		-- Datapath Circuit
		One <= (0 => '1', OTHERS => '0');
		Zeros <= (OTHERS => '0');
		RegA: regne GENERIC MAP (N => N)
			PORT MAP (A, Resetn, '1', Clock, QA);
		RegB: regne GENERIC MAP (N => N)
			PORT MAP (B, Resetn, '1', Clock, QB);
		RegR: regne GENERIC MAP (N => N)
			PORT MAP (DR, Resetn, ER, Clock, R);
		RegQ: regne GENERIC MAP (N => N)
			PORT MAP (DQ, Resetn, EQ, Clock, Q);
		IsZero: is_zero GENERIC MAP (N => N)
			PORT MAP (QB, Resetn, z);
		NotB: inverter GENERIC MAP (N => N)
			PORT MAP (QB, NQB);
		Subtractor: adder GENERIC MAP (N => N)
			PORT MAP ('1', R, NQB, Diff, RgtB);
		QAdder: adder GENERIC MAP (N => N)
			PORT MAP ('0', One, Q, Sum, Cout);
		RMux: mux GENERIC MAP (N => N)
			PORT MAP (Rsel, QA, Diff, DR);
		QMux: mux GENERIC MAP (N => N)
			PORT MAP (Qsel, Zeros, Sum, DQ);

END ARCHITECTURE Behaviour;		