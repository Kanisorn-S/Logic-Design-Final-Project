-- Author(s): 6538020621 Kanisorn Sangchai
--				  6538177521 Wongsakorn Adirekkitikun
-- Date: 20 April 2025
-- Description: 2147307 Final Project
-- VHDL code for an n-bit inverter

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY inverter IS
  GENERIC (N : INTEGER := 4);
  PORT (
    A : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    Y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY inverter;

ARCHITECTURE Behaviour OF inverter IS
BEGIN
  Y <= NOT A;
END ARCHITECTURE Behaviour;
