SELECT *
FROM V$VERSION;

SELECT *
FROM V$OPTION;

SELECT *
FROM V$SESSION;

SELECT * 
FROM V$PARAMETER;



 CREATE TABLE dept_tcl
  AS (SELECT * FROM DEPT);


--COMMIT 실행하는 경우
INSERT INTO DEPT_TCL
VALUES (50,'NEWYORK','SEOUL')
;

UPDATE DEPT_TCL
SET LOC = 'BUSAN'
WHERE DEPTNO = 20
;

/*LOCK TEST
*동일한 계정으로 DBEAVER 세션과 SQL*PLUS 세션을 열어
*데이터를 수정하는 동시 작업을 수행
*/


UPDATE DEPT_TCL
SET LOC = 'DAEGU'
WHERE DEPTNO = 30
;

SELECT * FROM DEPT_TCL;

COMMIT;

/* 
 * TUNING  기초 : 자동차 튜닝과 같이
 * DB 처리 속도(우선) 와 안정성 제고 목적의 경우가 대부분
 */

--튜닝 전과 휴 비교
SELECT *
FROM EMP
WHERE SUBSTR(EMPNO,1,2)=75   --암묵적 형변환 2번
AND LENGTH(EMPNO) =4  --불필요한 비교
;

--튜닝 전과 후 비교
SELECT * 
FROM EMP
WHERE EMPNO > 7499
AND EMPNO <7600
;

--튜닝 전 후 비교
SELECT *
FROM EMP
WHERE ENAME || ' '|| JOB = 'WARD SALESMAN'
;

SELECT *
FROM EMP
WHERE ENAME = 'WARD'
AND JOB = 'SALESMAN'
;


--튜닝 전 후 비교
SELECT DISTINCT E.EMPNO , E.ENAME, D.DEPTNO 
FROM EMP E , DEPT D
WHERE E.DEPTNO =D.DEPTNO 
;

SELECT *
FROM EMP e WHERE DEPTNO = '10'
UNION 
SELECT *
FROM EMP 
WHERE DEPTNO = '20'
;

SELECT ENAME
,EMPNO
,SUM(SAL)
FROM EMP e GROUP BY ENAME, EMPNO
;


--튜닝 전 후 비교
SELECT EMPNO, ENAME
FROM EMP
WHERE TO_CHAR(HIREDATE,'YYYYMMDD') LIKE '1981%'
AND EMPNO>7700
;

SELECT EMPNO, ENAME
FROM EMP e 
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981
AND EMPNO > 7700
;

SELECT *
FROM USER_INDEXES
WHERE TABLE_NAME LIKE 'EMP'
;


DROP INDEX IDX_EMP_JOB;

COMMIT;

CREATE INDEX IDX_EMP_JOB
ON EMP (JOB)
;

--집계 함수를 사용할 때, 최대한 인덱스가 설정된 컬럼을 우선
SELECT JOB, SUM(SAL) AS SUM_OF_SAL
FROM EMP e GROUP BY JOB ORDER BY SUM_OF_SAL DESC 
;

SELECT DEPTNO
, JOB
, FLOOR(AVG(SAL)) AS AVG_SAL
FROM EMP GROUP BY JOB, DEPTNO
ORDER BY JOB, DEPTNO 
;

--HAVING 구문 사용
--GROUP BY 결과에 대한 조건 설정
SELECT DEPTNO
,JOB
,FLOOR(AVG(SAL)) AS AVG_SAL
,MAX(SAL) AS MAX_SAL
,MIN(SAL) AS MIN_SAL
FROM EMP 
GROUP BY JOB, DEPTNO --튜닝을 고려
HAVING MAX(SAL)>=2000 
ORDER BY JOB, DEPTNO  --INDEX가 있는 JOB 컬럼부터 검색
;



SELECT DEPTNO
, LISTAGG(ENAME, ',')
     WITHIN GROUP(ORDER BY HIREDATE DESC) AS ENAME_LISTAGG
FROM EMP e GROUP BY DEPTNO 
;

SELECT DEPTNO, JOB, MAX(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB 
;

SELECT *
FROM (SELECT DEPTNO, JOB, SAL FROM EMP)
PIVOT(MAX(SAL) FOR DEPTNO IN(10,20,30))
ORDER BY JOB
;

SELECT DEPTNO
,MAX(DECODE(JOB,'CLERK'))AS "CLERCK"
,MAX(DECODE(JOB,'SALESMAN'))AS "SALES"
,MAX(DECODE(JOB,'PRESIDENT'))AS "PRESI"
,MAX(DECODE(JOB,'MANAGER'))AS "MGR"
FROM EMP
GROUP BY DEPTNO 
ORDER BY DEPTNO ;


