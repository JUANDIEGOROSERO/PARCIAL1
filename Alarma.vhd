library IEEE;
use IEEE.std_logic_1164.all;

entity Alarma is
	port( 
			cont		  : in std_logic_vector(5 downto 0);
			
			Led_alarma : out std_logic
	);
end Alarma;

architecture Alarma_arq of Alarma is
	begin
		with cont select
			Led_alarma <= '1' when "000000",
					   	  '0' when others; 
end Alarma_arq; 