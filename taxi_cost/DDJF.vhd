--DDJF.VHD
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
ENTITY DDJF IS
  --ÿ���ӵȴ����ö���,��λΪ��
  GENERIC(WDJ1: INTEGER:=20;
           WDJ2: INTEGER:=33);
PORT(START, XDBZ, DDBZ, CLK1HZ: IN STD_LOGIC;
	       DDFY:OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY DDJF;
ARCHITECTURE ART OF DDJF IS
  SIGNAL DDFY1: STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL CNT60: STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL T60S: STD_LOGIC; 
  BEGIN
  --����60 s�����������źŽ���
PROCESS(CLK1HZ) IS
    BEGIN
    IF CLK1HZ'EVENT AND CLK1HZ='1' THEN
      IF CNT60="00111100" THEN    --CNT60=60
  	    T60S<='1';CNT60<="00000000";
  	  ELSE
  	    CNT60<=CNT60+'1';T60S<='0';
      END IF; 
    END IF;
  END PROCESS ;
  --�ȴ����ü������

PROCESS(T60S,XDBZ,DDBZ) IS
    BEGIN
    IF START='1' THEN
      DDFY1<="0000000000000000";
    ELSIF T60S'EVENT AND T60S='1' THEN
      IF DDBZ='1' THEN
	    IF  XDBZ='0' THEN    	--�ȴ�ʱ��С��1Сʱ
	      DDFY1<=DDFY1+WDJ1; 
	    ELSIF XDBZ='1' THEN  	--�ȴ�ʱ�����1Сʱ
		  DDFY1<=DDFY1+WDJ2;

END IF;
	  END IF;
    END IF;   
  END PROCESS;	
  --�ȴ����ü��������
  DDFY<=DDFY1;
END ARCHITECTURE ART;
