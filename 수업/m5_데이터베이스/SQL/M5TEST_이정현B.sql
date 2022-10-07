빅데이터 기반 AI 응용 솔루션 개발자 전문과정

교과목명 : 데이터베이스 구축 및 활용

- 평가일 : 22.10.07
- 성명 : 이정현B
- 점수 : 95


※ HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)를 활용하여 다음 질문들을 수행하세요.
--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
--A.
SELECT LAST_NAME 이름, SALARY 연봉, SALARY*1.1 "10% 인상된 연봉"
FROM EMPLOYEES;
    
--Q2.  2005년 상반기에 입사한 사람들만 출력	
--A.        
 SELECT *
 FROM EMPLOYEES
 WHERE SUBSTR(HIRE_DATE,1,2)=05;

--Q3. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
--A.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'SA_MAN' OR JOB_ID ='IT_PROG' OR JOB_ID = 'ST_MAN';
   
--Q4. manager_id 가 101에서 103인 사람만 출력
--A.   	
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID BETWEEN 101 AND 103;

--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
--A.
SELECT LAST_NAME, HIRE_DATE, NEXT_DAY(ADD_MONTHS(HIRE_DATE,6),'월') "입사일의 6개월 후 첫 번째 월요일"
FROM EMPLOYEES;


--Q6. EMPLOYEES 테이블에서 EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((MONTHS_BETWEEN(SYSDATE,HIRE_DATE)),0) 근속월수
FROM EMPLOYEES
ORDER BY 근속월수 DESC;

--Q7. EMPLOYEES 테이블에서 EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((SYSDATE-HIRE_DATE)/365,0) 근속년수
FROM EMPLOYEES
ORDER BY 근속년수 DESC;

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLOYEE_ID와 LAST_NAME을 출력하세요.
--A. 
SELECT EMPLOYEE_ID,LAST_NAME
FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID,2)=1;

--Q9. EMPLOYEES 테이블에서 EMPLOYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
--A
SELECT EMPLOYEE_ID,LAST_NAME,TRUNC(SALARY/12,2) 월급
FROM EMPLOYEES;

--Q10. EMPLOYEES 테이블에서 EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 근속년수를 계산해서 아래사항을 추가한 후에 출력하세요.
--2001년 1월 1일 창업하여 현재까지 20년간 운영되온 회사는 직원의 근속년수에 따라 30 등급으로 나누어  등급에 따라 1000원의 BONUS를 지급.
--내림차순 정렬.    
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((SYSDATE-HIRE_DATE)/365,0) 근속년수,
        ntile(30) over (order by TRUNC((SYSDATE-HIRE_DATE)/365,0) ASC) 등급, 
        (ntile(30) over (order by TRUNC((SYSDATE-HIRE_DATE)/365,0) ASC))*1000 BONUS
FROM EMPLOYEES;

--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
--A.
SELECT COUNT(*) "commission_pct 의  Null값 갯수"
FROM EMPLOYEES
WHERE commission_pct IS NULL;

--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
--A.
SELECT LAST_NAME, CASE WHEN department_id IS NULL THEN '신입' END POSITION
FROM EMPLOYEES
WHERE department_id IS NULL;

--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
--A.
SELECT EMPLOYEES.LAST_NAME 이름, EMPLOYEES.JOB_ID 업무, JOBS.job_title 업무명
FROM EMPLOYEES,JOBS
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_ID 
AND EMPLOYEE_ID=120;

SELECT EMPLOYEES.LAST_NAME 이름, EMPLOYEES.JOB_ID 업무, JOBS.job_title 업무명
FROM EMPLOYEES
JOIN JOBS
ON EMPLOYEES.JOB_ID = JOBS.JOB_ID 
AND EMPLOYEE_ID=120;

--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
--A. 
SELECT (FIRST_NAME ||' '|| LAST_NAME) NAME
FROM EMPLOYEES;

--Q15. lmembers purprod 테이블로 부터 총구매액, 2014 구매액, 2015 구매액을 한번에 출력하세요.
--A.
SELECT SUM(puramt) 총구매액, 
SUM(CASE WHEN purdate <= '20141231' THEN puramt END) "2014 구매액", 
SUM(CASE WHEN purdate > '20141231' AND purdate <= '20151231' THEN puramt END) "2015 구매액"
FROM purprd;

--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
--A.
SELECT *
FROM EMPLOYEES,DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
AND JOB_ID LIKE '%\_A%' ESCAPE '\';

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--A. 
SELECT *
FROM EMPLOYEES
ORDER BY SALARY, LAST_NAME;
   
--Q18. Seo라는 사람의 부서명을 출력하세요.
--A.
SELECT departments.department_name
FROM EMPLOYEES,DEPARTMENTS
WHERE employees.department_id=departments.department_id
AND LAST_NAME='Seo';

--Q19. LMEMBERS 데이터에서 고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성한 후 CUSTDEMO 테이블과 
--고객번호를 기준으로 결합하여 출력하세요.
--A.

CREATE TABLE CUSPUR
AS SELECT CUSTNO 고객번호, SUM(PURAMT) "구매급액 합계"
FROM PURPRD
GROUP BY CUSTNO
ORDER BY CUSTNO;

SELECT *
FROM CUSPUR,DEMO
WHERE cuspur."고객번호"=demo.custno;


--Q20.PURPRD 테이블로 부터 아래 사항을 수행하세요.
-- 2년간 구매금액을 연간 단위로 분리하여 고객별, 제휴사별로 구매액을 표시하는 AMT_14, AMT_15 테이블 2개를 생성 (출력내용 : 고객번호, 제휴사, SUM(구매금액) 구매금액)
--AMT14와 AMT15 2개 테이블을 고객번호와 제휴사를 기준으로 FULL OUTER JOIN 적용하여 결합한 AMT_YEAR_FOJ 테이블 생성
--14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력(단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함)
--A.
CREATE TABLE AMT_14
AS SELECT CUSTNO 고객번호, ASSO 제휴사, SUM(case when purdate <= '20141231' then puramt end) "2014 구매금액"
FROM PURPRD 
GROUP BY CUSTNO,ASSO
ORDER BY CUSTNO;

CREATE TABLE AMT_15
AS SELECT CUSTNO 고객번호, ASSO 제휴사, SUM(case when purdate <= '20151231'  
                                            AND purdate > '20141231' then puramt end) "2015 구매금액"
FROM PURPRD 
GROUP BY CUSTNO,ASSO
ORDER BY CUSTNO;

DROP TABLE AMT_15;

CREATE TABLE AMT_14_1
AS SELECT CUSTNO 고객번호, ASSO 제휴사, SUM(case when purdate <= '20141231' then puramt end) "2014 구매금액"
FROM PURPRD 
GROUP BY CUSTNO,ASSO
ORDER BY CUSTNO;

CREATE TABLE AMT_15
AS SELECT CUSTNO 고객번호, ASSO 제휴사, SUM(case when purdate <= '20151231'  
                                            AND purdate > '20141231' then puramt end) "2015 구매금액"
FROM PURPRD 
GROUP BY CUSTNO,ASSO
ORDER BY CUSTNO;

DROP TABLE AMT_15;
--Q(BONUS). HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요. (예 : 부서별 평균 SALARY 순위)
--A.
SELECT E.department_id 부서id,d.department_name 부서이름, ROUND(AVG(E.SALARY),0) "부서별 급여 평균", RANK() OVER (ORDER BY ROUND(AVG(E.SALARY),0) DESC) 순위
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.department_id=D.department_id
GROUP BY E.department_id, d.department_name
ORDER BY ROUND(AVG(E.SALARY),0) DESC;

--답
CREATE TABLE AMT_YEAR_FOJ
AS SELECT A4.고객번호, A4.제휴사, A4."2014 구매금액" 구매14, A5."2015 구매금액" 구매15
FROM AMT_14 A4 FULL OUTER JOIN AMT_15 A5
ON (A4.고객번호=A5.고객번호 AND A4.제휴사=A5.제휴사);

SELECT * FROM AMT_YEAR_FOJ;
DROP TABLE AMT_YEAR_FOJ;

CREATE TABLE AMT_YEAR_FOJ    
    SELECT NVL(A.고객번호,B.고객번호) 고객번호, NVL(A.제휴사,B.제휴사) 제휴사, NVL(A."2014 구매금액",0) AMT_14, NVL(B."2015 구매금액",0) AMT_15
    FROM AMT_14 A FULL OUTER JOIN AMT_15 B ON A.고객번호=B.고객번호 AND A.제휴사=B.제휴사;


SELECT TRUNC(AVG(구매14),0) "구매평균_14", TRUNC(AVG(구매15)) "구매평균_15"
FROM AMT_YEAR_FOJ;

SELECT *
FROM AMT_YEAR_FOJ;

--제휴사별 구매 총액 비교
SELECT 제휴사,SUM(구매14) "14년도 구매 총액",SUM(구매15) "15년도 구매 총액"
FROM AMT_YEAR_FOJ
GROUP BY 제휴사
ORDER BY 제휴사;

