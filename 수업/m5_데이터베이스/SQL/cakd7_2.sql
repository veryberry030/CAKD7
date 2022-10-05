SELECT * FROM channel;
SELECT * FROM competitor;
SELECT * FROM demo;
SELECT * FROM member;
SELECT * FROM prodcl;
SELECT * FROM purprd;



--����_1004_8. Lmembers �����͸� ������ �Ӽ�(����, ����, ��������), �����հ�(�ݱ⺰), ��ձ���(�ݱ⺰), ���ź�(�ݱ⺰)�� ���

--������ �Ӽ�(����, ����, ��������)
SELECT custno ����ȣ, gender ����, age ����, area ��������
FROM demo
ORDER BY custno;

--����+���� �׷�, ī��Ʈ
SELECT gender ����, age ����, COUNT(age) ī��Ʈ
FROM demo
GROUP BY gender, age
ORDER BY gender;

--�����հ�(�⵵��), ��ձ���(�⵵��), ���ź�(�⵵��)
SELECT SUBSTR(purdate,1,4) �⵵��, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY SUBSTR(purdate,1,4)
ORDER BY SUBSTR(purdate,1,4);

--�����հ�(����), ��ձ���(����), ���ź�(����)
SELECT SUBSTR(purdate,1,6) ����, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY SUBSTR(purdate,1,6)
ORDER BY SUBSTR(purdate,1,6);

--�����հ�(�б⺰), ��ձ���(�б⺰), ���ź�(�б⺰)
SELECT SUBSTR(purdate,1,4) �⵵, CEIL(SUBSTR(purdate,5,2)/3) �б�, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/3)
ORDER BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/3);

--�����հ�(�ݱ⺰), ��ձ���(�ݱ⺰), ���ź�(�ݱ⺰)
SELECT SUBSTR(purdate,1,4) �⵵, CEIL(SUBSTR(purdate,5,2)/6) �б�, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/6)
ORDER BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/6);



--ä��+�̿�Ƚ��
SELECT asso ���޻�, SUM(freq) "�̿�Ƚ�� ��"
FROM channel
GROUP BY asso
ORDER BY SUM(freq) DESC;

--���δ�Ʈ : ���� ���� �̿��� ���޻� ��ȸ
SELECT asso, COUNT(*)
FROM prodcl
GROUP BY asso
ORDER BY COUNT(*) DESC;

--����� : ���Լ��� ���� �� ������ ����
SELECT mname,joinmonth,  COUNT(*)
FROM member
GROUP BY mname,joinmonth
ORDER BY COUNT(*) DESC;

--����� : ���Լ��� ���� �� ������ ����
SELECT mname,  COUNT(*)
FROM member
GROUP BY mname
ORDER BY mname,COUNT(*) DESC;



--���з����� ���ϱ�
SELECT RNO,CUSTNO,PURDATE,SUM(PURAMT)
FROM purprd
GROUP BY RNO,CUSTNO,PURDATE
ORDER BY CUSTNO ASC, PURDATE DESC;

SELECT CUSTNO ����ȣ, SUBSTR(purdate,1,6) ����, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY CUSTNO,SUBSTR(purdate,1,6)
ORDER BY CUSTNO,SUBSTR(purdate,1,6);

-- �󵵼� ���� : �����ϰ� ������ �漺 ��(�ּ� 2�޿� �ѹ�) / �󵵼��� �پ�� �� / �󵵼��� �þ ��
-- �����հ� ���� : �� / �߰� / ����

--���� ���ź�
SELECT CUSTNO ����ȣ, SUM(puramt) �����հ�, ROUND(AVG(puramt),0) ��ձ���, COUNT(puramt) ���ź�
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;

--���� ��� ���� �ܰ� : �����հ� / ���ź�
SELECT CUSTNO ����ȣ, SUM(puramt) �����հ�, COUNT(puramt) ���ź�, ROUND((SUM(puramt)/COUNT(puramt)),0) ��ձ��Ŵܰ�
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;

--���� ù ������
SELECT CUSTNO ����ȣ, TO_DATE(MIN(purdate)) ù������
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;

--���� ������ ������
SELECT CUSTNO ����ȣ, TO_DATE(MAX(purdate)) ������������
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;


--CLTV : ��� ���� �ܰ� * ���� �� * ��� ���� �Ⱓ
SELECT CUSTNO ����ȣ, ROUND((SUM(puramt)/COUNT(puramt)),0) ��ձ��Ŵܰ�, COUNT(puramt) ���ź�, TO_DATE(MAX((purdate)))-TO_DATE(MIN((purdate))) ��ӱ��űⰣ,
       (ROUND((SUM(puramt)/COUNT(puramt)),0) * COUNT(puramt) * ((TO_DATE(MAX((purdate))))-(TO_DATE(MIN((purdate)))))) CLTV
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;

--CLTV PERCENT(%) ���ϱ�
SELECT CUSTNO ����ȣ, ROUND((SUM(puramt)/COUNT(puramt)),0) ��ձ��Ŵܰ�, COUNT(puramt) ���ź�, TO_DATE(MAX((purdate)))-TO_DATE(MIN((purdate))) ��ӱ��űⰣ,
       (ROUND((SUM(puramt)/COUNT(puramt)),0) * COUNT(puramt) * ((TO_DATE(MAX(purdate)))-(TO_DATE(MIN((purdate)))))) CLTV,
       PERCENT_RANK() OVER ((ORDER BY CLTV DESC) as per_rank) CLTV_RANK;
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;

