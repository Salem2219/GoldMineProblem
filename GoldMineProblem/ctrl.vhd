library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ctrl is
  port(clk,rst, start, x1, x2, x3: in std_logic;
        wr, col_ld, row_ld, ld, sel: out std_logic);
end ctrl;

architecture rtl of ctrl is
  type state_type is (s0,s1,s2,s3, s4, s5, s6, s7);
  signal current_state, next_state: state_type;
begin 
  process(x1, x2, x3, start, current_state)
  begin
    case current_state is
	when s0 =>  
	  wr <= '0';
    col_ld <= '0';
    row_ld <= '0';
    ld <= '0';
    sel <= '0';
	  next_state <= s1;
	when s1 =>  
	  wr <= '0';
    col_ld <= '1';
    row_ld <= '0';
    ld <= '0';
    sel <= '0';
	  if (start = '1') then 
	    next_state <= s2 ;
	  else
	    next_state <= s1;	
	  end if;
	when s2 => 
	  wr <= '0';
    col_ld <= '0';
    row_ld <= '1';
    ld <= '1';
    sel <= '0';
      if (x1 = '1') then
	  next_state <= s6;
      else
      next_state <= s3;
      end if;
	when s3 =>  
	  wr <= '0';
    col_ld <= '0';
    row_ld <= '0';
    ld <= '0';
    sel <= '0';
    if(x2 = '1') then
    next_state <= s4;
    else
    next_state <= s5;
    end if;
    when s4 => 
	  wr <= '1';
    col_ld <= '0';
    row_ld <= '1';
    ld <= '0';
    sel <= '1';
    next_state <= s3;
    when s5 =>
	  wr <= '0';
    col_ld <= '1';
    row_ld <= '0';
    ld <= '0';
    sel <= '1';
    next_state <= s2;
    
    when s6 =>
	  wr <= '0';
    col_ld <= '0';
    row_ld <= '0';
    ld <= '0';
    sel <= '1';
    if (x3 = '1') then
    next_state <= s7;
    else
    next_state <= s1;
    end if;
    
    when s7 =>
	  wr <= '0';
    col_ld <= '0';
    row_ld <= '0';
    ld <= '1';
    sel <= '1';
    next_state <= s6;    
	end case;
  end process;
  process (rst, clk)
  begin
    if (rst ='1') then
      current_state <= s0;
    elsif (rising_edge(clk)) then
      current_state <= next_state;
    end if;
  end process;
end rtl;