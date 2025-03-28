architecture a1 of digital_part is

    type state_type is (SAMPLE, HOLD, CONVERT);
    signal current_state : state_type;
    signal SA, SB : std_logic;
    signal S : std_logic_vector(8 downto 0);
	signal i : integer := 8;

begin

    -- SB, S
    -- '1' means switch to the 'left' on the schematic
    -- '0' means switch to the 'right' on the schematic
    
    -- SA
    -- '0' is OFF, '1' is ON
    
    -- Next state logic
    process(clock, reset)
	variable comp_out : std_logic_vector(8 downto 0);
    begin
        if reset = '0' then
            SA <= '0';
            SB <= '0';
            S  <= (others => '1');
		   current_state <= SAMPLE;
        elsif rising_edge (clock) then
            case current_state is
                when SAMPLE =>
					SA <= '1';
                   	SB <= '1';
					i <= 8;
                    	S <= (others => '0');	
					comp_out := (others => '0');			
                    	if (start = '1') then current_state <= HOLD;
                    	else current_state <= SAMPLE; end if;
                when HOLD  =>
                    	SA <= '0';
                    	SB <= '0';
                   	S <= (others => '1');
                    	current_state <= CONVERT;
                when CONVERT    =>
                    	SA <= '0';
                    	SB <= '0';
                     if (i = 8) then
                        --Skip comparator
                     elsif (comp = '0') then
                        S(i+1) <= '1';
                     end if;
                     S(i) <= '0';
					comp_out(i) := comp;
					if (i > 1) then
						current_state <= CONVERT;
						i <= i - 1;						
					else 							
						current_state <= SAMPLE;
					end if;
                when others     =>
                    current_state <= SAMPLE;
            end case;
        end if;
    end process;

    SAp <= SA; 
    SAm <= not SA; 

    SBp <= SB; 
    SBm <= not SB; 

    Sp <= S; 
    Sm <= not S;     

	process (clock)
	begin
		if rising_edge (clock) then
			if (current_state = SAMPLE) then
				result(7 downto 1) <= not S(8 downto 2);	
				if (comp = '1') then result(0) <= not S(1); -- Out '1'
				else result(0) <= not S(0); -- Out '0'
				end if;
			end if;
		end if;
	end process;
    
    clkcomp <= not clock;
    
end architecture;
