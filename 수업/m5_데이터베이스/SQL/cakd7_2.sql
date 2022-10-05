SELECT * FROM channel;
SELECT * FROM competitor;
SELECT * FROM demo;
SELECT * FROM member;
SELECT * FROM prodcl;
SELECT * FROM purprd;



--과제_1004_8. Lmembers 데이터를 고객별로 속성(성별, 나이, 거주지역), 구매합계(반기별), 평균구매(반기별), 구매빈도(반기별)를 출력

--고객별로 속성(성별, 나이, 거주지역)
SELECT custno 고객번호, gender 성별, age 나이, area 거주지역
FROM demo
ORDER BY custno;

--성별+나이 그룹, 카운트
SELECT gender 성별, age 나이, COUNT(age) 카운트
FROM demo
GROUP BY gender, age
ORDER BY gender;

--구매합계(년도별), 평균구매(년도별), 구매빈도(년도별)
SELECT SUBSTR(purdate,1,4) 년도별, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY SUBSTR(purdate,1,4)
ORDER BY SUBSTR(purdate,1,4);

--구매합계(월별), 평균구매(월별), 구매빈도(월별)
SELECT SUBSTR(purdate,1,6) 월별, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY SUBSTR(purdate,1,6)
ORDER BY SUBSTR(purdate,1,6);

--구매합계(분기별), 평균구매(분기별), 구매빈도(분기별)
SELECT SUBSTR(purdate,1,4) 년도, CEIL(SUBSTR(purdate,5,2)/3) 분기, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/3)
ORDER BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/3);

--구매합계(반기별), 평균구매(반기별), 구매빈도(반기별)
SELECT SUBSTR(purdate,1,4) 년도, CEIL(SUBSTR(purdate,5,2)/6) 분기, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/6)
ORDER BY SUBSTR(purdate,1,4), CEIL(SUBSTR(purdate,5,2)/6);



--채널+이용횟수
SELECT asso 제휴사, SUM(freq) "이용횟수 합"
FROM channel
GROUP BY asso
ORDER BY SUM(freq) DESC;

--프로덕트 : 제일 많이 이용한 제휴사 조회
SELECT asso, COUNT(*)
FROM prodcl
GROUP BY asso
ORDER BY COUNT(*) DESC;

--멤버십 : 가입수가 많은 달 순서로 정렬
SELECT mname,joinmonth,  COUNT(*)
FROM member
GROUP BY mname,joinmonth
ORDER BY COUNT(*) DESC;

--멤버십 : 가입수가 많은 달 순서로 정렬
SELECT mname,  COUNT(*)
FROM member
GROUP BY mname
ORDER BY mname,COUNT(*) DESC;



--고객분류기준 정하기
SELECT RNO,CUSTNO,PURDATE,SUM(PURAMT)
FROM purprd
GROUP BY RNO,CUSTNO,PURDATE
ORDER BY CUSTNO ASC, PURDATE DESC;

SELECT CUSTNO 고객번호, SUBSTR(purdate,1,6) 월별, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY CUSTNO,SUBSTR(purdate,1,6)
ORDER BY CUSTNO,SUBSTR(purdate,1,6);

-- 빈도수 기준 : 꾸준하게 구매한 충성 고객(최소 2달에 한번) / 빈도수가 줄어든 고객 / 빈도수가 늘어난 고객
-- 구매합계 기준 : 고가 / 중가 / 저가

--고객별 구매빈도
SELECT CUSTNO 고객번호, SUM(puramt) 구매합계, ROUND(AVG(puramt),0) 평균구매, COUNT(puramt) 구매빈도
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;

--고객별 평균 구매 단가 : 구매합계 / 구매빈도
SELECT CUSTNO 고객번호, SUM(puramt) 구매합계, COUNT(puramt) 구매빈도, ROUND((SUM(puramt)/COUNT(puramt)),0) 평균구매단가
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;

--고객별 첫 구매일
SELECT CUSTNO 고객번호, TO_DATE(MIN(purdate)) 첫구매일
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;

--고객별 마지막 구매일
SELECT CUSTNO 고객번호, TO_DATE(MAX(purdate)) 마지막구매일
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;


--CLTV : 평균 구매 단가 * 구매 빈도 * 계속 구매 기간
SELECT CUSTNO 고객번호, ROUND((SUM(puramt)/COUNT(puramt)),0) 평균구매단가, COUNT(puramt) 구매빈도, TO_DATE(MAX((purdate)))-TO_DATE(MIN((purdate))) 계속구매기간,
       (ROUND((SUM(puramt)/COUNT(puramt)),0) * COUNT(puramt) * ((TO_DATE(MAX((purdate))))-(TO_DATE(MIN((purdate)))))) CLTV
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;

--CLTV PERCENT(%) 구하기
SELECT CUSTNO 고객번호, ROUND((SUM(puramt)/COUNT(puramt)),0) 평균구매단가, COUNT(puramt) 구매빈도, TO_DATE(MAX((purdate)))-TO_DATE(MIN((purdate))) 계속구매기간,
       (ROUND((SUM(puramt)/COUNT(puramt)),0) * COUNT(puramt) * ((TO_DATE(MAX(purdate)))-(TO_DATE(MIN((purdate)))))) CLTV,
       PERCENT_RANK() OVER ((ORDER BY CLTV DESC) as per_rank) CLTV_RANK;
FROM purprd
GROUP BY CUSTNO
ORDER BY CUSTNO;

