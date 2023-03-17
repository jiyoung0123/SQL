

--2p
--1. 논리 설계
--2. 데이터 모델링
--
--3p
--1. E-R모델
--2. e-R모델
--3. Entity
--
--4p
--1.E-R Diagram(Entity-Relation Diagram)
--2. 관계
--
--5p
--1. 카디널리티
--2. 옵셔널리티
--
--6p
--1.스키마
--2.테이블
--
--7p
--1. table
--2. index
--3. sequence



--8-1
SELECT EMPNO AS "EMPLOYEE_NO", ENAME AS "EMPLOYEE_NAME", JOB, MGR AS "MANAGER", HIREDATE , SAL AS "SALARY", comm AS "COMMISSION", DEPTNO AS "DEPARTMENT_NO"
FROM emp
ORDER BY DEPTNO DESC , ENAME;

--9-1
SELECT *
FROM EMP
WHERE COMM IS NULL
AND SAL IS NOT NULL;
  
--9-2 
SELECT *
FROM EMP
WHERE MGR IS NULL
AND COMM IS NULL;


--10-1
SELECT *
FROM EMP
WHERE ENAME LIKE '%S';


--10-2
SELECT *
FROM EMP
WHERE JOB='SALESMAN' 
AND DEPTNO = 30 ;


--10-3
SELECT * 
FROM EMP
WHERE DEPTNO IN (20,30)
AND SAL > 2000 ;


--10-4
SELECT * 
FROM EMP
WHERE DEPTNO = 20
AND SAL > 2000
UNION
SELECT * 
FROM EMP
WHERE DEPTNO = 30
AND SAL > 2000;

--10-5
SELECT *
FROM EMP
WHERE COMM IS NULL
AND MGR IS NOT NULL
AND JOB IN ('MANAGER', 'CLERK')
AND SUBSTR(ENAME, 2, 1) != 'L';


SELECT EMPNO, 
       CASE WHEN LENGTH(ENAME) >= 6 
            THEN CONCAT(SUBSTR(ENAME, 1, 2), REPEAT('*', LENGTH(ENAME) - 2)) 
            ELSE ENAME 
       END AS ENAME마스킹처리,
       CONCAT(SUBSTR(EMPNO, 1, 2), REPEAT('*', LENGTH(EMPNO) - 2)) AS EMPNO마스킹처리
FROM EMP;

