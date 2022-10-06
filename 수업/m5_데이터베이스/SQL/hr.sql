SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM JOBS;
SELECT * FROM LOCATIONS;
SELECT * FROM REGIONS;

--새로운 컬럼 만들어주기
SELECT LAST_NAME, 'is a' job_id FROM EMPLOYEES;

--컬럼 값 붙여서 새로운 컬럼 만들어주기
SELECT LAST_NAME || ' is a ' ||job_id AS EXPLAIN FROM EMPLOYEES;

--NULL 값인 애들
SELECT * FROM EMPLOYEES
WHERE commission_pct IS NULL;

--NULL 값이 아닌 애들
SELECT * FROM EMPLOYEES
WHERE commission_pct IS NOT NULL;

--Q.EMPLOYEES 테이블에서 COMMISSION_PCT NULL값 개수를 출력
SELECT COUNT(*)-COUNT(COMMISSION_PCT) NULL개수
FROM EMPLOYEES;

--Q.EMPLOYEES 테이블에서 EMPLOYEE_ID가 홀수인 것만 출력
SELECT * FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID,2)=1;

--TRUNC : 버림
SELECT LAST_NAME, TRUNC(SALARY/12,2) 월급
FROM EMPLOYEES;

--WIDTH_BUCKET(지정값, 최소값, 최대값, BUCKET개수)
--0~100을 10으로 나눴을 때 지정값의 범주
SELECT WIDTH_BUCKET(92,0,100,10) FROM DUAL;
SELECT WIDTH_BUCKET(30,0,100,3) FROM DUAL;

SELECT UPPER('Hello World') FROM DUAL;
SELECT LOWER('Hello World') FROM DUAL;

SELECT LAST_NAME,SALARY 
FROM EMPLOYEES
WHERE LAST_NAME='king';

SELECT LAST_NAME,SALARY 
FROM EMPLOYEES
WHERE LOWER(LAST_NAME)='king';

SELECT JOB_ID,LENGTH(JOB_ID) FROM EMPLOYEES;
SELECT SUBSTR('Hello World',3,3) FROM DUAL;
SELECT SUBSTR('Hello World',-3,3) FROM DUAL;

--LPAD 비어있는 자릿수 왼쪽부터 채우기
SELECT LPAD('Hello World',20,'#') FROM DUAL;

--RPAD 비어있는 자릿수 오른쪽부터 채우기
SELECT RPAD('Hello World',20,'#') FROM DUAL;

SELECT LAST_NAME, TRIM('A' FROM LAST_NAME) A삭제 FROM EMPLOYEES;

SELECT LTRIM('aaaHello Worldaaa','a') FROM DUAL;
SELECT RTRIM('aaaHello Worldaaa','a') FROM DUAL;
SELECT TRIM(' Hello World ') FROM DUAL;
SELECT LTRIM(' Hello World ') FROM DUAL;
SELECT RTRIM(' Hello World ') FROM DUAL;

SELECT SYSDATE FROM DUAL;

SELECT * FROM EMPLOYEES;

--근속년수 구하기
SELECT LAST_NAME, TRUNC((SYSDATE-HIRE_DATE)/365,0) 근속년수
FROM EMPLOYEES;

--과제_1005_1. EMPLOYEES 테이블에서 채용일에 6개월을 추가한 날짜를 LAST_NAME과 같이 출력
SELECT LAST_NAME,HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) FROM EMPLOYEES;

--과제_1005_2. 이번달의 말일을 반환하는 함수를 사용하여 말일을 출력
SELECT LAST_NAME,HIRE_DATE, LAST_DAY(HIRE_DATE) FROM EMPLOYEES;

--과제_1005_3. EMPLOYEES 테이블에서 채용일과 현재시점간의 근속월수를 출력
SELECT LAST_NAME,TRUNC((MONTHS_BETWEEN(SYSDATE,HIRE_DATE)),0) 근속월수 FROM EMPLOYEES;

--과제_1005_4. 입사일 6개월 후 첫번째 월요일을 LAST_NAME별로 출력
SELECT LAST_NAME,NEXT_DAY(ADD_MONTHS(HIRE_DATE,6),'월') FROM EMPLOYEES;

--과제_1005_5. JOB_ID별로 연봉합계 연봉평균 최고연봉 최저연봉 출력, 단 평균연봉이 5000 이상인 경우만 포함하여 내림차순으로 정렬
SELECT JOB_ID, SUM(SALARY) 연봉합계, AVG(SALARY) 연봉평균, MAX(SALARY) 최고연봉, MIN(SALARY) 최저연봉
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY)>=5000
ORDER BY JOB_ID DESC;

--과제_1005_6. 사원번호(EMPLOYEE_ID)가 110인 사원의 부서명을 출력
SELECT DEPARTMENT_NAME
FROM EMPLOYEES,DEPARTMENTS
WHERE employees.department_id = departments.department_id(+)
AND employees.employee_id=110;

--과제_1005_7. 사번이 120번인 직원의 사번, 이름, 업무(JOB_ID), 업무명(JOB_TITLE)을 출력
SELECT EMPLOYEES.EMPLOYEE_ID 사번, EMPLOYEES.LAST_NAME 이름, EMPLOYEES.JOB_ID 업무, JOBS.JOB_TITLE 업무명
FROM EMPLOYEES,JOBS
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_ID(+)
AND EMPLOYEES.employee_id=120;

--과제_1005_8. 사번, 이름, 직급을 출력하세요. 단, 직급은 아래 기준에 의함
                --salary > 20000 then '대표이사'
                --salary > 15000 then '이사' 
                --salary > 10000 then '부장' 
                --salary > 5000 then '과장' 
                --salary > 3000 then '대리'
                --나머지 '사원'
                
SELECT EMPLOYEE_ID 사번, LAST_NAME 이름, 
        CASE 
            WHEN salary > 20000 then '대표이사'
            WHEN salary > 15000 then '이사'
            WHEN salary > 10000 then '부장'
            WHEN salary > 5000 then '과장'
            WHEN salary > 3000 then '대리'
            ELSE '사원' 
        END 직급
FROM EMPLOYEES;

--과제_1005_9. EMPLOYEES 테이블에서 EMPLOYEE_ID 와 SALARY만 추출해서 EMPLOYEE_SALARY 테이블을 생성하여 출력
DROP TABLE EMPLOYEE_SALARY;

CREATE TABLE EMPLOYEE_SALARY AS SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES;

SELECT * FROM EMPLOYEE_SALARY;

--과제_1005_10. EMPLOYEE_SALARY 테이블의 FIRST_NAME, LAST_NAME 컬럼을 추가한 후 NAME으로 변경하여 출력
ALTER TABLE EMPLOYEE_SALARY 
ADD FIRST_NAME VARCHAR2(40)
ADD LAST_NAME VARCHAR2(40);

SELECT * FROM EMPLOYEE_SALARY;

UPDATE EMPLOYEE_SALARY
SET 
FIRST_NAME = (SELECT FIRST_NAME FROM EMPLOYEES 
              WHERE EMPLOYEE_SALARY.EMPLOYEE_ID=EMPLOYEES.EMPLOYEE_ID),
LAST_NAME = (SELECT LAST_NAME FROM EMPLOYEES 
             WHERE employee_salary.employee_id=employees.employee_id);

SELECT EMPLOYEE_ID, SALARY, FIRST_NAME||' '||LAST_NAME NAME
FROM EMPLOYEE_SALARY;

--과제_1005_11. EMPLOYEE_SALARY 테이블의 EMPLOYEE_ID에 기본키를 적용하고 CONSTRAINT_NAME을 ES_PK로 지정 후 출력
ALTER TABLE EMPLOYEE_SALARY 
ADD CONSTRAINT ES_PK
PRIMARY KEY (EMPLOYEE_ID);

DESC EMPLOYEE_SALARY;

--과제_1005_12. EMPLOYEE_SALARY 테이블의 EMPLOYEE_ID에서 CONSTRAINT_NAME을 삭제 후 삭제 여부를 확인
ALTER TABLE EMPLOYEE_SALARY
DROP CONSTRAINT ES_PK;


--10.06 EMPLOYEES TABLE EDA
SELECT * FROM EMPLOYEES;

--총 107개 항목
SELECT COUNT(*) FROM employees;

--부서: 10~110, 부서 소속 인원: 1~45명 / department_id : 50 젤 많음. 다음 80
SELECT departments.department_id 부서ID, departments.department_name 부서명, COUNT(departments.department_name) 총합
FROM employees, departments
WHERE employees.employee_id=departments.department_id(+)
GROUP BY departments.department_id,departments.department_name
ORDER BY departments.department_name;

SELECT departments.department_name 부서명,employees.JOB_ID 직무명,AVG(SALARY) 평균임금
FROM EMPLOYEES 
WHERE employees.employee_id=departments.department_id(+)
GROUP BY JOB_ID
ORDER BY AVG(SALARY) DESC;

-- 직업별 평균임금 높->낮
SELECT JOB_ID, AVG(SALARY) 평균임금
FROM EMPLOYEES 
GROUP BY JOB_ID
ORDER BY AVG(SALARY) DESC;

SELECT e.FIRST_NAME , e.LAST_NAME , e.SALARY , e.SALARY*1.1 "10%인상 안"
FROM EMPLOYEES e ;


SELECT COUNT(*)
FROM EMPLOYEES e 
WHERE COMMISSION_PCT IS NULL;

--[과제_1006_2] HR테이블을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 2개 이상 작성하세요.(예: 부서별 평균 급여 순위)

--DCL

CREATE USER c##user01
IDENTIFIED BY userpass;

SELECT * FROM ALL_USERS;
DROP USER c##user01;

--grant, revoke
CREATE USER c##user01
IDENTIFIED BY userpass;
GRANT CREATE SESSION, CREATE TABLE TO c##user01;
REVOKE CREATE SESSION, CREATE TABLE FROM c##user01;

--사용자 암호 변경
ALTER USER c##user01
IDENTIFIED BY passuser;

--삭제
DROP USER c##user01 CASCADE;

CREATE TABLE USERS(
ID NUMBER,
NAME VARCHAR(20),
AGE NUMBER
);

INSERT INTO USERS VALUES(1,'hong gildong',30);
INSERT INTO USERS VALUES(1,'hong gilsun',30);

SELECT * FROM USERS;

COMMIT;
DELETE FROM USERS WHERE ID=1;
SELECT * FROM USERS;

ROLLBACK;
SELECT * FROM USERS;