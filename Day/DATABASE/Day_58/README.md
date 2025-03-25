# 01

> 테이블 추가
> 

```java
-- 기존 테이블 삭제
drop table buytbl;
drop table userTbl;

-- UserTbl 만들기
CREATE TABLE userTbl( -- 회원테이블
userID CHAR(8) NOT NULL PRIMARY KEY, -- 사용자아이디
name VARCHAR(10) NOT NULL, -- 이름
birthYear INT NOT NULL, -- 출생년도
addr NCHAR(2) NOT NULL, --지역(2글자만 입력, 경남,서울,경기..)
mobile1 CHAR(3), -- 휴대폰의 국번(011,016...)
mobile2 CHAR(8), -- 휴대폰의 나머지 전화번호
height SMALLINT, -- 키
mDate DATE --회원가입일
);

-- Buytbl 만들기
CREATE TABLE buyTbl( -- 회원 구매 테이블
num INT NOT NULL PRIMARY KEY, -- 순번(PK) 
userID CHAR(8) NOT NULL, --
prodName CHAR(15) NOT NULL, -- 물품명
groupName CHAR(15), -- 분류
price INT NOT NULL, -- 단가
amount SMALLINT NOT NULL, -- 수량
FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

-- Usertbl 값삽입
INSERT INTO userTbl VALUES('LSG','이승기',1987,'서울','011','1111111',182,'2008-8-8');
INSERT INTO userTbl VALUES('KBS','김범수',1979,'경남','011','2222222',173,'2012-4-4');
INSERT INTO userTbl VALUES('KKH','김경호',1971,'전남','019','3333333',177,'2007-7-7');
INSERT INTO userTbl VALUES('JYP','조용필',1950,'경기','011','4444444',166,'2009-4-4');
INSERT INTO userTbl VALUES('SSK','성시경',1979,'서울',NULL,NULL,186,'2013-12-12');
INSERT INTO userTbl VALUES('LJB','임재범',1963,'서울','016','6666666',182,'2009-9-9');
INSERT INTO userTbl VALUES('YJS','윤종신',1969,'경남',NULL,NULL,170,'2005-5-5');
INSERT INTO userTbl VALUES('EJW','은지원',1972,'경북','011','8888888',174,'2014-3-3');
INSERT INTO userTbl VALUES('JKW','조관우',1965,'경기','018','9999999',172,'2010-10-10');
INSERT INTO userTbl VALUES('BBK','바비킴',1973,'서울','010','0000000',176,'2013-5-5');

select * from usertbl;

-- Buytbl 값 삽입

INSERT INTO buyTbl VALUES(1,'KBS','운동화',NULL,30,2);
INSERT INTO buyTbl VALUES(2,'KBS','노트북','전자',1000,1);
INSERT INTO buyTbl VALUES(3,'JYP','모니터','전자',200,1);
INSERT INTO buyTbl VALUES(4,'BBK','모니터','전자',200,5);
INSERT INTO buyTbl VALUES(5,'KBS','청바지','의류',50,3);
INSERT INTO buyTbl VALUES(6,'BBK','메모리','전자',80,10);
INSERT INTO buyTbl VALUES(7,'SSK','책','서적',15,5);
INSERT INTO buyTbl VALUES(8,'EJW','책','서적',15,2);
INSERT INTO buyTbl VALUES(9,'EJW','청바지','의류',50,1);
INSERT INTO buyTbl VALUES(10,'BBK','운동화',NULL,30,2);
INSERT INTO buyTbl VALUES(11,'EJW','책','서적',15,1);
INSERT INTO buyTbl VALUES(12,'BBK','운동화',NULL,30,2);

-- buytbl 확인
select * from buytbl;

-- 테이블 조회(모든 테이블 확인, all_tables 라는 System View 사용)
select * from all_tables;

-- 테이블 조회(유저가 생성한 테이블 확인, user_tables 라는 System View 사용)
select * from user_tables;
```

---

> **SELECT문, WHERE절 GROUP BY 절**
> 

```java
-- 사용자별 구매 총액 계산
select userid, sum(price*amount) as 구매총액
from buytbl
group by userid;

-- 
select userid, count(*) as 구매횟수
from buytbl
group by userid;

-- 지역별 사용자 수 계산
SELECT addr, COUNT(*) AS 사용자수
FROM userTbl
GROUP BY addr;

-- 제품 그룹별 판매 금액 합계(!)
select * from buytbl;
SELECT groupName, SUM(price * amount) AS 판매액
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY groupName;

-- 출생년도 기준 사용자 수
SELECT birthYear, COUNT(*) AS 인원수
FROM userTbl
GROUP BY birthYear
ORDER BY birthYear;

-- 오름차순
SELECT Name , mDate FROM userTbl ORDER BY mDate asc;
SELECT Name , mDate FROM userTbl ORDER BY name;
-- 내림차순
SELECT Name , mDate FROM userTbl ORDER BY mDate desc;
-- 오름 + 내림
SELECT Name,height FROM userTbl ORDER BY height DESC , name ASC;

-- 서브쿼리
select * from
(select rownum as RN, usertbl. * from usertbl) where RN=2;

select * from (select rownum as RN, usertbl. * from usertbl)
where RN>=2 and RN <=4;

-- 널값 변경
-- COALESCE == NVL , CASE - IS NULL THEN
select
    case
        when groupName IS NULL THEN '미분류'
        else groupName
    end
    as 카테고리,sum(amount)
from buytbl
group by groupName

-- 문제 01
select addr, count(*)from userTbl group by addr;
-- 문제 02
select userID, sum(price * amount) as 총구매액 from buyTbl group by userID;
-- 문제 03 COALESCE == NVL
select ㅡ   (groupName, '미분류') as groupName, count(*) as 판매수량
from buyTbl group by groupName;
-- 문제 03 CASE - IS NULL THEN
select
    case
        when groupName IS NULL THEN '미분류'
        else groupName
    end
    as 카테고리,sum(amount)
from buytbl
group by groupName
-- 문제 04
select birthYear, avg(height)as 평균키 from userTbl group by birthYear;
-- 문제 05
select prodName, count(*) as "구매 횟수", sum (amount*price) as "총 구매액" from buyTbl
group by ProdName order by "구매 횟수" desc;
-- 문제 06
select NVL(mobile1,'미입력'), count(*) from usertbl group by mobile1;
-- 문제 07
SELECT u.addr, SUM(b.price * b.amount) AS 총구매액
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID
GROUP BY u.addr;
-- 문제 08
SELECT userID, COUNT(DISTINCT prodName) AS 제품종류수
FROM buyTbl
GROUP BY userID;
-- 문제 09
SELECT EXTRACT(YEAR FROM mDate) AS 가입연도, COUNT(*) AS 가입자수
FROM userTbl
GROUP BY EXTRACT(YEAR FROM mDate)
ORDER BY 가입연도;
-- 문제 10
SELECT round((2023 - u.birthYear),-1) as 연령대, sum(price) as 구매총액 
from buyTbl b JOIN userTbl u 
ON u.userID = b.userID group by round((2023 - u.birthYear),-1) 
order by 연령대 ;

```

---

> **HAVING절**
> 

```java
-- 구매 금액 합계가 100 이상인 사용자 조회
SELECT userID, SUM(price * amount) AS 총구매액
fROM buyTbl
-- WHERE SUM(price * amount) >= 1000
GROUP BY userID
HAVING SUM(price * amount)>=1000;

-- 평균 키가 175 이상인 지역 조회
SELECT addr, AVG(height) AS 평균키
FROM userTbl
GROUP BY addr
HAVING AVG(height)>=175;

-- 총 구매 횟수가 3회 이상이고 총 구매액이 100 이상인 사용자
SELECT userID,COUNT(*) AS 구매횟수, SUM(price * amount) AS 총구매액
FROM buyTbl
GROUP BY userID
HAVING  COUNT(*)>=3 AND SUM(price * amount) >= 100;

-- 사용자 지역별, 제품 그룹별 구매액 합계
select u.addr, b.groupname, sum(b.amount*b.price)
from usertbl u 
join buytbl b
on u.userid=b.userid
group by u.addr,b.groupname
order by sum(b.amount*b.price) desc;

-- 소계와 합계를 자동으로 계산해주는 함수입니다.
SELECT groupName, SUM(price * amount) AS 판매액
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY ROLLUP(groupName);

-- 모든 가능한 조합의 소계와 합계를 계산합니다.
SELECT groupName, prodName, SUM(price * amount) AS 판매액
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY CUBE(groupName, prodName);

--특정 그룹화 조합의 결과를 UNION ALL로 결합한 것과 같은 결과를 제공합니다.
--GROUPING SETS 사용 
SELECT groupName, prodName, SUM(price * amount) AS 판매액
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY GROUPING SETS((groupName), (prodName), ());
--UNION ALL 사용
select groupName, NULL as ProdName,sum(price *amount)
from buytbl 
where groupName IS NOT NULL
group by groupname

union all

select NULL as groupName,prodName, sum(price *amount)
from buytbl
where groupName is not null
group by prodName;

-- 문제 01
select userID, sum(price * amount)as "총 구매액" from buyTbl group by userID 
HAVING sum(price * amount)>=1000;
-- 문제 02
select addr,count(*) from usertbl group by addr Having count(*)>=2;
-- 문제 03
select prodname,avg(price*amount) from buytbl group by prodname 
having avg(price*amount)>=100;
-- 문제 04
select birthyear,avg(height) from userTbl group by birthyear 
having avg(height)>=175;
-- 문제 05
select userid,sum(amount) from buytbl group by userid having sum(amount)>=2;
-- 문제 06
select u.addr as 지역, sum(b.price * b.amount)as 총액 from userTbl u join buyTbl b 
on u.userid=b.userid group by u.addr having sum(b.price * b.amount)>=200;
-- 문제 07
select userid,count(*) as 구매횟수,sum(amount*price)as 총구매액 from buytbl group by userid 
having count(*)>=3 and sum(amount*price)>=500;
-- 문제 08
select * from(select addr,avg(height) as 평균키 from usertbl group by addr)
where 평균키 = (select max(avg(height)) as 평균키 from usertbl group by addr);
-- 문제 09
SELECT userid, AVG(price*amount) AS 평균금액 FROM buytbl GROUP BY userid
HAVING AVG(price*amount) > (SELECT AVG(price*amount) FROM buytbl);

-- 문제 10
select userid,a.addr,구매총액,지역별평균구매액 
from (select u.addr,u.userid,sum(b.price*b.amount) as 구매총액
from usertbl u join buytbl b on u.userid = b.userid 
group by u.addr,u.userid) a join 
(select u2.addr, avg(b2.price*b2.amount) as 지역별평균구매액 
from usertbl u2 join buytbl b2 on u2.userid = b2.userid group by u2.addr)
c on a.addr = c.addr where 구매총액 >= 지역별평균구매액;
```

---

> **문자열 함수**
> 

```java
-- 대소문자 변환
SELECT userID,
       LOWER(userID) AS lower_id,         -- 소문자 변환
       UPPER(name) AS upper_name,         -- 대문자 변환
       INITCAP(LOWER(name)) AS init_cap   -- 첫 글자만 대문자로 변환
FROM userTbl;

-- 문자열 길이
SELECT name, 
       LENGTH(name) AS name_length,       -- 이름의 문자 개수
       LENGTH(addr) AS addr_length        -- 주소의 문자 개수
FROM userTbl;

-- 문자 위치 찾기
SELECT name, 
       INSTR(name, '김') AS position_kim   -- '김'이 있는 위치 (없으면 0)
FROM userTbl;

-- 문자열 채우기
SELECT userID,
       LPAD(userID, 10, '*') AS lpad_id,  -- userID 왼쪽을 *로 채워 10자리로
       RPAD(name, 10, '-') AS rpad_name   -- name 오른쪽을 -로 채워 10자리로
FROM userTbl;

-- 공백 제거
SELECT TRIM(' SQL ') AS trim_result,      -- 양쪽 공백 제거: 'SQL'
       LTRIM(' SQL ') AS ltrim_result,    -- 왼쪽 공백 제거: 'SQL '
       RTRIM(' SQL ') AS rtrim_result     -- 오른쪽 공백 제거: ' SQL'
FROM dual;

-- 문자열 치환
SELECT name,
       REPLACE(mobile1, NULL, '없음') AS replace_null,   -- NULL을 '없음'으로 대체
       REPLACE(addr, '서울', 'SEOUL') AS replace_addr   -- '서울'을 'SEOUL'로 대체
FROM userTbl;

-- 문자열 연결
SELECT name,
       CONCAT(mobile1, '-') AS part1,                    -- 휴대폰 국번과 '-' 연결
       CONCAT(CONCAT(mobile1, '-'), mobile2) AS mobile,  -- 국번-전화번호 형식으로 연결
       mobile1 || '-' || mobile2 AS phone_number        -- 연결 연산자 사용
FROM userTbl;

```

---

> **JOIN문**
> 

```java
-- 구매한 회원의 영문이름,이름,생년,주소,상품명,카테고리,가격
SELECT u.userId,name,birthyear,addr,prodname,groupname,price
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID;

--회원별 총 구매 금액
SELECT u.userID, u.name, SUM(b.price * b.amount) AS 총구매금액
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID
GROUP BY u.userID, u.name;

-- 상품을 가장 많이 구매한 회원(수량 기준)
select rownum as RN,name,총수량 from
(
SELECT u.name, SUM(b.amount) AS 총수량
FROM userTbl u JOIN buyTbl b ON u.userID = b.userID
GROUP BY u.name ORDER BY 총수량 DESC
)
where rownum = 1;

-- 조인의 종류-외부 조인(OUTER JOIN ): 조건에 만족하지 않아도 반환함.
SELECT *
FROM userTbl u
LEFT JOIN buyTbl b ON u.userID = b.userID
WHERE b.userID IS NULL;
```

---

> **테이블 추가**
> 

```java
-- 학생 테이블
CREATE TABLE studentTbl (
  studentID CHAR(5) PRIMARY KEY,
  name VARCHAR2(20)
);

-- 시험 응시 테이블
CREATE TABLE examTbl (
  examID CHAR(5) PRIMARY KEY,
  studentID CHAR(5),
  subject VARCHAR2(20),
  score NUMBER
);

-- 학생 데이터 삽입
INSERT INTO studentTbl VALUES ('S001', '홍길동');
INSERT INTO studentTbl VALUES ('S002', '김철수');
INSERT INTO studentTbl VALUES ('S003', '이영희');
INSERT INTO studentTbl VALUES ('S004', '박지민');

-- 시험 응시 데이터 삽입
INSERT INTO examTbl VALUES ('E101', 'S001', '수학', 85);
INSERT INTO examTbl VALUES ('E102', 'S002', '영어', 90);
INSERT INTO examTbl VALUES ('E103', 'S005', '국어', 88); -- 존재하지 않는 학생

COMMIT;

SELECT * FROM studentTbl s FULL OUTER JOIN examTbl e
ON s.studentID = e.studentID;
```

---