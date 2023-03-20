SELECT *
FROM EMP e WHERE upper(ename) = upper('scott');


SELECT trim(ename)
FROM EMP;

SELECT empno
, ename
,concat(empno,ename)
,concat(empno, '')
FROM EMP 
WHERE ename = 'SMITH'
;

SELECT lpad('ORA_1234_XE', 20)AS lpad_20
,rpad('ORA_1234_XE', 20)AS rpad_20
FROM dual;

SELECT LPAD('ORA_1234_XE',20)AS LPAD_20
,RPAD('ORA_1234_XE',20)AS RPAD_20
FROM DUAL;

/*
 * NUMBER 숫자를 다루는 함수들
 * 
 * 정수(INTEGER), 부동소수(FLOAT) - 소수점이 있는 숫자
 * 부동소수의 경우, 소수점 이하 정밀도(PRECISION)차이가 발생
 * pi ~ 3.142457...............3939(15자리 이하 소수 버림)
 */

SELECT *
FROM emp e
WHERE e.deptno >= :input_no
;


SELECT ROUND(3.1428)AS round
,round(123.456789)AS round1
,trunc(123.4567)AS trunc
,trunc(-123.4567)AS trunc1
FROM dual;


SELECT ceil(3.14)AS ceil0
,floor(3.14)AS floor0
,mod(15,6)AS MOD0
FROM DUAL;

SELECT REMAINDER(15,2)AS R1
,REMAINDER (-11,4)AS R2
FROM DUAL;

SELECT SYSDATE AS NOW
,NEXT_DAY(SYSDATE, '월요일')AS N_DATE
,LAST_DAY(SYSDATE)AS l_date
FROM DUAL;


SELECT to_char(sysdate,'YYYY/MM/DD HH24')
FROM DUAL
;

SELECT to_char(sysdate,'DD HH24:MI:SS')
FROM DUAL
;

SELECT TO_NUMBER('10,000','999,999,999')-TO_NUMBER('9,000','999,999,999')
FROM DUAL;

SELECT TO_date('49/12/10','YY/MM/DD')AS YY_YEAR_49
,TO_DATE('49/12/10','RR/MM/DD')AS RR_YEAR_49
,TO_DATE('50/12/10','YY/MM/DD')AS YY_YEAR_50
,TO_DATE('50,12,10','RR/MM/DD')AS RR_YEAR_50
,TO_DATE('51/12/10','YY/MM/DD')AS YY_YEAR_51
,TO_DATE('51/12/10', 'RR/MM/DD')AS RR_YEAR_51
FROM DUAL;

SELECT EMPNO,ENAME,COMM 
,NVL(COMM,0)
,SAL+NVL(COMM,0)
FROM EMP;








