library ieee;use ieee.std_logic_1164.all;use ieee.numeric_std.all;use work.coefficients.all;
entity fir is port(clk,rst,valid:in std_logic;x:in signed(15 downto 0);y:out signed(15 downto 0);out_valid:out std_logic);end;
architecture rtl of fir is
 type states is array(0 to 29) of signed(47 downto 0);signal z:states:=(others=>(others=>'0'));
begin
 process(clk) variable sum:signed(47 downto 0);variable shifted:signed(47 downto 0);
 begin if rising_edge(clk) then
  out_valid<='0';
  if rst='1' then z<=(others=>(others=>'0'));y<=(others=>'0');
  elsif valid='1' then
   sum:=resize(x*to_signed(C(0),16),48)+z(0);shifted:=shift_right(sum,15);
   if shifted>32767 then y<=to_signed(32767,16);elsif shifted< -32768 then y<=to_signed(-32768,16);else y<=resize(shifted,16);end if;
   for i in 0 to 28 loop z(i)<=resize(x*to_signed(C(i+1),16),48)+z(i+1);end loop;
   z(29)<=resize(x*to_signed(C(30),16),48);out_valid<='1';
  end if;
 end if;end process;
end;
