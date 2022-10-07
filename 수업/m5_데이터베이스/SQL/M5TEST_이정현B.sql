������ ��� AI ���� �ַ�� ������ ��������

������� : �����ͺ��̽� ���� �� Ȱ��

- ���� : 22.10.07
- ���� : ������B
- ���� : 95


�� HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)�� Ȱ���Ͽ� ���� �������� �����ϼ���.
--Q1. HR EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
--A.
SELECT LAST_NAME �̸�, SALARY ����, SALARY*1.1 "10% �λ�� ����"
FROM EMPLOYEES;
    
--Q2.  2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
--A.        
 SELECT *
 FROM EMPLOYEES
 WHERE SUBSTR(HIRE_DATE,1,2)=05;

--Q3. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
--A.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'SA_MAN' OR JOB_ID ='IT_PROG' OR JOB_ID = 'ST_MAN';
   
--Q4. manager_id �� 101���� 103�� ����� ���
--A.   	
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID BETWEEN 101 AND 103;

--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
--A.
SELECT LAST_NAME, HIRE_DATE, NEXT_DAY(ADD_MONTHS(HIRE_DATE,6),'��') "�Ի����� 6���� �� ù ��° ������"
FROM EMPLOYEES;


--Q6. EMPLOYEES ���̺��� EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((MONTHS_BETWEEN(SYSDATE,HIRE_DATE)),0) �ټӿ���
FROM EMPLOYEES
ORDER BY �ټӿ��� DESC;

--Q7. EMPLOYEES ���̺��� EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((SYSDATE-HIRE_DATE)/365,0) �ټӳ��
FROM EMPLOYEES
ORDER BY �ټӳ�� DESC;

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLOYEE_ID�� LAST_NAME�� ����ϼ���.
--A. 
SELECT EMPLOYEE_ID,LAST_NAME
FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID,2)=1;

--Q9. EMPLOYEES ���̺��� EMPLOYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
--A
SELECT EMPLOYEE_ID,LAST_NAME,TRUNC(SALARY/12,2) ����
FROM EMPLOYEES;

--Q10. EMPLOYEES ���̺��� EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰��� �Ŀ� ����ϼ���.
--2001�� 1�� 1�� â���Ͽ� ������� 20�Ⱓ ��ǿ� ȸ��� ������ �ټӳ���� ���� 30 ������� ������  ��޿� ���� 1000���� BONUS�� ����.
--�������� ����.    
--A.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((SYSDATE-HIRE_DATE)/365,0) �ټӳ��,
        ntile(30) over (order by TRUNC((SYSDATE-HIRE_DATE)/365,0) ASC) ���, 
        (ntile(30) over (order by TRUNC((SYSDATE-HIRE_DATE)/365,0) ASC))*1000 BONUS
FROM EMPLOYEES;

--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
--A.
SELECT COUNT(*) "commission_pct ��  Null�� ����"
FROM EMPLOYEES
WHERE commission_pct IS NULL;

--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
--A.
SELECT LAST_NAME, CASE WHEN department_id IS NULL THEN '����' END POSITION
FROM EMPLOYEES
WHERE department_id IS NULL;

--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
--A.
SELECT EMPLOYEES.LAST_NAME �̸�, EMPLOYEES.JOB_ID ����, JOBS.job_title ������
FROM EMPLOYEES,JOBS
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_ID 
AND EMPLOYEE_ID=120;

SELECT EMPLOYEES.LAST_NAME �̸�, EMPLOYEES.JOB_ID ����, JOBS.job_title ������
FROM EMPLOYEES
JOIN JOBS
ON EMPLOYEES.JOB_ID = JOBS.JOB_ID 
AND EMPLOYEE_ID=120;

--Q14.  employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
--A. 
SELECT (FIRST_NAME ||' '|| LAST_NAME) NAME
FROM EMPLOYEES;

--Q15. lmembers purprod ���̺�� ���� �ѱ��ž�, 2014 ���ž�, 2015 ���ž��� �ѹ��� ����ϼ���.
--A.
SELECT SUM(puramt) �ѱ��ž�, 
SUM(CASE WHEN purdate <= '20141231' THEN puramt END) "2014 ���ž�", 
SUM(CASE WHEN purdate > '20141231' AND purdate <= '20151231' THEN puramt END) "2015 ���ž�"
FROM purprd;

--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
--A.
SELECT *
FROM EMPLOYEES,DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
AND JOB_ID LIKE '%\_A%' ESCAPE '\';

--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
--A. 
SELECT *
FROM EMPLOYEES
ORDER BY SALARY, LAST_NAME;
   
--Q18. Seo��� ����� �μ����� ����ϼ���.
--A.
SELECT departments.department_name
FROM EMPLOYEES,DEPARTMENTS
WHERE employees.department_id=departments.department_id
AND LAST_NAME='Seo';

--Q19. LMEMBERS �����Ϳ��� ���� ���űݾ��� �հ踦 ���� CUSPUR ���̺��� ������ �� CUSTDEMO ���̺�� 
--����ȣ�� �������� �����Ͽ� ����ϼ���.
--A.

CREATE TABLE CUSPUR
AS SELECT CUSTNO ����ȣ, SUM(PURAMT) "���ű޾� �հ�"
FROM PURPRD
GROUP BY CUSTNO
ORDER BY CUSTNO;

SELECT *
FROM CUSPUR,DEMO
WHERE cuspur."����ȣ"=demo.custno;


--Q20.PURPRD ���̺�� ���� �Ʒ� ������ �����ϼ���.
-- 2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����, ���޻纰�� ���ž��� ǥ���ϴ� AMT_14, AMT_15 ���̺� 2���� ���� (��³��� : ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ�)
--AMT14�� AMT15 2�� ���̺��� ����ȣ�� ���޻縦 �������� FULL OUTER JOIN �����Ͽ� ������ AMT_YEAR_FOJ ���̺� ����
--14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� �÷��� �߰��Ͽ� ���(��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��)
--A.
CREATE TABLE AMT_14
AS SELECT CUSTNO ����ȣ, ASSO ���޻�, SUM(case when purdate <= '20141231' then puramt end) "2014 ���űݾ�"
FROM PURPRD 
GROUP BY CUSTNO,ASSO
ORDER BY CUSTNO;

CREATE TABLE AMT_15
AS SELECT CUSTNO ����ȣ, ASSO ���޻�, SUM(case when purdate <= '20151231'  
                                            AND purdate > '20141231' then puramt end) "2015 ���űݾ�"
FROM PURPRD 
GROUP BY CUSTNO,ASSO
ORDER BY CUSTNO;

DROP TABLE AMT_15;

CREATE TABLE AMT_14_1
AS SELECT CUSTNO ����ȣ, ASSO ���޻�, SUM(case when purdate <= '20141231' then puramt end) "2014 ���űݾ�"
FROM PURPRD 
GROUP BY CUSTNO,ASSO
ORDER BY CUSTNO;

CREATE TABLE AMT_15
AS SELECT CUSTNO ����ȣ, ASSO ���޻�, SUM(case when purdate <= '20151231'  
                                            AND purdate > '20141231' then puramt end) "2015 ���űݾ�"
FROM PURPRD 
GROUP BY CUSTNO,ASSO
ORDER BY CUSTNO;

DROP TABLE AMT_15;
--Q(BONUS). HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���. (�� : �μ��� ��� SALARY ����)
--A.
SELECT E.department_id �μ�id,d.department_name �μ��̸�, ROUND(AVG(E.SALARY),0) "�μ��� �޿� ���", RANK() OVER (ORDER BY ROUND(AVG(E.SALARY),0) DESC) ����
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.department_id=D.department_id
GROUP BY E.department_id, d.department_name
ORDER BY ROUND(AVG(E.SALARY),0) DESC;

--��
CREATE TABLE AMT_YEAR_FOJ
AS SELECT A4.����ȣ, A4.���޻�, A4."2014 ���űݾ�" ����14, A5."2015 ���űݾ�" ����15
FROM AMT_14 A4 FULL OUTER JOIN AMT_15 A5
ON (A4.����ȣ=A5.����ȣ AND A4.���޻�=A5.���޻�);

SELECT * FROM AMT_YEAR_FOJ;
DROP TABLE AMT_YEAR_FOJ;

CREATE TABLE AMT_YEAR_FOJ    
    SELECT NVL(A.����ȣ,B.����ȣ) ����ȣ, NVL(A.���޻�,B.���޻�) ���޻�, NVL(A."2014 ���űݾ�",0) AMT_14, NVL(B."2015 ���űݾ�",0) AMT_15
    FROM AMT_14 A FULL OUTER JOIN AMT_15 B ON A.����ȣ=B.����ȣ AND A.���޻�=B.���޻�;


SELECT TRUNC(AVG(����14),0) "�������_14", TRUNC(AVG(����15)) "�������_15"
FROM AMT_YEAR_FOJ;

SELECT *
FROM AMT_YEAR_FOJ;

--���޻纰 ���� �Ѿ� ��
SELECT ���޻�,SUM(����14) "14�⵵ ���� �Ѿ�",SUM(����15) "15�⵵ ���� �Ѿ�"
FROM AMT_YEAR_FOJ
GROUP BY ���޻�
ORDER BY ���޻�;

