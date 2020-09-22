--LCJS.VHD
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
ENTITY	LCJS IS
  PORT(START, DDBZ, WCLK: IN STD_LOGIC;
	       XSLC: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);

LCBZ,JFBZ:OUT STD_LOGIC);
END ENTITY LCJS;
ARCHITECTURE ART OF LCJS IS
  SIGNAL BMS:STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL BMS1: INTEGER RANGE 0 TO 99999;
  SIGNAL JFBZ1: STD_LOGIC;
  BEGIN
  --里程计算及标志产生进程
  PROCESS(START,WCLK)
VARIABLE MS: STD_LOGIC_VECTOR(7 DOWNTO 0); 
    BEGIN
    IF START='1' THEN 
	  MS:="00000000";
	  BMS<="0000000000000000";LCBZ<='0';
    ELSIF WCLK'EVENT AND WCLK='1' THEN
	  IF DDBZ='0' THEN
      IF MS="01100011" THEN
		  MS:="00000000";
BMS<=BMS+'1';  	--百米数计算
        IF BMS>=20 THEN
	        LCBZ<='1';   	--大于2 km标志
      END IF;
	    ELSE 
	      MS:=MS+'1';    	--米数计算
	    END IF;
      END IF;
    END IF;
  END PROCESS;
--里程计算结果输出
  XSLC<=BMS;
  --里程计算结果转换
  BMS1<=CONV_INTEGER(BMS);
  --产生计费信号进程
  PROCESS(BMS1) IS
    BEGIN
    CASE BMS1 IS

WHEN 10|20|30|40|50|60|70|80|90|100=>JFBZ1<='1';
    WHEN 110|120|130|140|150|160|170|180|190|200=>JFBZ1<='1';
    WHEN 210|220|230|240|250|260|270|280|290|300=>JFBZ1<='1';
    WHEN 310|320|330|340|350|360|370|380|390|400=>JFBZ1<='1';
    WHEN 410|420|430|440|450|460|470|480|490|500=>JFBZ1<='1';
    WHEN 510|520|530|540|550|560|570|580|590|600=>JFBZ1<='1';
    WHEN 610|620|630|640|650|660|670|680|690|700=>JFBZ1<='1';
    WHEN 710|720|730|740|750|760|770|780|790|800=>JFBZ1<='1';
    WHEN 810|820|830|840|850|860|870|880|890|900=>JFBZ1<='1';
    WHEN 910|920|930|940|950|960|970|980|990|1000=>JFBZ1<='1'; 
WHEN 1010|1020|1030|1040|1050|1060|1070|1080|1090|1100=>JFBZ1<='1'; 
    WHEN 1110|1120|1130|1140|1150|1160|1170|1180|1190|1200=>JFBZ1<='1';
    WHEN 1210|1220|1230|1240|1250|1260|1270|1280|1290|1300=>JFBZ1<='1';
    WHEN 1310|1320|1330|1340|1350|1360|1370|1380|1390|1400=>JFBZ1<='1';
    WHEN 1410|1420|1430|1440|1450|1460|1470|1480|1490|1500=>JFBZ1<='1';
    WHEN 1510|1520|1530|1540|1550|1560|1570|1580|1590|1600=>JFBZ1<='1';
    WHEN 1610|1620|1630|1640|1650|1660|1670|1680|1690|1700=>JFBZ1<='1';
    WHEN 1710|1720|1730|1740|1750|1760|1770|1780|1790|1800=>JFBZ1<='1';
    WHEN 1810|1820|1830|1840|1850|1860|1870|1880|1890|1900=>JFBZ1<='1';
    WHEN 1910|1920|1930|1940|1950|1960|1970|1980|1990|2000=>JFBZ1<='1';

WHEN 3910|3920|3930|3940|3950|3960|3970|3980|3990|4000=>JFBZ1<='1';
    WHEN OTHERS =>JFBZ1<='0';
    END CASE;
  END PROCESS;
  --计费标志去毛刺进程
  PROCESS(WCLK,JFBZ1) IS
    BEGIN
IF WCLK'EVENT AND WCLK='1' THEN
      JFBZ<=JFBZ1;
    END IF;
  END PROCESS;
END ARCHITECTURE ART;

