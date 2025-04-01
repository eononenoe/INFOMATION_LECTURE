
# 📘 SQL 실습 정리

## 📌 목차
- [테이블 생성 및 데이터 삽입](#테이블-생성-및-데이터-삽입)
- [기초 SELECT 문](#기초-select-문)
- [GROUP BY & 집계 함수](#group-by--집계-함수)
- [HAVING 절](#having-절)
- [문자열 함수](#문자열-함수)
- [JOIN 문](#join-문)
- [실전 문제 풀이](#실전-문제-풀이)
- [고급 그룹핑 함수](#고급-그룹핑-함수)

---

## 테이블 생성 및 데이터 삽입

### ✅ userTbl / buyTbl 생성

```sql
CREATE TABLE userTbl (
  userID CHAR(8) PRIMARY KEY,
  name VARCHAR(10) NOT NULL,
  birthYear INT NOT NULL,
  addr NCHAR(2) NOT NULL,
  mobile1 CHAR(3),
  mobile2 CHAR(8),
  height SMALLINT,
  mDate DATE
);

CREATE TABLE buyTbl (
  num INT PRIMARY KEY,
  userID CHAR(8),
  prodName CHAR(15) NOT NULL,
  groupName CHAR(15),
  price INT NOT NULL,
  amount SMALLINT NOT NULL,
  FOREIGN KEY (userID) REFERENCES userTbl(userID)
);
```

### ✅ 데이터 삽입 예시

```sql
INSERT INTO userTbl VALUES('LSG','이승기',1987,'서울','011','1111111',182,'2008-08-08');
INSERT INTO buyTbl VALUES(1,'KBS','운동화',NULL,30,2);
```

---

## 기초 SELECT 문

```sql
-- 전체 데이터 조회
SELECT * FROM userTbl;

-- 오름차순, 내림차순 정렬
SELECT name, mDate FROM userTbl ORDER BY mDate ASC;
SELECT name, height FROM userTbl ORDER BY height DESC, name ASC;
```

---

## GROUP BY & 집계 함수

```sql
-- 사용자별 구매 총액
SELECT userID, SUM(price * amount) AS 총구매액
FROM buyTbl
GROUP BY userID;

-- 지역별 사용자 수
SELECT addr, COUNT(*) AS 사용자수
FROM userTbl
GROUP BY addr;

-- 제품 그룹별 판매 총액
SELECT groupName, SUM(price * amount) AS 판매액
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY groupName;
```

---

## HAVING 절

```sql
-- 구매 금액이 1000 이상인 사용자
SELECT userID, SUM(price * amount) AS 총구매액
FROM buyTbl
GROUP BY userID
HAVING SUM(price * amount) >= 1000;

-- 평균 키가 175 이상인 지역
SELECT addr, AVG(height) AS 평균키
FROM userTbl
GROUP BY addr
HAVING AVG(height) >= 175;
```

---

## 문자열 함수

```sql
-- 대소문자 변환
SELECT userID, LOWER(userID), UPPER(name), INITCAP(LOWER(name))
FROM userTbl;

-- 문자열 길이
SELECT name, LENGTH(name), LENGTH(addr)
FROM userTbl;

-- 문자열 결합
SELECT name, mobile1 || '-' || mobile2 AS 전화번호
FROM userTbl;

-- 공백 제거
SELECT TRIM(' SQL ') AS trim_result;

-- 문자열 치환
SELECT name, REPLACE(addr, '서울', 'SEOUL') AS new_addr
FROM userTbl;
```

---

## JOIN 문

```sql
-- 회원의 구매 내역 JOIN
SELECT u.userID, u.name, b.prodName, b.groupName, b.price
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID;

-- 구매하지 않은 회원
SELECT *
FROM userTbl u
LEFT JOIN buyTbl b ON u.userID = b.userID
WHERE b.userID IS NULL;
```

---

## 실전 문제 풀이

```sql
-- 사용자별 총 구매액(1000 이상)
SELECT userID, SUM(price * amount) AS 총구매액
FROM buyTbl
GROUP BY userID
HAVING SUM(price * amount) >= 1000;

-- 지역별 평균 구매액보다 많이 구매한 사용자
SELECT userID, addr, 구매총액
FROM (
  SELECT u.userID, u.addr, SUM(b.price * b.amount) AS 구매총액
  FROM userTbl u JOIN buyTbl b ON u.userID = b.userID
  GROUP BY u.userID, u.addr
) a
JOIN (
  SELECT addr, AVG(price * amount) AS 지역평균
  FROM userTbl u JOIN buyTbl b ON u.userID = b.userID
  GROUP BY addr
) b
ON a.addr = b.addr
WHERE 구매총액 >= 지역평균;
```

---

## 고급 그룹핑 함수

```sql
-- ROLLUP: 소계/합계 포함
SELECT groupName, SUM(price * amount) AS 판매액
FROM buyTbl
GROUP BY ROLLUP(groupName);

-- CUBE: 가능한 모든 소계 계산
SELECT groupName, prodName, SUM(price * amount) AS 판매액
FROM buyTbl
GROUP BY CUBE(groupName, prodName);

-- GROUPING SETS: 맞춤형 그룹핑
SELECT groupName, prodName, SUM(price * amount) AS 판매액
FROM buyTbl
GROUP BY GROUPING SETS((groupName), (prodName), ());
```

---

## 📌 요약

- `GROUP BY`는 집계함수와 함께 그룹 분석 시 필수
- `HAVING`은 그룹 조건 필터링
- `JOIN`은 다중 테이블 관계 분석
- 문자열 함수로 데이터 전처리/포맷 가능
- `ROLLUP`, `CUBE`, `GROUPING SETS`는 고급 집계 활용에 효과적

---
