library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity toplevel is
    port (clk, rst, start : in std_logic;
    m, n : in std_logic_vector(3 downto 0);
    gold : in std_logic_vector(7 downto 0);
    row_addr, col_addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
end toplevel;

architecture rtl of toplevel is
component dp is
    port (clk, rst, wr, col_ld, row_ld, ld, sel : in std_logic;
    m ,n : in std_logic_vector(3 downto 0);
    gold : in std_logic_vector(7 downto 0);
    x1, x2, x3 : out std_logic;
    row_addr, col_addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component ctrl is
  port(clk,rst, start, x1, x2, x3: in std_logic;
        wr, col_ld, row_ld, ld, sel: out std_logic);
end component;
signal wr, col_ld, row_ld, ld, sel, x1, x2, x3 : std_logic;
begin
    datapath : dp port map (clk, rst, wr, col_ld, row_ld, ld, sel,  m ,n, gold, x1, x2, x3, row_addr, col_addr, y);
    control : ctrl port map (clk,rst, start, x1, x2, x3,  wr, col_ld, row_ld, ld, sel);
end rtl;