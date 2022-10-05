SELECT * FROM competitor;

SELECT * FROM channel;

SELECT * FROM demo;

SELECT * FROM member;

SELECT * FROM prodcl;

SELECT * FROM purprd;


SELECT mcl FROM prodcl;

SELECT purtime 
FROM purprd
GROUP BY purtime
ORDER BY puramt;


