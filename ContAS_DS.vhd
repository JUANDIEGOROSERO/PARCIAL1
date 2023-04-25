library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ContAS_DS is
	port( 
		Reset   : in std_logic;
		Clk     : in std_logic;
		Stop 	  : in std_logic;
		
		Decena  : out std_logic_vector(6 downto 0);
		Entero  : out std_logic_vector(6 downto 0);
		Q		  : out std_logic_vector(5 downto 0)
	);
end ContAS_DS;

architecture Cont_Arq of ContAS_DS is

	signal contador_int: integer range 0 to 64 := 10;
	signal contador_sub: integer range 0 to 64 := 0;
	signal bandera_sub: std_logic:='0';
	signal Unidad: unsigned(5 downto 0); 
	signal contador: unsigned(5 downto 0);

begin 
	Contador_D_U: process(Reset, Clk, Stop, contador_int, bandera_sub, contador_sub)
						begin
							if(reset='1')then
								contador_int	<= 10;
								bandera_sub		<='0';
								elsif (Clk'event and Clk='0')then
									if(Stop='1') then
										if(bandera_sub='0') then
											bandera_sub  <= '0';
											contador_int <= contador_int - 1;
										end if;
										if(contador_int=0) then
											contador_int <= 0;
											contador_sub <= 0;
											bandera_sub  <= '1';
										end if;
									end if;
									if(bandera_sub='1') then
											contador_sub <= contador_sub + 1;
											contador_int <= contador_sub;
									end if;
									if(Stop='0') then
										contador_int <= contador_int;
									end if;
									
							end if;
							Q	<=	std_logic_vector(to_signed(contador_int,6));	
					  end process;
			  
contador <= to_unsigned(contador_int,6);

	Display_Decena:	process(contador)
							begin
								if(contador<=9) then
									Decena <= "0000001";
									elsif(contador>9 and contador<20) then
									Decena <= "1001111";
									elsif(contador>19 and contador<30) then
									Decena <= "0010010";
									elsif(contador>29 and contador<40) then
									Decena <= "0000110";
									elsif(contador>39 and contador<50) then
									Decena <= "1001100";
									elsif(contador>49 and contador<60) then
									Decena <= "0100100";
										else
										Decena <= "0100000";
								end if;
							end process;
							
Unidad <= contador mod 10;

	Display_Entero:	process(contador, Unidad)	
							begin
								case Unidad is
									when "000000" => Entero <="0000001";
									when "000001" => Entero <="1001111";
									when "000010" => Entero <="0010010";
									when "000011" => Entero <="0000110";
									when "000100" => Entero <="1001100";
									when "000101" => Entero <="0100100";
									when "000110" => Entero <="0100000";
									when "000111" => Entero <="0001111";
									when "001000" => Entero <="0000000";
									when "001001" => Entero <="0001100";
									when others => Entero  <= "1111111";
								end case;
							end process;
end Cont_Arq;
