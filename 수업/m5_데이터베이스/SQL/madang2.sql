--CALCULATOR

SELECT ABS(-78),ABS(+78)
FROM dual;

SELECT ROUND(4.875,1)
FROM dual;

SELECT * FROM orders;
--Q. ���� ��� �ֹ� �ݾ��� ���ϼ���.
SELECT custid,AVG(saleprice)
FROM orders
GROUP BY custid;

SELECT C.name ,ROUND(avg(O.saleprice,-2))
FROM orders O,customer C
WHERE C.custid=O.custid
GROUP BY c.name;

SELECT * FROM book;

--Q. ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� �������, ������ ���
SELECT bookid,
REPLACE(bookname,'�߱�','��') bookname, publisher, price
FROM book;

SELECT bookname ����, length(bookname) ���ڼ�,
lengthb(bookname) AS ����Ʈ��
FROM book;

SELECT * FROM customer;
INSERT INTO customer VALUES(6, '�ڼ���', '���ѹα� ����', NULL);

--Q. ����_1004_4. customer ���̺��� ���� ���� ���� ����� ����̳� �Ǵ��� ���� �ο����� ���ϼ���.
SELECT SUBSTR(name,1,1) ��, COUNT(SUBSTR(name,1,1)) �ο���
FROM customer
GROUP BY SUBSTR(name,1,1);


SELECT * FROM orders;
--Q.�ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
SELECT orderid �ֹ���ȣ, orderdate �ֹ���, orderdate+10 Ȯ������
FROM orders;

--����_1004_5. 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���
--�ֹ����� 2020-07-07 ȭ���� ����
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate, 'YYYY-MM-DD DAY') �ֹ���, custid ����ȣ, bookid ������ȣ
from orders
WHERE orderdate='20/07/07';

SELECT SYSDATE FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy/mm/dd hh24:mi:ss') SYSDATE1
FROM dual;

SELECT * FROM customer;
--Q.�̸�, ��ȭ��ȣ�� ���Ե� ������� ���̼���. ��, ��ȭ��ȣ�� ���� ���� '����ó ����'���� ǥ���Ͽ� ���
SELECT name �̸�, NVL(phone,'����ó ����') ��ȭ��ȣ
FROM customer;

--SELECT COALESCE(null,null,'third value','fourth value'); ����° ���� null�� �ƴ� ù��° ���̱� ������ ����° ���� ��ȯ
SELECT NAME �̸�, PHONE, COALESCE(PHONE,'����ó ����') ��ȭ��ȣ
FROM customer;

SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM <= 3;

--Q. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���
SELECT orderid �ֹ���ȣ, saleprice �ݾ�
FROM orders
WHERE saleprice < (SELECT AVG(saleprice) FROM orders);

--Q.�� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���
SELECT orderid �ֹ���ȣ, custid ����ȣ, saleprice �ݾ�
FROM orders
WHERE saleprice > (SELECT AVG(saleprice) FROM orders);

--����_1004_5. ���ѹα��� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���
SELECT SUBSTR(address,1,4),SUM(saleprice)
FROM orders, customer
WHERE orders.custid = customer.custid 
AND SUBSTR(address,1,4)='���ѹα�'
GROUP BY SUBSTR(address,1,4);

--����_1004_6. 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���
SELECT orderid �ֹ���ȣ, saleprice �ݾ�
FROM orders
WHERE saleprice > (SELECT MAX(saleprice) FROM orders WHERE orderid = 3);

--����_1004_7. ����ȣ�� 2 ������ ���� �Ǹž��� ��� (��, ���̸��� ���� �Ǹž� ����)
SELECT name ���̸�, SUM(saleprice) �Ǹž�
FROM orders, customer
WHERE orders.custid = customer.custid
AND ROWNUM <= 2
GROUP BY name;

--����_1004_8. Lmembers �����͸� ������ �Ӽ�(����, ����, ��������), �����հ�(�ݱ⺰), ��ձ���(�ݱ⺰), ���ź�(�ݱ⺰)�� ���

