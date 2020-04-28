library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb is
end tb ;

architecture behav of tb is
  constant clockperiod: time:= 0.1 ns;
  signal clk: std_logic:='0';
  signal rst,start: std_logic;
  signal n, m, row_addr, col_addr : std_logic_vector(3 downto 0);
  signal y, gold : std_logic_vector (7 downto 0);
  component toplevel
     port (clk, rst, start : in std_logic;
    m, n : in std_logic_vector(3 downto 0);
    gold : in std_logic_vector(7 downto 0);
    row_addr, col_addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
  end component ;
  component gold_rom is
port(
row_addr, col_addr : in std_logic_vector(3 downto 0);
dout : out std_logic_vector(7 downto 0));
end component;
  begin
    clk <= not clk after clockperiod /2;
    rst <= '1' , '0' after 0.1 ns;
    start <= '0' , '1' after 0.1 ns, '0' after 0.5 ns;
    n <= "0100";
    m <= "0100";
    dut: toplevel port map(clk,rst,start, m, n, gold, row_addr, col_addr, y);
    dut2 : gold_rom port map (row_addr, col_addr, gold);
  end behav;