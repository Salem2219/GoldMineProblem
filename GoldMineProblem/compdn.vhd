library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity compdn is
    port (
    row, col, n, m : in std_logic_vector(3 downto 0);
    y : out std_logic);
end compdn;

architecture rtl of compdn is
signal x1, x2 : std_logic;
begin
    x1 <= '1' when unsigned(row) = (unsigned(m) - 1) else '0';
    x2 <= '1' when unsigned(col) = (unsigned(n) - 1) else '0';
    y <= x1 or x2;
end rtl;
