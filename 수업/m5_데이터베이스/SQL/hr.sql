SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM JOBS;
SELECT * FROM LOCATIONS;
SELECT * FROM REGIONS;

--���ο� �÷� ������ֱ�
SELECT LAST_NAME, 'is a' job_id FROM EMPLOYEES;

--�÷� �� �ٿ��� ���ο� �÷� ������ֱ�
SELECT LAST_NAME || ' is a ' ||job_id AS EXPLAIN FROM EMPLOYEES;

--NULL ���� �ֵ�
SELECT * FROM EMPLOYEES
WHERE commission_pct IS NULL;

--NULL ���� �ƴ� �ֵ�
SELECT * FROM EMPLOYEES
WHERE commission_pct IS NOT NULL;

--Q.EMPLOYEES ���̺��� COMMISSION_PCT NULL�� ������ ���
SELECT COUNT(*)-COUNT(COMMISSION_PCT) NULL����
FROM EMPLOYEES;

--Q.EMPLOYEES ���̺��� EMPLOYEE_ID�� Ȧ���� �͸� ���
SELECT * FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID,2)=1;

--TRUNC : ����
SELECT LAST_NAME, TRUNC(SALARY/12,2) ����
FROM EMPLOYEES;

--WIDTH_BUCKET(������, �ּҰ�, �ִ밪, BUCKET����)
--0~100�� 10���� ������ �� �������� ����
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

--LPAD ����ִ� �ڸ��� ���ʺ��� ä���
SELECT LPAD('Hello World',20,'#') FROM DUAL;

--RPAD ����ִ� �ڸ��� �����ʺ��� ä���
SELECT RPAD('Hello World',20,'#') FROM DUAL;

SELECT LAST_NAME, TRIM('A' FROM LAST_NAME) A���� FROM EMPLOYEES;

SELECT LTRIM('aaaHello Worldaaa','a') FROM DUAL;
SELECT RTRIM('aaaHello Worldaaa','a') FROM DUAL;
SELECT TRIM(' Hello World ') FROM DUAL;
SELECT LTRIM(' Hello World ') FROM DUAL;
SELECT RTRIM(' Hello World ') FROM DUAL;

SELECT SYSDATE FROM DUAL;

SELECT * FROM EMPLOYEES;

--�ټӳ�� ���ϱ�
SELECT LAST_NAME, TRUNC((SYSDATE-HIRE_DATE)/365,0) �ټӳ��
FROM EMPLOYEES;

--����_1005_1. EMPLOYEES ���̺��� ä���Ͽ� 6������ �߰��� ��¥�� LAST_NAME�� ���� ���
SELECT LAST_NAME,HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) FROM EMPLOYEES;

--����_1005_2. �̹����� ������ ��ȯ�ϴ� �Լ��� ����Ͽ� ������ ���
SELECT LAST_NAME,HIRE_DATE, LAST_DAY(HIRE_DATE) FROM EMPLOYEES;

--����_1005_3. EMPLOYEES ���̺��� ä���ϰ� ����������� �ټӿ����� ���
SELECT LAST_NAME,TRUNC((MONTHS_BETWEEN(SYSDATE,HIRE_DATE)),0) �ټӿ��� FROM EMPLOYEES;

--����_1005_4. �Ի��� 6���� �� ù��° �������� LAST_NAME���� ���
SELECT LAST_NAME,NEXT_DAY(ADD_MONTHS(HIRE_DATE,6),'��') FROM EMPLOYEES;

--����_1005_5. JOB_ID���� �����հ� ������� �ְ��� �������� ���, �� ��տ����� 5000 �̻��� ��츸 �����Ͽ� ������������ ����
SELECT JOB_ID, SUM(SALARY) �����հ�, AVG(SALARY) �������, MAX(SALARY) �ְ���, MIN(SALARY) ��������
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY)>=5000
ORDER BY JOB_ID DESC;

--����_1005_6. �����ȣ(EMPLOYEE_ID)�� 110�� ����� �μ����� ���
SELECT DEPARTMENT_NAME
FROM EMPLOYEES,DEPARTMENTS
WHERE employees.department_id = departments.department_id(+)
AND employees.employee_id=110;

--����_1005_7. ����� 120���� ������ ���, �̸�, ����(JOB_ID), ������(JOB_TITLE)�� ���
SELECT EMPLOYEES.EMPLOYEE_ID ���, EMPLOYEES.LAST_NAME �̸�, EMPLOYEES.JOB_ID ����, JOBS.JOB_TITLE ������
FROM EMPLOYEES,JOBS
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_ID(+)
AND EMPLOYEES.employee_id=120;

--����_1005_8. ���, �̸�, ������ ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
                --salary > 20000 then '��ǥ�̻�'
                --salary > 15000 then '�̻�' 
                --salary > 10000 then '����' 
                --salary > 5000 then '����' 
                --salary > 3000 then '�븮'
                --������ '���'
                
SELECT EMPLOYEE_ID ���, LAST_NAME �̸�, 
        CASE 
            WHEN salary > 20000 then '��ǥ�̻�'
            WHEN salary > 15000 then '�̻�'
            WHEN salary > 10000 then '����'
            WHEN salary > 5000 then '����'
            WHEN salary > 3000 then '�븮'
            ELSE '���' 
        END ����
FROM EMPLOYEES;

--����_1005_9. EMPLOYEES ���̺��� EMPLOYEE_ID �� SALARY�� �����ؼ� EMPLOYEE_SALARY ���̺��� �����Ͽ� ���
CREATE TABLE EMPLOYEE_SALARY AS SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES;

SELECT * FROM EMPLOYEE_SALARY;

--����_1005_10. EMPLOYEE_SALARY ���̺��� FIRST_NAME, LAST_NAME �÷��� �߰��� �� NAME���� �����Ͽ� ���
ALTER TABLE EMPLOYEE_SALARY ADD FIRST_NAME VARCHAR2(40);

ALTER TABLE EMPLOYEE_SALARY ADD LAST_NAME VARCHAR2(40);

SELECT * FROM EMPLOYEE_SALARY;

--����_1005_11. EMPLOYEE_SALARY ���̺��� EMPLOYEE_ID�� �⺻Ű�� �����ϰ� CONSTRAINT_NAME�� ES_PK�� ���� �� ���
ALTER TABLE EMPLOYEE_SALARY 
ADD CONSTRAINT ES_PK
PRIMARY KEY (EMPLOYEE_ID);

DESC EMPLOYEE_SALARY;

--����_1005_12. EMPLOYEE_SALARY ���̺��� EMPLOYEE_ID���� CONSTRAINT_NAME�� ���� �� ���� ���θ� Ȯ��
ALTER TABLE EMPLOYEE_SALARY
DROP CONSTRAINT ES_PK;