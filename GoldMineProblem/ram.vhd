library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram is
port(clk, wr : in std_logic;
row, col, i : in std_logic_vector(3 downto 0);
gplusmax : in std_logic_vector(7 downto 0);
gi0, g0, gr, gup, gdn : out std_logic_vector(7 downto 0));
end ram;
architecture rtl of ram is
type ram_type is array (0 to 15, 0 to 15) of
std_logic_vector(7 downto 0);
signal program: ram_type := ((others=> (others=>(others=> '0'))));
signal jminus1 : std_logic_vector(3 downto 0);
signal c1, c2, add : std_logic_vector(7 downto 0);


component minus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component plus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
signal colplus1, rowplus1, rowminus1 : std_logic_vector(3 downto 0);
begin
u1 : plus1 port map (col, colplus1);
u2 : plus1 port map (row, rowplus1);
u3 : minus1 port map (row, rowminus1);
process(clk)
begin
if (rising_edge(clk)) then
if (wr = '1') then
program(conv_integer(unsigned(row)), conv_integer(unsigned(col))) <= gplusmax;
end if;
end if;
end process;
gi0 <= program(conv_integer(unsigned(i)), 0);
g0 <= program(0, 0);
gr <= program(conv_integer(unsigned(row)), conv_integer(unsigned(colplus1)));
gup <= program(conv_integer(unsigned(rowminus1)), conv_integer(unsigned(colplus1)));
gdn <= program(conv_integer(unsigned(rowplus1)), conv_integer(unsigned(colplus1)));
end rtl;