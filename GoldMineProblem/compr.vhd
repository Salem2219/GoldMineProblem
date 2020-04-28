library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity compr is
    port (
    col, n : in std_logic_vector(3 downto 0);
    y : out std_logic);
end compr;

architecture rtl of compr is
begin
    y <= '1' when unsigned(col) = (unsigned(n) - 1) else '0';
end rtl;
