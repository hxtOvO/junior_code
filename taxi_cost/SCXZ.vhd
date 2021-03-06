--SCXZ.VHD
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY SCXZ IS
  PORT( SEL: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        XSLC: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
LCFY: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        DDSJ: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        DDFY: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        DATA: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY SCXZ;
ARCHITECTURE ART OF SCXZ IS
  BEGIN
DATA<= DDSJ(7 DOWNTO 0) WHEN SEL="000"
	ELSE DDSJ(15 DOWNTO 8) WHEN SEL="001"
	ELSE LCFY(7 DOWNTO 0) WHEN SEL="010"
	ELSE LCFY(15 DOWNTO 8) WHEN SEL="011"
	ELSE DDFY(7 DOWNTO 0) WHEN SEL="100"
	ELSE DDFY(15 DOWNTO 8) WHEN SEL="101"
	ELSE XSLC(7 DOWNTO 0) WHEN SEL="110"
	ELSE XSLC(15 DOWNTO 8) WHEN SEL="111"
	ELSE "00000000";
END ARCHITECTURE ART;

