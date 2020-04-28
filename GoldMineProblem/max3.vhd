library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity max3 is
    port (
    a, b, c : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end max3;

architecture rtl of max3 is
component max2 is
    port (
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
signal x : std_logic_vector(7 downto 0);
begin
    u1 : max2 port map (a, b, x);
    u2 : max2 port map (c, x, y);
end rtl;