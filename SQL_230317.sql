SELECT empno,ename,sal, deptno, job
FROM emp WHERE job = 'CLERK'
UNION
SELECT EMPNO,ENAME,SAL,DEPTNO,JOB
FROM EMP WHERE JOB='SALESMAN';

SELECT EMPNO,ENAME,SAL,DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO,ENAME,SAL,DEPTNO
FROM EMP
WHERE DEPTNO = 20;

SELECT * FROM EMP
WHERE UPPER(ENAME) = UPPER('scott'

SELECT JOB
  ,SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5)
  FROM EMP;
  
 SELECT JOB, SUBSTR(JOB,-LENGTH(JOB)),SUBSTR(JOB,-LENGTH(JOB),2), SUBSTR(JOB,-3)
 FROM EMP;

SELECT * FROM EMP e WHERE INSTR(ENAME,'S')>0;

SELECT 'Oracle', LPAD('Oracle', 10, '#')AS LPAD_1
,RPAD('Orcle', 10, '*')AS RPAD_1
,LPAD('Orcle', 10)AS LPAD_2
,RPAD('Oracle',10)AS RPAD_2
FROM DUAL;

SELECT EMPNO,ENAME, CONCAT(EMPNO,ENAME), CONCAT(EMPNO,CONCAT(':',ENAME))
FROM EMP e WHERE ENAME = 'SMITH';

SELECT ROUND(1234.5678) AS R, ROUND(1234.5678,0) AS R_0,
ROUND(1234.5678,1)AS R_1, ROUND(1234.5678,2) AS R_2,
ROUND(1234.5678,-1)R_MINUS1,
ROUND(1234.5678,-2)AS R_MINUS2
FROM DUAL;

SELECT TRUNC(1234.5678)AS TRUNC, TRUNC(1234.5678,0)AS T_0,
TRUNC(1234.5678,1)AS T_1, TRUNC(1234.5678,2)AS T_2,
TRUNC(1234.5678,-1)AS T_MINUS1,
TRUNC(1234.5678,-2)AS T_MINUS2
FROM DUAL;

SELECT CEIL(3.14)AS CEIL, FLOOR(3.14)AS FLOOR,
CEIL(-3.14)AS CEIL_M, FLOOR(-3.14)AS FLOOR_M
FROM DUAL;

SELECT MOD(15,6), MOD(10,2), MOD(11,2) FROM DUAL;

SELECT POWER(3,2), POWER(-3,3)
FROM DUAL;

SELECT ABS(-100),ABS(100),ABS(0)
FROM DUAL;

SELECT SIGN(-100), SIGN(100),SIGN(0)
FROM DUAL;


SELECT SYSDATE AS NOW
,SYSDATE-1 AS YESTERDAY
,SYSDATE+1 AS TOMMOROW
FROM DUAL;

SELECT SYSDATE,ADD_MONTHS(SYSDATE,3)
FROM DUAL;


SELECT EMPNO,ENAME,HIREDATE,
ADD_MONTHS(HIREDATE,12*20)AS WORK10YEAR
FROM EMP;

SELECT EMPNO,ENAME,HIREDATE,SYSDATE
FROM EMP e WHERE ADD_MONTHS(HIREDATE,12*40)>SYSDATE;

SELECT ENAME, HIREDATE, SYSDATE ,MONTHS_BETWEEN(HIREDATE,SYSDATE)/12 AS YEAR1,
MONTHS_BETWEEN(SYSDATE,HIREDATE)/12 AS YEAR2,
TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12)AS YEAR3
FROM EMP;

SELECT SYSDATE,
NEXT_DAY(SYSDATE,'monday'),
LAST_DAY(SYSDATE)
FROM DUAL;

SELECT EMPNO,ENAME,SAL,COMM,SAL+COMM,NVL(COMM,0),SAL+NVL(COMM,0)
FROM EMP;

SELECT EMPNO,ENAME,COMM,NVL2(COMM,'0','X'),NVL2(COMM,SAL*12+COMM,SAL*12)AS ANNSAL
FROM EMP;

SELECT EMPNO,ENAME,JOB,SAL
,DECODE(JOB,'MANAGER',SAL*0.2,'SALESMAN',SAL*0.3,'ANALYST',SAL*0.05,SAL*0.1)AS BONUS
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL,
  CASE JOB
    WHEN 'MAMAGER' THEN SAL*0.2
    WHEN 'SALESMAN' THEN SAL*0.3
    WHEN 'ANAYST' THEN SAL*0.05
    ELSE SAL*0.1
    END AS BONUS
FROM EMP;



SELECT EMPNO,ENAME,COMM,
CASE 
	WHEN COMM IS NULL THEN''
	WHEN COMM = 0 THEN 'ZERO'
	WHEN COMM>0 THEN 'AMOUNT:' ||COMM
END AS Summary
FROM EMP;


SELECT AVG(SAL),DEPTNO
FROM EMP 
GROUP BY DEPTNO;

SELECT DEPTNO,JOB,AVG(SAL)
FROM EMP
GROUP BY DEPTNO,JOB
ORDER BY DEPTNO,JOB;


