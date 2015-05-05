
LIBRARY ieee;
LIBRARY work;
LIBRARY lpm;
LIBRARY altera_mf;
USE lpm.all;
USE altera_mf.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
USE ieee.std_logic_arith.all; 

--***************************************************
--***                                             ***
--***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
--***                                             ***
--***   FP_MUL54US_29S.VHD                        ***
--***                                             ***
--***   Function: 5/6 pipeline stage unsigned 54  ***
--***   bit multiplier                            ***
--***   29S: Stratix 2, 9 18x18, synthesizeable   ***
--***                                             ***
--***   21/04/09 ML                               ***
--***                                             ***
--***   (c) 2009 Altera Corporation               ***
--***                                             ***
--***   Change History                            ***
--***                                             ***
--***                                             ***
--***                                             ***
--***                                             ***
--***************************************************

--***************************************************
--*** Notes:                                      ***
--*** 1. Identical to HCC_MUL54US_29S, except 5   ***
--*** or 6 pipeline parameter and 72 outputs      ***
--***************************************************

ENTITY fp_mul54us_29s IS
GENERIC (latency : positive := 5);
PORT (
      sysclk : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      enable : IN STD_LOGIC;
      mulaa, mulbb : IN STD_LOGIC_VECTOR (54 DOWNTO 1);      

      mulcc : OUT STD_LOGIC_VECTOR (72 DOWNTO 1)  
     );
END fp_mul54us_29s;

ARCHITECTURE syn of fp_mul54us_29s IS

  signal muloneaa, mulonebb : STD_LOGIC_VECTOR (36 DOWNTO 1);
  signal multwoaa, multwobb, multhraa, multhrbb : STD_LOGIC_VECTOR (18 DOWNTO 1);
  signal mulforaa, mulforbb, mulfivaa, mulfivbb : STD_LOGIC_VECTOR (18 DOWNTO 1);
  signal mulsixaa, mulsixbb : STD_LOGIC_VECTOR (18 DOWNTO 1);
  signal muloneout : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal multwoout, multhrout, mulforout, mulfivout, mulsixout : STD_LOGIC_VECTOR (36 DOWNTO 1);

  signal vecone, vectwo, vecthr, vecfor, vecfiv : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal vecsix, vecsev, vecegt, vecnin, vecten : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal sumvecone, carvecone : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal sumvectwo, carvectwo : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal sumvecthr, carvecthr : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal sumoneff, caroneff : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal sumtwoff, cartwoff : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal resultnode : STD_LOGIC_VECTOR (72 DOWNTO 1);
  
  signal zerovec : STD_LOGIC_VECTOR (36 DOWNTO 1);

  component altmult_add
	GENERIC (
		addnsub_multiplier_aclr1		: STRING;
		addnsub_multiplier_pipeline_aclr1		: STRING;
		addnsub_multiplier_pipeline_register1		: STRING;
		addnsub_multiplier_register1		: STRING;
		dedicated_multiplier_circuitry		: STRING;
		input_aclr_a0		: STRING;
		input_aclr_b0		: STRING;
		input_register_a0		: STRING;
		input_register_b0		: STRING;
		input_source_a0		: STRING;
		input_source_b0		: STRING;
		intended_device_family		: STRING;
		lpm_type		: STRING;
		multiplier1_direction		: STRING;
		multiplier_aclr0		: STRING;
		multiplier_register0		: STRING;
		number_of_multipliers		: NATURAL;
		output_aclr		: STRING;
		output_register		: STRING;
		port_addnsub1		: STRING;
		port_signa		: STRING;
		port_signb		: STRING;
		representation_a		: STRING;
		representation_b		: STRING;
		signed_aclr_a		: STRING;
		signed_aclr_b		: STRING;
		signed_pipeline_aclr_a		: STRING;
		signed_pipeline_aclr_b		: STRING;
		signed_pipeline_register_a		: STRING;
		signed_pipeline_register_b		: STRING;
		signed_register_a		: STRING;
		signed_register_b		: STRING;
		width_a		: NATURAL;
		width_b		: NATURAL;
		width_result		: NATURAL
	);
	PORT (
			dataa	: IN STD_LOGIC_VECTOR (width_a-1 DOWNTO 0);
			datab	: IN STD_LOGIC_VECTOR (width_b-1 DOWNTO 0);
			clock0	: IN STD_LOGIC ;
			aclr3	: IN STD_LOGIC ;
			ena0	: IN STD_LOGIC ;
			result	: OUT STD_LOGIC_VECTOR (width_result-1 DOWNTO 0)
	);
	end component;
	
	-- identical component to that above, but fixed at 18x18, latency 2
	-- mul18usus generated by Quartus 
	component hcc_mul18usus
	PORT
	(
		aclr3		: IN STD_LOGIC  := '0';
		clock0		: IN STD_LOGIC  := '1';
		dataa_0		: IN STD_LOGIC_VECTOR (17 DOWNTO 0) :=  (OTHERS => '0');
		datab_0		: IN STD_LOGIC_VECTOR (17 DOWNTO 0) :=  (OTHERS => '0');
		ena0		: IN STD_LOGIC  := '1';
		result		: OUT STD_LOGIC_VECTOR (35 DOWNTO 0)
	);
	end component;

	COMPONENT lpm_add_sub
	GENERIC (
		lpm_direction		: STRING;
		lpm_hint		: STRING;
		lpm_pipeline		: NATURAL;
		lpm_type		: STRING;
		lpm_width		: NATURAL
	);
	PORT (
			dataa	: IN STD_LOGIC_VECTOR (71 DOWNTO 0);
			datab	: IN STD_LOGIC_VECTOR (71 DOWNTO 0);
			clken	: IN STD_LOGIC ;
			aclr	: IN STD_LOGIC ;
			clock	: IN STD_LOGIC ;
			result	: OUT STD_LOGIC_VECTOR (71 DOWNTO 0)
	);
	END COMPONENT;
		 
BEGIN

  gza: FOR k IN 1 TO 36 GENERATE
    zerovec(k) <= '0';
  END GENERATE;

  muloneaa <= mulaa(36 DOWNTO 1);
  mulonebb <= mulbb(36 DOWNTO 1);
  
  multwoaa <= mulaa(54 DOWNTO 37);
  multwobb <= mulbb(18 DOWNTO 1);
  multhraa <= mulaa(54 DOWNTO 37);
  multhrbb <= mulbb(36 DOWNTO 19);
  
  mulforaa <= mulbb(54 DOWNTO 37);
  mulforbb <= mulaa(18 DOWNTO 1);
  mulfivaa <= mulbb(54 DOWNTO 37);
  mulfivbb <= mulaa(36 DOWNTO 19);
  
  mulsixaa <= mulbb(54 DOWNTO 37);
  mulsixbb <= mulaa(54 DOWNTO 37);
  
  -- {C,A) * {D,B}
  -- CAA
  -- DBB
  
  -- AA*BB 36x36=72, latency 3
  mulone : altmult_add
  GENERIC MAP (
		addnsub_multiplier_aclr1 => "ACLR3",
		addnsub_multiplier_pipeline_aclr1 => "ACLR3",
		addnsub_multiplier_pipeline_register1 => "CLOCK0",
		addnsub_multiplier_register1 => "CLOCK0",
		dedicated_multiplier_circuitry => "AUTO",
		input_aclr_a0 => "ACLR3",
		input_aclr_b0 => "ACLR3",
		input_register_a0 => "CLOCK0",
		input_register_b0 => "CLOCK0",
		input_source_a0 => "DATAA",
		input_source_b0 => "DATAB",
		intended_device_family => "Stratix II",
		lpm_type => "altmult_add",
		multiplier1_direction => "ADD",
		multiplier_aclr0 => "ACLR3",
		multiplier_register0 => "CLOCK0",
		number_of_multipliers => 1,
		output_aclr => "ACLR3",
		output_register => "CLOCK0",
		port_addnsub1 => "PORT_UNUSED",
		port_signa => "PORT_UNUSED",
		port_signb => "PORT_UNUSED",
		representation_a => "UNSIGNED",
		representation_b => "UNSIGNED",
		signed_aclr_a => "ACLR3",
		signed_aclr_b => "ACLR3",
		signed_pipeline_aclr_a => "ACLR3",
		signed_pipeline_aclr_b => "ACLR3",
		signed_pipeline_register_a => "CLOCK0",
		signed_pipeline_register_b => "CLOCK0",
		signed_register_a => "CLOCK0",
		signed_register_b => "CLOCK0",
		width_a => 36,
		width_b => 36,
		width_result => 72
	)
	PORT MAP (
		dataa => muloneaa,
		datab => mulonebb,
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => muloneout
	);

  --	Blo*C 18*18 = 36, latency = 2
	multwo: hcc_mul18usus
	PORT MAP (
		dataa_0 => multwoaa,
		datab_0 => multwobb,
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => multwoout
	);
		
  --	Bhi*C 18*18 = 36, latency = 2
  multhr: hcc_mul18usus
	PORT MAP (
		dataa_0 => multhraa,
		datab_0 => multhrbb,
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => multhrout
	);
	
  --	Alo*D 18*18 = 36, latency = 2
  mulfor: hcc_mul18usus
	PORT MAP (
		dataa_0 => mulforaa,
		datab_0 => mulforbb,
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => mulforout
	);	

  --	Ahi*D 18*18 = 36, latency = 2
  mulfiv: hcc_mul18usus
	PORT MAP (
		dataa_0 => mulfivaa,
		datab_0 => mulfivbb,
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => mulfivout
	);

  --	C*D 18*18 = 36, latency = 3
  mulsix : altmult_add
  GENERIC MAP (
		addnsub_multiplier_aclr1 => "ACLR3",
		addnsub_multiplier_pipeline_aclr1 => "ACLR3",
		addnsub_multiplier_pipeline_register1 => "CLOCK0",
		addnsub_multiplier_register1 => "CLOCK0",
		dedicated_multiplier_circuitry => "AUTO",
		input_aclr_a0 => "ACLR3",
		input_aclr_b0 => "ACLR3",
		input_register_a0 => "CLOCK0",
		input_register_b0 => "CLOCK0",
		input_source_a0 => "DATAA",
		input_source_b0 => "DATAB",
		intended_device_family => "Stratix II",
		lpm_type => "altmult_add",
		multiplier1_direction => "ADD",
		multiplier_aclr0 => "ACLR3",
		multiplier_register0 => "CLOCK0",
		number_of_multipliers => 1,
		output_aclr => "ACLR3",
		output_register => "CLOCK0",
		port_addnsub1 => "PORT_UNUSED",
		port_signa => "PORT_UNUSED",
		port_signb => "PORT_UNUSED",
		representation_a => "UNSIGNED",
		representation_b => "UNSIGNED",
		signed_aclr_a => "ACLR3",
		signed_aclr_b => "ACLR3",
		signed_pipeline_aclr_a => "ACLR3",
		signed_pipeline_aclr_b => "ACLR3",
		signed_pipeline_register_a => "CLOCK0",
		signed_pipeline_register_b => "CLOCK0",
		signed_register_a => "CLOCK0",
		signed_register_b => "CLOCK0",
		width_a => 18,
		width_b => 18,
		width_result => 36
	)
	PORT MAP (
		dataa => mulsixaa,
		datab => mulsixbb,
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => mulsixout
	);
	
  vecone <= zerovec(36 DOWNTO 1) & multwoout;
  vectwo <= zerovec(18 DOWNTO 1) & multhrout & zerovec(18 DOWNTO 1);
  vecthr <= zerovec(36 DOWNTO 1) & mulforout;
  vecfor <= zerovec(18 DOWNTO 1) & mulfivout & zerovec(18 DOWNTO 1);

  gva: FOR k IN 1 TO 72 GENERATE
    sumvecone(k) <= vecone(k) XOR vectwo(k) XOR vecthr(k);
    carvecone(k) <= (vecone(k) AND vectwo(k)) OR 
                    (vectwo(k) AND vecthr(k)) OR 
                    (vecone(k) AND vecthr(k));
  END GENERATE;
 
  vecfiv <= vecfor;
  vecsix <= sumvecone;
  vecsev <= carvecone(71 DOWNTO 1) & '0';

  gvb: FOR k IN 1 TO 72 GENERATE
    sumvectwo(k) <= vecfiv(k) XOR vecsix(k) XOR vecsev(k);
    carvectwo(k) <= (vecfiv(k) AND vecsix(k)) OR 
                    (vecsix(k) AND vecsev(k)) OR 
                    (vecfiv(k) AND vecsev(k));
  END GENERATE;

  paa: PROCESS (sysclk,reset)
  BEGIN

    IF (reset = '1') THEN

      FOR k IN 1 TO 72 LOOP
        sumoneff(k) <= '0';
        caroneff(k) <= '0';
        sumtwoff(k) <= '0';
        cartwoff(k) <= '0';
      END LOOP;

    ELSIF (rising_edge(sysclk)) THEN

      IF (enable = '1') THEN

        sumoneff <= sumvectwo;
        caroneff <= carvectwo(71 DOWNTO 1) & '0';
        sumtwoff <= sumvecthr;
        cartwoff <= carvecthr(71 DOWNTO 1) & '0';

      END IF;

    END IF;

  END PROCESS;

  vecegt <= sumoneff;
  vecnin <= caroneff;
  vecten <= mulsixout & muloneout(72 DOWNTO 37);

  gvc: FOR k IN 1 TO 72 GENERATE
    sumvecthr(k) <= vecegt(k) XOR vecnin(k) XOR vecten(k);
    carvecthr(k) <= (vecegt(k) AND vecnin(k)) OR 
                    (vecnin(k) AND vecten(k)) OR 
                    (vecegt(k) AND vecten(k));
  END GENERATE;

  -- according to marcel, 2 pipes = 1 pipe in middle, on on output
	adder : lpm_add_sub
	GENERIC MAP (
		lpm_direction => "ADD",
		lpm_hint => "ONE_INPUT_IS_CONSTANT=NO,CIN_USED=NO",
		lpm_pipeline => latency-4,
		lpm_type => "LPM_ADD_SUB",
		lpm_width => 72
	)
	PORT MAP (
		dataa => sumtwoff(72 DOWNTO 1),
		datab => cartwoff(72 DOWNTO 1),
		clken => enable,
		aclr => reset,
		clock => sysclk,
		result => resultnode
	);
	
  mulcc <= resultnode;
                                  
END syn;

