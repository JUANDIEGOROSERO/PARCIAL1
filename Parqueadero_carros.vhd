library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity Parqueadero_carros is
	port( 
			C1,C2,C3,C4,C5,C6,C7,C8 : in std_logic;
			
			Reloj 						: in std_logic;
			
			Reset_contador1 			: in std_logic;
			Reset_contador2 			: in std_logic;
			Reset_contador3 			: in std_logic;
			Reset_contador4 			: in std_logic;
			Reset_contador5 			: in std_logic;
			Reset_contador6 			: in std_logic;
			Reset_contador7 			: in std_logic;
			Reset_contador8 			: in std_logic;
			
			Reset_Frecuencia			: in std_logic;
			
			Selector						: in std_logic_vector(2 downto 0);
			
			Display_Unidad				: out std_logic_vector(6 downto 0);
			Display_Decena				: out std_logic_vector(6 downto 0);
			Display_Numero				: out std_logic_vector(6 downto 0);
			
			Alarma_Led					: out std_logic
	);
end Parqueadero_carros;

architecture Parqueadero_Arq of Parqueadero_carros is
		
			component DivisorEx
				port( 
					entrada: in  std_logic;
					reset  : in  std_logic;
					salida : out std_logic
				);
			end component;
			
	signal CLK_CONTADOR : std_logic;
		
			component ContAS_DS
				port( 
					Reset   : in std_logic;
					Clk     : in std_logic;
					Stop 	  : in std_logic;

					Decena  : out std_logic_vector(6 downto 0);
					Entero  : out std_logic_vector(6 downto 0);
					Q		  : out std_logic_vector(5 downto 0)
				);
			end component;
			
	signal DEC1, DEC2, DEC3, DEC4, DEC5, DEC6, DEC7, DEC8: std_logic_vector(6 downto 0);
	signal ENT1, ENT2, ENT3, ENT4, ENT5, ENT6, ENT7, ENT8: std_logic_vector(6 downto 0);
	signal Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8: std_logic_vector(5 downto 0);
		
			component Alarma
				port(
					cont   : in std_logic_vector(5 downto 0);
					Led_alarma : out std_logic
				);
			end component;
		
	signal L1, L2, L3, L4, L5, L6, L7, L8: std_logic;

begin						
		A0: DivisorEx port map (Reloj , Reset_Frecuencia , CLK_CONTADOR);
		A1: ContAS_DS port map (Reset_contador1, CLK_CONTADOR, C1, DEC1, ENT1, Q1);
		A2: ContAS_DS port map (Reset_contador1, CLK_CONTADOR, C2, DEC2, ENT2, Q2);
		A3: ContAS_DS port map (Reset_contador1, CLK_CONTADOR, C3, DEC3, ENT3, Q3);
		A4: ContAS_DS port map (Reset_contador1, CLK_CONTADOR, C4, DEC4, ENT4, Q4);
		A5: ContAS_DS port map (Reset_contador1, CLK_CONTADOR, C5, DEC5, ENT5, Q5);
		A6: ContAS_DS port map (Reset_contador1, CLK_CONTADOR, C6, DEC6, ENT6, Q6);
		A7: ContAS_DS port map (Reset_contador1, CLK_CONTADOR, C7, DEC7, ENT7, Q7);
		A8: ContAS_DS port map (Reset_contador1, CLK_CONTADOR, C8, DEC8, ENT8, Q8);
		A9:  Alarma   port map (Q1, L1);
		A10: Alarma   port map (Q2, L2);
		A11: Alarma   port map (Q3, L3);
		A12: Alarma   port map (Q4, L4);
		A13: Alarma   port map (Q5, L5);
		A14: Alarma   port map (Q6, L6);
		A15: Alarma   port map (Q7, L7);
		A16: Alarma   port map (Q8, L8);
	
	with selector select
		Display_Numero	<= "1001111" when "000",		
								"0010010" when "001",
								"0000110" when "010",
								"1001100" when "011",
								"0100100" when "100",
								"0100000" when "101",
								"0001111" when "110",
								"0000000" when others;
								
	with selector select
		Display_Decena <=	DEC1 when "000",		
								DEC2 when "001",
								DEC3 when "010",
								DEC4 when "011",
								DEC5 when "100",
								DEC6 when "101",
								DEC7 when "110",
								DEC8 when others;
								
	with selector select
		Display_Unidad	<=	ENT1 when "000",		
								ENT2 when "001",
								ENT3 when "010",
								ENT4 when "011",
								ENT5 when "100",
								ENT6 when "101",
								ENT7 when "110",
								ENT8 when others;
								
	with selector select
		Alarma_Led	<=	L1 when "000",		
							L2 when "001",
							L3 when "010",
							L4 when "011",
							L5 when "100",
							L6 when "101",
							L7 when "110",
							L8 when others;
							
end Parqueadero_Arq;