CREATE TABLE DEPT_TEMP
AS(SELECT * FROM DEPT);

SELECT *
FROM DEPT_TEMP DT;

--ISERT DATA를 입력하는 방식
--기본 구문
--INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
--VALUES (데이터1, 데이터2, ...)

--단순한 형태

INSERT INTO
DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (50,'DATABASE','SEOUL');

COMMIT;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (70,'WEB',NULL);

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (70,'WEB',NULL);

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (80,'MOBILE', '');


--VALUE 값이 3개가 들어와야 하는데, 2개만 들어가서 ERROR 가 남
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (90, 'INCHEON');


SELECT * FROM DEPT_TEMP DT;
COMMIT;





--컬럼값만 복사해서 새로운 테이블을 생성
--WHERE 조건건에 1 <> 1
CREATE TABLE EMP_TEMP AS
SELECT * FROM EMP e 
WHERE 1<>1;

COMMIT;

SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (9999,'홍길동','PRESEDENT',NULL,'2001/01/01', 6000,500,10);


INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (2111,'이순신','MANAGER',9999,TO_DATE('07/01/1999','MM/DD/YYYY'), 4000, NULL,20);

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (3111,'심청이','MANAGER',9999,SYSDATE, 4000, NULL, 20);


SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO
,E.ENAME
,E.JOB
,E.MGR 
,E.HIREDATE 
,E.SAL 
,E.COMM 
,E.DEPTNO 
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL  
AND S.GRADE = 1;

SELECT * FROM EMP_TEMP;


--UPDATE문 : 필터된 데이터에 대해서 레코드 값을 수정

CREATE TABLE DEPT_TEMP2   --테스트 개발을 위한 임시 테이블 생성
AS (SELECT * FROM DEPT)
;

SELECT * FROM DEPT_TEMP2   --테스트 개발을 위한 임시 테이블 확인
;

--ROWNUM 우리가 만든 적은 없지만, 자동으로 생성
SELECT * FROM EMP WHERE ROWNUM <3;

/*
 * UPDATE .....
 * SET..... 
 * UPDATE SET 이게 셋트임
 * WHERE가 반드시 필요함
 */

UPDATE DEPT_TEMP2
  SET LOC = 'SEOUL'
  ;
 
 
ROLLBACK;

SELECT * FROM DEPT_TEMP2;


DROP TABLE DEPT_TEMP2;

CREATE TABLE DEPT_TEMP2   
AS (SELECT * FROM DEPT)
;


SELECT * FROM DEPT_TEMP2;

UPDATE DEPT_TEMP2
SET DNAME='DATABASE'
,LOC='SEOUL'
WHERE DEPTNO=40;   --서울발령


UPDATE DEPT_TEMP2
SET (DNAME, LOC) = (SELECT DNAME, LOC
                    FROM DEPT
                    WHERE DEPTNO = 40
                    )
WHERE DEPTNO=40                 --다시 기존 테이블에서 원복
;

ROLLBACK;

SELECT * FROM DEPT_TEMP2;

COMMIT;


/* DELETE 구문으로 테이블에서 값을 제거
 * 
 * 대부분의 경우(또는 반드시) WHERE 같이
 * 
 * 보통의 경우, DELETE 보다는 UPDATE 구문으로 상태 값을 변경
 * 
 * 예시 : 근무/휴직/퇴사 등의 유형으로 값을 변경
 */



--EMP_TEMP2 TABLE 있는지 확인해본것
SELECT * 
FROM EMP_TEMP2;

CREATE TABLE EMP_TEMP2
AS(SELECT * FROM EMP);

COMMIT;

DELETE FROM EMP_TEMP2
WHERE JOB='MANAGER'
;   --인사팀에서 명령 실행 요청

ROLLBACK;  --사장 승인 취소..?
COMMIT;   

/*
 * WHERE 조건을 좀 더 복잡하게 주고
 * DELETE 실행
 */

DELETE FROM EMP_TEMP2
		WHERE EMPNO IN (SELECT EMPNO
		   				FROM EMP_TEMP2 E, SALGRADE S
						WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
						AND S.GRADE = 3
						AND DEPTNO = 30
		  				)
;


/*
 * CREATE 문을 정의 : 기존에 없는 테이블 구조를 생성
 * 
 * 데이터는 없고, 테이블의 컬럼과 데이터 타입, 제약 조건 등의 구조를 생성 
 */

CREATE TABLE 테이블명
(

이게 기본....

);

CREATE TABLE EMP_NEW
(
    EMPNO 	  NUMBER(4)
    ,ENAME 	  VARCHAR(10)
    ,JOB 	  VARCHAR(9)
    ,MGR  	  NUMBER(4)
    ,HIREDATE DATE
    ,SALGRADE NUMBER(7,2)
    ,COMM 	  NUMBER(7,2)
    ,DEPTNO   NUMBER(2)    
)
;


--ROWNUM < 4 이건 작동하는데, ROWNUM = 4 이건 오류남 
SELECT * FROM EMP WHERE ROWNUM <= 6;


SELECT * FROM EMP_NEW;

ALTER TABLE EMP_NEW
ADD HP VARCHAR(20);


--잘못된 컬럼명 HP를 고객 전화번호 컬럼 TEL_NO로 변경
ALTER TABLE EMP_NEW
RENAME COLUMN HP TO TEL_NO;

ALTER TABLE EMP_NEW --새로 인수한 회사 직원 관리 테이블 수정
MODIFY EMPNO NUMBER(5);  --직원 수가 많아 기존 4자리에서 5자리로 수정

ALTER TABLE EMP_NEW 
DROP COLUMN TEL_NO;


/*
 * SEQUENCE 일련번호를 생성하여 테이블 관리를 편리하게 하고자 함
 */

CREATE SEQUENCE SEQ_DEPTNO
	INCREMENT BY 1
	START WITH 1
	MAXVALUE 999
	MINVALUE 1
	NOCYCLE       -- 최대값인 999에 도착하면 멈춤
	NOCACHE       -- 
	;



/*NOCACHE: 시퀀스 값을 캐시하지 않고 매번 디스크에서 읽어옵니다. 캐시를 사용하지 않기 때문에 시퀀스가 순차적이지 않을 수 있습니다.
 *  이는 시퀀스 값이 자주 사용되지 않거나 성능 문제가 발생할 때 유용합니다.
  NOORDER: 시퀀스가 생성되는 순서를 보장하지 않습니다. 
  이 옵션을 사용하면 시퀀스가 빠르게 생성됩니다.
  따라서 "SEQUENCE NOCACHE,NOORDER"는 시퀀스 값을 캐시하지 않고, 생성 순서를 보장하지 않고 빠르게 생성하도록 설정하는 것입니다.*/

INSERT INTO DEPT_TEMP2 (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPTNO.NEXTVAL,'DATABASE','SEOUL')
;


INSERT INTO DEPT_TEMP2 (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPTNO.NEXTVAL,'WEB','BUSAN')
;

INSERT INTO DEPT_TEMP2 (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPTNO.NEXTVAL,'MOBILE','SEUNGSOO')
;

/* 제약조건(CONSTRAINT) 지정
 * 
 * 테이블을 생성할 때, 테이블 컬럼별 제약 조건을 설정
 * 
 * 자주 사용되는 중요한 제약조건 유형
 * NOT NULL
 * UNIQUE
 * PK
 * FK
 */


CREATE TABLE LOGIN
(	
	LOG_ID        VARCHAR2(20)   NOT NULL
	,LOG_PWD      VARCHAR2(20)  NOT NULL
	,TEL         VARCHAR2(20)  
);

INSERT INTO LOGIN(LOG_ID, LOG_PWD)
VALUES ('TEST01','1234')
;


SELECT * FROM LOGIN;




/* TEL 컬럼의 중요성을 나중에 인지하고, NOT NULL 제약조건을 설정
 * 
 */

--제약조건에 이름 설정하지 않음
ALTER TABLE LOGIN
MODIFY TEL NOT NULL
;


--FROM USER_CONSTRAINTS TABLE 에서 제약조건 확인 가능
/*
 * TEL 없는 고객이 발견되어, 수소문 끝에 어렵게 전화번호를 구함
 */

UPDATE LOGIN
SET TEL = '010-1234-5678'
WHERE LOG_ID='TEST01'
;

/*
 * 오라클 DBMS가 사용자를 위해 만들어 놓은 제약조건 설정값 테이블
 */

SELECT OWNER
,CONSTRAINT_NAME
,CONSTRAINT_TYPE
,TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'LOGIN';

ALTER TABLE LOGIN
MODIFY (TEL CONSTRAINT TEL_NN NOT NULL)
;

ALTER TABLE LOGIN
DROP CONSTRAINT TEL_NN
;


/*
 * UNIQUE 키워드 사용
 */

CREATE TABLE LOG_UNIQUE
(
 LOG_ID VARCHAR2(20) UNIQUE
 ,LOG_PWD VARCHAR2(20) NOT NULL
 ,TEL VARCHAR2(20)
);


SELECT * FROM LOG_UNIQUE;
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'LOG_UNIQUE'
;

INSERT INTO LOG_UNIQUE(LOG_ID, LOG_PWD,TEL)
 VALUES ('TEST03', 'PWDASBS','010-0000-0000')
;

INSERT INTO LOG_UNIQUE(LOG_ID, LOG_PWD,TEL)
 VALUES ('TEST02', 'PWDASBS','010-0000-1000')
;

INSERT INTO LOG_UNIQUE(LOG_ID, LOG_PWD,TEL)
 VALUES ('TEST01', 'PWDASBS','010-0000-1200')
;

ALTER TABLE LOG_UNIQUE
MODIFY(TEL UNIQUE)
;



/*
 * PK (주키, PRIMARY KEY) : 테이블을 설명하는 가장 중요한 키
 * 
 * NOT NULL + UNIQUE + INDEX
 * 
 */

CREATE TABLE LOG_PK
(
		LOG_ID			VARCHAR2(20) PRIMARY KEY
		,LOG_PWD		VARCHAR2(20) NOT NULL
		,TEL 			VARCHAR2(20)
);

INSERT INTO LOG_PK (LOG_ID, LOG_PWD, TEL)
VALUES ('PK01','PWD01','010-3456-7890')
;


--기존 고객의 ID와 동일한 ID를 입력하는 경우
--LOG_ID (PK 제약조건 위반) 에러
INSERT INTO LOG_PK (LOG_ID, LOG_PWD, TEL)
VALUES ('PK01','PWD02','011-3456-7890')
;

INSERT INTO LOG_PK (LOG_ID, LOG_PWD, TEL)
VALUES (NULL,'PWD02','011-0456-0090')
;

SELECT *
FROM EMP_TEMP;

/* 
 * 존재하지 않는 부서번호를 EMP_TEMP 테이블에 입력을 시도
 */

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB, MGR, HIREDATE, SAL,COMM,DEPTNO)
VALUES (3333,'GHOST','SURPRISE',9999,SYSDATE,1200,NULL,99)
;

INSERT INTO EMP(EMPNO,ENAME,JOB, MGR, HIREDATE, SAL,COMM,DEPTNO)
VALUES (3333,'GHOST','SURPRISE',9999,SYSDATE,1200,NULL,99)
;

/* INDEX 빠른 검색을 위한 색인
 * 
 * 장점 : 순식간에 원하는 값을 찾아 준다
 * 단점 : 입력과 출력이 잦은 경우, 인덱스가 설정된 테이블의 속도가 저하된다
 */

--특정 직군에 해당하는 직원을 빠르게 찾기 위한 색인 지정
CREATE INDEX idx_emp_job
ON emp(job)
;


SELECT *
FROM EMP;


--설정한 인덱스 리스트 출력
SELECT *
FROM user_indexes;
WHERE TABLE_NAME IN ('EMP', 'DEPT')
;


/*
 * VIEW : TABLE을 편리하게 사용하기 위한 목적으로 생성하는 가상 테이블
 */

CREATE VIEW vw_emp
AS (SELECT empno, ename, job, deptno
    FROM EMP
    WHERE deptno = 10)
;

SELECT *
FROM vw_emp
;

SELECT *
FROM user_views
WHERE view_name = 'VW_EMP'  --테이블명은 대문자로 표기
;

/*
 * ROWNUM 사용 : 상위 N 개를 출력하기 위해 사용하며
 * 컬럼에 ROWNUM 순번을 입력하여 사용할 수 있음
 */


--SAL DESC 순서와 무관하게 EMP 테이블에서 가져오는 순서로 순번을 출력
SELECT rownum
,E.*
FROM emp E
ORDER BY sal DESC
;

SELECT ROWNUM, A.*
FROM (SELECT *
		FROM EMP
		ORDER BY SAL DESC) A
WHERE ROWNUM <=5		
;

/*
 * 오라클 DBMS 에서 관리하는 관리 테이블 리스트 출력
 */
SELECT *
FROM dict
WHERE TABLE_NAME LIKE 'USER_CON%'
;

SELECT *
FROM DBA_TABLES
WHERE TABLE_NAME LIKE 'EMP%'
;

SELECT *
FROM DBA_USERS
WHERE USERNAME = 'SCOTT&'
;










