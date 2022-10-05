-- ���� ���̺�
SELECT * FROM book;
SELECT bookname, price FROM book;
SELECT publisher FROM book;

--Q. �ߺ� ���� DISTINCT
SELECT DISTINCT publisher FROM book;

--Q. ������ 10,000�� ������ ���� �˻�
SELECT * FROM book
WHERE price<10000;

--Q. ������ 10000�� �̻� 20000 ������ ���� �˻�
SELECT * FROM book
WHERE price>=10000 AND price<=20000;

SELECT * FROM book
WHERE price BETWEEN 10000 AND 20000;

--Q. ���ǻ簡 �½����� Ȥ�� ���ѹ̵���� ������ �˻�
SELECT * FROM book
WHERE  publisher = '�½�����' OR  publisher = '���ѹ̵��';

SELECT * FROM book
WHERE  publisher IN ('�½�����','���ѹ̵��');

--Q. ���ǻ簡 �½����� Ȥ�� ���ѹ̵� �ƴ� ������ �˻�
SELECT * FROM book
WHERE  publisher != '�½�����' AND  publisher != '���ѹ̵��';

SELECT * FROM book
WHERE  publisher <> '�½�����' AND  publisher <> '���ѹ̵��';

SELECT * FROM book
WHERE  publisher NOT IN ('�½�����','���ѹ̵��');

--Q. ���� �̸��� �౸�� ���� �� ����ִ� ������ �˻�
SELECT * FROM book
WHERE  bookname LIKE '�౸�� ����';

--Q. ���� �̸��� '�౸' �� ����ִ� ������ ���ǻ縦 �˻�
SELECT bookname,publisher FROM book
WHERE  bookname LIKE '%�౸%';

--Q. �౸�� ���� ���� �� ������ 20,000�� �̻��� ���� �˻�
SELECT bookname FROM book
WHERE  bookname LIKE '%�౸%' AND price>=20000;

-- ����
SELECT * FROM book
ORDER BY bookname;

--Q. ������������ ����
SELECT * FROM book
ORDER BY bookname DESC;

--Q. ������ ���ݼ����� �˻��ϰ� ������ ������ �̸������� �˻�
SELECT * FROM book
ORDER BY price, bookname;

--Q. ������ ������ ������������ �˻�. ���� ������ ���ٸ� ���ǻ��� ������������ ���
SELECT * FROM book
ORDER BY price DESC, publisher ASC;

--�ֹ� ���̺�
SELECT * FROM orders;

-- SUM �̿� : ���ϰ����� �հ�
SELECT SUM(saleprice)
FROM orders;

--Q. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�
SELECT SUM(saleprice)
FROM orders
WHERE custid = 2;

--Q. saleprice�� �հ�(TOTAL), AVG, MIN, MAX ���
SELECT SUM(saleprice) as "TOTAL",
AVG(saleprice) as AVG, MIN(saleprice) as MIN,
MAX(saleprice) as MAX
FROM orders;

-- COUNT
SELECT COUNT(*)
FROM orders;

-- ������ ���������� �Ǹž�
SELECT custid, COUNT(*) AS "��������", SUM(saleprice) AS "�� �Ǹž�"
FROM orders
GROUP BY custid;

--[����_0930_1]������ 8000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���ϼ���.
-- ��, �α� �̻� ������ ���� ���ϼ���.
SELECT custid, COUNT(*) AS ��������
FROM orders
WHERE saleprice>=8000
GROUP BY custid
HAVING COUNT(*)>=2;

-- join
SELECT * FROM customer;
SELECT * FROM orders;

SELECT *
FROM customer,orders
WHERE customer.custid = orders.custid;

--Q. ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���
SELECT *
FROM customer,orders
WHERE customer.custid = orders.custid
ORDER BY customer.custid;

--Q. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻�
SELECT customer.name, orders.saleprice
FROM customer,orders
WHERE customer.custid = orders.custid;

--Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ� ������ ����
SELECT customer.custid, SUM(orders.saleprice) AS "�� �Ǹž�"
FROM customer,orders
WHERE customer.custid = orders.custid
GROUP BY customer.custid
ORDER BY customer.custid;

--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���ϼ���
SELECT customer.name, book.bookname
FROM orders,book,customer
WHERE orders.bookid = book.bookid AND customer.custid = orders.custid;

SELECT C.name, B.bookname
FROM orders O,book B,customer C
WHERE O.bookid = B.bookid AND C.custid = O.custid;

--Q. ������ 20000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���ϼ���
SELECT customer.name, book.bookname
FROM orders,book,customer
WHERE orders.bookid = book.bookid AND customer.custid = orders.custid
                                  AND orders.saleprice=20000;

--Q. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���ϼ���
SELECT customer.name, NVL(orders.saleprice,0) as �ǸŰ��� 
FROM customer 
LEFT OUTER JOIN orders on customer.custid=orders.custid;

SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE c.custid = o.custid(+);



-- SUB QUERY
--Q. ���� ��� ������ �̸��� ���
SELECT bookname
FROM book
WHERE price = (SELECT MAX(price) FROM book);

--[����_0930_2] ������ ������ ���� �ִ� ���� �̸��� �˻�
SELECT name 
FROM customer 
WHERE custid IN (SELECT custid FROM Orders);

--[����_0930_3] ���� �̵��� ������ ������ ������ ���� �̸��� ���
SELECT name 
FROM Customer 
WHERE custid IN (SELECT custid 
                 FROM Orders
                 WHERE bookid IN (SELECT bookid 
                                  FROM Book 
                                  WHERE publisher = '���ѹ̵��'));

--[����_0930_4] ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���
SELECT bookname,publisher
FROM book
WHERE price > (SELECT AVG(price) FROM book)
GROUP BY bookname,publisher;

--[����_0930_5] ������ �ֹ����� ���� ���� �̸��� ���
SELECT  name
FROM customer
WHERE name NOT IN(
    SELECT customer.name
    FROM customer,orders
    WHERE orders.custid=customer.custid); 

SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders);

--[����_0930_6] �ֹ��� �ִ� ���� �̸��� �ּҸ� ���
SELECT  name
FROM customer
WHERE name IN(
    SELECT customer.name
    FROM customer,orders
    WHERE orders.custid=customer.custid); 




--DDL
CREATE TABLE newbook(
bookid NUMBER,
bookname VARCHAR2(20) NOT NULL,
publisher VARCHAR2(20) UNIQUE,
price NUMBER DEFAULT 10000 CHECK(price>1000),
PRIMARY KEY (bookid)
);

DESC newbook;

DROP TABLE newbook;

CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30)
);

CREATE TABLE neworders(
orderid NUMBER PRIMARY KEY,
custid NUMBER NOT NULL,
bookid NUMBER NOT NULL,
saleprice NUMBER NOT NULL,
orderdate DATE
);

CREATE TABLE newbook(
bookid NUMBER PRIMARY KEY,
bookname VARCHAR2(20) NOT NULL,
publisher VARCHAR2(20) NOT NULL,
price NUMBER DEFAULT 10000 CHECK(price>1000)
);

DESC newbook;
ALTER TABLE newbook ADD isbn VARCHAR2(15);

--����_1004_1. newbook ���̺��� isbn �Ӽ��� �����ϼ���.
ALTER TABLE newbook DROP COLUMN isbn;

--����_1004_2. newbook ���̺��� �⺻Ű�� ������ �� bookid �Ӽ��� �⺻Ű�� �����ϼ���.
ALTER TABLE newbook DROP PRIMARY KEY;

--����_1004_3. newbook ���̺��� �����ϼ���.
DROP TABLE newbook;

--
SELECT * FROM customer;

--Q. customer ���̺��� �� ��ȣ�� 5 �� ���� �ּҸ� "���ѹα� �λ�"���� ����
UPDATE customer
SET address = '���ѹα� �λ�'
WHERE custid=5;

--Q. customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� ����
UPDATE customer
SET address = (SELECT address FROM customer WHERE name='�迬��')
WHERE custid=5;

--Q. customer ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ��
DELETE customer
SET address='���ѹα� �λ�'
WHERE custid=5;