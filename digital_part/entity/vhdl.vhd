library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use std.TEXTIO.ALL ;
 
entity digital_part is 
port (
  reset,clock : in std_logic ;
  start ,comp : in std_logic ;
  clkcomp : out std_logic ;
  SAp,SAm,SBp,SBm : out std_logic ;   
  Sp, Sm : out std_logic_vector(8 downto 0) ;
  result : out std_logic_vector(7 downto 0) );
end ;

