/*
1.
원자성
완전 함수적 종속
이행적 종속 제거

2.
제1정규화
제2정규화

3.
inner join
left join
right join
outer join

4.
반정규화

5.
인덱스
인덱스
인덱스
인덱스

6.
트랜잭션
원자성
일관성
*/

-- 8p-1
CREATE TABLE DEPT_TEST
AS (SELECT * FROM DEPT);

INSERT INTO dept_test 
VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO dept_test 
VALUES (60, 'SQL', 'ILSAN');
INSERT INTO dept_test 
VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO dept_test 
VALUES (80, 'DML', 'BUNDANG');

SELECT * FROM dept_test;
--8p-2
CREATE TABLE EMP_TEST
AS (SELECT * FROM EMP);

TRUNCATE TABLE emp_test;

INSERT INTO EMP_TEST
VALUES (7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,50);
INSERT INTO EMP_TEST
VALUES (7202,'TEST_USER2','CLERK',7201,'2016-02-21',1800,NULL,60);
INSERT INTO EMP_TEST
VALUES (7203,'TEST_USER3','ANALYST',7201,'2016-04-11',3400,NULL,70);
INSERT INTO EMP_TEST
VALUES (7204,'TEST_USER4','SALESMAN',7201,'2016-05-31',2700,NULL,80);
INSERT INTO EMP_TEST
VALUES (7205,'TEST_USER5','CLERK',7201,'2016-07-20',2600,NULL,50);
INSERT INTO EMP_TEST
VALUES (7206,'TEST_USER6','CLERK',7201,'2016-09-08',2600,NULL,60);
INSERT INTO EMP_TEST
VALUES (7207,'TEST_USER7','LECTURE',7201,'2016-10-28',2300,NULL,70);
INSERT INTO EMP_TEST
VALUES (7208,'TEST_USER8','STUDENT',7201,'2018-03-09',1200,NULL,80);

SELECT * FROM emp_test;

--9p-3
UPDATE emp_test 
SET deptno = 70
WHERE sal > (SELECT AVG(sal) FROM emp_test WHERE deptno = 50);

--9p-4
UPDATE EMP_TEST
SET sal = sal*1.2 , deptno = 80
WHERE TO_NUMBER(TO_CHAR(hiredate,'yyyymmdd')) > (SELECT MIN(TO_NUMBER(TO_CHAR(hiredate,'yyyymmdd'))) FROM emp_test WHERE deptno = 60);


--10p-1
CREATE TABLE emp_user 
(
empno    number(5),
ename    varchar2(20),
job      varchar2(10),
mgr      number(5),
hiredate DATE,
sal      number(7,2),
deptno   number(2),
rowid1   rowid
);

--10p-2
ALTER TABLE emp_user ADD DATE1 DATE;
ALTER TABLE emp_user ADD resign_date DATE;

--10p-3
ALTER TABLE emp_user ADD sur_name varchar2(5);

--10p-4
ALTER TABLE emp_user MODIFY sur_name varchar2(10);

--10p-5
ALTER TABLE emp_user RENAME column ename TO full_name;

--11p-1
CREATE TABLE emp_idx
AS (SELECT * FROM emp);

CREATE INDEX emp_empno_idx
ON emp_idx(empno);

--11p-2
SELECT *
FROM user_indexes
WHERE index_name LIKE 'emp_empno_idx';

--11p-3
CREATE OR REPLACE VIEW emp_view AS
SELECT EMPNO, ENAME, JOB, SAL,
       NVL2(COMM, 'Y', 'N') AS COMM_YN
FROM EMP_IDX
WHERE SAL >= 20000;

/* 12p
제약조건
UNIQUE
NOT null
PK
FK
*/
