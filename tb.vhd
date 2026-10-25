library ieee;use ieee.std_logic_1164.all;use ieee.numeric_std.all;use std.textio.all;use std.env.all;
entity tb is end;architecture test of tb is
signal clk:std_logic:='0';signal rst:std_logic:='1';signal valid,got:std_logic:='0';signal x,y:signed(15 downto 0):=(others=>'0');
begin clk<=not clk after 5 ns;dut:entity work.fir port map(clk,rst,valid,x,y,got);
process file input:file of character;file source:text open read_mode is "input.txt";file golden:text open read_mode is "expected.txt";variable a,b:line;variable value,expected:natural;variable iv,ev:integer;
begin wait for 20 ns;wait until falling_edge(clk);rst<='0';
while not endfile(source) loop readline(source,a);read(a,iv);readline(golden,b);read(b,ev);x<=to_signed(iv,16);valid<='1';wait until falling_edge(clk);assert got='1' and to_integer(y)=ev report "fixed point mismatch" severity failure;end loop;
valid<='0';report "PASS FIR bit-exact vectors";stop;wait;end process;end;
