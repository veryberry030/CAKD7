-- 도서 테이블
SELECT * FROM book;
SELECT bookname, price FROM book;
SELECT publisher FROM book;

--Q. 중복 제거 DISTINCT
SELECT DISTINCT publisher FROM book;

--Q. 가격이 10,000원 이하인 도서 검색
SELECT * FROM book
WHERE price<10000;

--Q. 가격이 10000원 이상 20000 이하인 도서 검색
SELECT * FROM book
WHERE price>=10000 AND price<=20000;

SELECT * FROM book
WHERE price BETWEEN 10000 AND 20000;

--Q. 출판사가 굿스포츠 혹은 대한미디어인 도서를 검색
SELECT * FROM book
WHERE  publisher = '굿스포츠' OR  publisher = '대한미디어';

SELECT * FROM book
WHERE  publisher IN ('굿스포츠','대한미디어');

--Q. 출판사가 굿스포츠 혹은 대한미디어가 아닌 도서를 검색
SELECT * FROM book
WHERE  publisher != '굿스포츠' AND  publisher != '대한미디어';

SELECT * FROM book
WHERE  publisher <> '굿스포츠' AND  publisher <> '대한미디어';

SELECT * FROM book
WHERE  publisher NOT IN ('굿스포츠','대한미디어');

--Q. 도서 이름에 축구의 역사 가 들어있는 도서를 검색
SELECT * FROM book
WHERE  bookname LIKE '축구의 역사';

--Q. 도서 이름에 '축구' 가 들어있는 도서와 출판사를 검색
SELECT bookname,publisher FROM book
WHERE  bookname LIKE '%축구%';

--Q. 축구에 관한 도서 중 가격이 20,000원 이상인 도서 검색
SELECT bookname FROM book
WHERE  bookname LIKE '%축구%' AND price>=20000;

-- 정렬
SELECT * FROM book
ORDER BY bookname;

--Q. 내림차순으로 정렬
SELECT * FROM book
ORDER BY bookname DESC;

--Q. 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색
SELECT * FROM book
ORDER BY price, bookname;

--Q. 도서를 가격의 내림차순으로 검색. 만약 가격이 같다면 출판사의 오름차순으로 출력
SELECT * FROM book
ORDER BY price DESC, publisher ASC;

--주문 테이블
SELECT * FROM orders;

-- SUM 이용 : 세일가격의 합계
SELECT SUM(saleprice)
FROM orders;

--Q. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오
SELECT SUM(saleprice)
FROM orders
WHERE custid = 2;

--Q. saleprice의 합계(TOTAL), AVG, MIN, MAX 출력
SELECT SUM(saleprice) as "TOTAL",
AVG(saleprice) as AVG, MIN(saleprice) as MIN,
MAX(saleprice) as MAX
FROM orders;

-- COUNT
SELECT COUNT(*)
FROM orders;

-- 고객별로 도서수량과 판매액
SELECT custid, COUNT(*) AS "도서수량", SUM(saleprice) AS "총 판매액"
FROM orders
GROUP BY custid;

--[과제_0930_1]가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하세요.
-- 단, 두권 이상 구매한 고객만 구하세요.
SELECT custid, COUNT(*) AS 도서수량
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

--Q. 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 출력
SELECT *
FROM customer,orders
WHERE customer.custid = orders.custid
ORDER BY customer.custid;

--Q. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
SELECT customer.name, orders.saleprice
FROM customer,orders
WHERE customer.custid = orders.custid;

--Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객별로 정렬
SELECT customer.custid, SUM(orders.saleprice) AS "총 판매액"
FROM customer,orders
WHERE customer.custid = orders.custid
GROUP BY customer.custid
ORDER BY customer.custid;

--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하세요
SELECT customer.name, book.bookname
FROM orders,book,customer
WHERE orders.bookid = book.bookid AND customer.custid = orders.custid;

SELECT C.name, B.bookname
FROM orders O,book B,customer C
WHERE O.bookid = B.bookid AND C.custid = O.custid;

--Q. 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하세요
SELECT customer.name, book.bookname
FROM orders,book,customer
WHERE orders.bookid = book.bookid AND customer.custid = orders.custid
                                  AND orders.saleprice=20000;

--Q. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하세요
SELECT customer.name, NVL(orders.saleprice,0) as 판매가격 
FROM customer 
LEFT OUTER JOIN orders on customer.custid=orders.custid;

SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE c.custid = o.custid(+);



-- SUB QUERY
--Q. 가장 비싼 도서의 이름을 출력
SELECT bookname
FROM book
WHERE price = (SELECT MAX(price) FROM book);

--[과제_0930_2] 도서를 구매한 적이 있는 고객의 이름을 검색
SELECT name 
FROM customer 
WHERE custid IN (SELECT custid FROM Orders);

--[과제_0930_3] 대한 미디어에서 출판한 도서를 구매한 고객의 이름을 출력
SELECT name 
FROM Customer 
WHERE custid IN (SELECT custid 
                 FROM Orders
                 WHERE bookid IN (SELECT bookid 
                                  FROM Book 
                                  WHERE publisher = '대한미디어'));

--[과제_0930_4] 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 출력
SELECT bookname,publisher
FROM book
WHERE price > (SELECT AVG(price) FROM book)
GROUP BY bookname,publisher;

--[과제_0930_5] 도서를 주문하지 않은 고객의 이름을 출력
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

--[과제_0930_6] 주문이 있는 고객의 이름과 주소를 출력
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

--과제_1004_1. newbook 테이블의 isbn 속성을 삭제하세요.
ALTER TABLE newbook DROP COLUMN isbn;

--과제_1004_2. newbook 테이블의 기본키를 삭제한 후 bookid 속성을 기본키로 변경하세요.
ALTER TABLE newbook DROP PRIMARY KEY;

--과제_1004_3. newbook 테이블을 삭제하세요.
DROP TABLE newbook;

--
SELECT * FROM customer;

--Q. customer 테이블에서 고객 번호가 5 인 고객의 주소를 "대한민국 부산"으로 변경
UPDATE customer
SET address = '대한민국 부산'
WHERE custid=5;

--Q. customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경
UPDATE customer
SET address = (SELECT address FROM customer WHERE name='김연아')
WHERE custid=5;

--Q. customer 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인
DELETE customer
SET address='대한민국 부산'
WHERE custid=5;