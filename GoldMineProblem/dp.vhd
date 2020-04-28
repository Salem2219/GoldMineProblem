library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dp is
    port (clk, rst, wr, col_ld, row_ld, ld, sel : in std_logic;
    m ,n : in std_logic_vector(3 downto 0);
    gold : in std_logic_vector(7 downto 0);
    x1, x2, x3 : out std_logic;
    row_addr, col_addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
end dp;

architecture rtl of dp is
component complt is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component comp is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component compr is
    port (
    col, n : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component compup is
    port (
    row, col, n : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component compdn is
    port (
    row, col, n, m : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component plus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component minus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component max2 is
    port (
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component max3 is
    port (
    a, b, c : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component adder is
    port (a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component reg4 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(3 downto 0);
reg_out: out std_logic_vector(3 downto 0));
end component;
component reg8 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(7 downto 0);
reg_out: out std_logic_vector(7 downto 0));
end component;
component mux4 is
    port (s : in std_logic;
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component mux8 is
    port (s : in std_logic;
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component ram is
port(clk, wr : in std_logic;
row, col, i : in std_logic_vector(3 downto 0);
gplusmax : in std_logic_vector(7 downto 0);
gi0, g0, gr, gup, gdn : out std_logic_vector(7 downto 0));
end component;
signal xr, xup, xdn : std_logic;
signal col, col_in, minus, row, row_in, rowplus1, i, i_in, iplus1 : std_logic_vector(3 downto 0);
signal right, right_up, right_down, gplusmax, max, max1, res, res_in, gi0, g0, gr, gup, gdn : std_logic_vector(7 downto 0);
begin
    col_reg : reg4 port map (clk, rst, col_ld, minus, col);
    col_mux : mux4 port map (sel, n, col, col_in);
    col_op : minus1 port map (col_in, minus);
    row_reg : reg4 port map (clk, rst, row_ld, row_in, row);
    row_mux : mux4 port map (sel, "0000", rowplus1, row_in);
    row_op : plus1 port map (row, rowplus1);
    i_reg : reg4 port map (clk, rst, ld, i_in, i);
    i_mux : mux4 port map (sel, "0001", iplus1, i_in);
    i_op : plus1 port map (i, iplus1);
    gold_adder : adder port map (gold, max, gplusmax);
    gold_op : max3 port map (right, right_up, right_down, max);
    res_reg : reg8 port map (clk, rst, ld, res_in, res);
    res_mux : mux8 port map (sel, gold, max1, res_in);
    res_op : max2 port map (res, gi0, max1);
    right_comp : compr port map (col, n, xr);
    right_mux : mux8 port map (xr, gr, "00000000", right);
    rightup_comp : compup port map (row, col, n, xup);
    rightup_mux : mux8 port map (xup, gup, "00000000", right_up);
    rightdn_comp : compdn port map (row, col, n, m, xdn);
    rightdn_mux : mux8 port map (xdn, gdn, "00000000", right_down);
    gold_ram : ram port map (clk, wr, row, col, i, gplusmax, gi0, g0, gr, gup, gdn);
    col_comp : comp port map("1111", col, x1);
    row_comp : complt port map(row, m, x2);
    i_comp : complt port map(i, m, x3);
    row_addr <= row;
    col_addr <= col;
    y <= res;
end rtl;