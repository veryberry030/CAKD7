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
--����_1005_2. �̹����� ������ ��ȯ�ϴ� �Լ��� ����Ͽ� ������ ���
--����_1005_3. EMPLOYEES ���̺��� ä���ϰ� ����������� �ټӿ����� ���
--����_1005_4. �Ի��� 6���� �� ù��° �������� LAST_NAME���� ���
--����_1005_5. JOB_ID���� �����հ� ������� �ְ��� �������� ���, �� ��տ����� 5000 �̻��� ��츸 �����Ͽ� ������������ ����
