# 📚 SQL 기본 실습 정리

> 차라워자리도 이해할 수 있도록 쉽게 풀어 쓰는 SQL 실습! ( 텍입벡이 생성부터, 조회, 그룹핑, 집계 함수, 서브쿨리, 문자열 함수, 조인까지!)🚀

---

## 📌 개요 (Overview)

SQL을 처음 배우는 사람을 위해 **텍입벡 생성**부터 **데이터 삽입**, **조회(SELECT)**, **GROUP BY 집계**, **HAVING**, **문자열 함수**, **JOIN**까지 기초를 쉽고 재미있게 설명한 실습 목록입니다.

**실문에서 쓰는 기술**들을 따라하며 익해할 수 있어요! 🌟

---

## 💡 해당 개념 요약 (Key Concepts)

- **텍입벡 생성과 삭제**: `CREATE TABLE`, `DROP TABLE`
- **데이터 삽입**: `INSERT INTO`
- **기본 조회**: `SELECT * FROM 텍입벡명`
- **조건 조회**: `WHERE`, `ORDER BY`
- **집계 함수**: `SUM()`, `AVG()`, `COUNT()`
- **GROUP BY로 그룹별 결과 보기**
- **HAVING으로 그룹 조건 건기**
- **NULL 단유하기**: `NVL`, `COALESCE`, `CASE`
- **문자열 함수**: `LOWER`, `UPPER`, `TRIM`, `INSTR`, `REPLACE`, `CONCAT`
- **JOIN으로 텍입벡 합칠기**: `INNER JOIN`, `LEFT JOIN`, `FULL OUTER JOIN`
- **ROLLUP, CUBE, GROUPING SETS**로 소계/총계 만들기

---

## ⚠ 주의사항 (Cautions)

- **문자형 데이터**는 `'` 작은따옴폰로 감삥해야 해요! (ex: `'\uc11c울'`)
- **텍입벡을 삭제할 때는** `DROP TABLE` 주의해서 사용하세요. 데이터가 영영 사라요! 🧹
- **NULL 값**은 조심! NULL은 아무것도 없는 것이니까 `= NULL`이 아니라 `IS NULL`로 비교해요!
- **JOIN할 때는** 연결 조건(`ON`)을 꼭 작성해야해요. 안 구조하면 **카티션 결합(Cartesian Product)** 발생할 수 있어요 😱

---

## 🧪 예제 또는 비유 (Examples or Analogies)

- 텍입벡은 **에크셀 파일** 같은 것. 각 행(Row)은 데이터 하나, 열(Column)은 항목 하나에요!
- JOIN은 **두 개의 다른 에크셀 시트**를 **공통된 열(udf도와 같이) 단위로 연결**해서 하나로 보는 것과 같아요.
- GROUP BY는 **"동일한 그룹까만 무효적으로 무료와 통계를 내려내는 것"**!
- HAVING은 **"그룹에 대한 건강"** 필터링이에요. (WHERE은 "행" 기준, HAVING은 "그룹" 기준!)
- NULL은 **"아직 입력이 안된 셀"** 이라고 생각하면 쉽어요!

---

## ✅ 하나라의 요약 (1-Line Summary)

> SQL은 "데이터를 자유자재로 보고, 무고, 감사하고, 변화해서 원하는 형태로 만드는 마법의 언어"입니다! 🧙‍♂️✨

---

## ✨ 실습 SQL 목록

### 🏗️ 텍입벡 생성 및 데이터 삽입

```sql
-- 기존 텍입벡 삭제
DROP TABLE buyTbl;
DROP TABLE userTbl;

-- userTbl 생성
CREATE TABLE userTbl (
  userID CHAR(8) NOT NULL PRIMARY KEY,
  name VARCHAR(10) NOT NULL,
  birthYear INT NOT NULL,
  addr NCHAR(2) NOT NULL,
  mobile1 CHAR(3),
  mobile2 CHAR(8),
  height SMALLINT,
  mDate DATE
);

-- buyTbl 생성
CREATE TABLE buyTbl (
  num INT NOT NULL PRIMARY KEY,
  userID CHAR(8) NOT NULL,
  prodName CHAR(15) NOT NULL,
  groupName CHAR(15),
  price INT NOT NULL,
  amount SMALLINT NOT NULL,
  FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

-- userTbl 데이터 삽입
INSERT INTO userTbl VALUES('LSG','\uc774\uc2b9\uae30',1987,'\uc11c\uc6b8','011','1111111',182,'2008-08-08');
-- (... 나머지 삽입 같이...)

-- buyTbl 데이터 삽입
INSERT INTO buyTbl VALUES(1,'KBS','\uc6b4\ub3d9\ud654',NULL,30,2);
-- (... 나머지 삽입 같이...)

-- 데이터 확인
SELECT * FROM userTbl;
SELECT * FROM buyTbl;
```

### 📈 SELECT, WHERE, GROUP BY, ORDER BY

```sql
-- 사용자별 총 구매 금액
SELECT userID, SUM(price * amount) AS 구매총액
FROM buyTbl
GROUP BY userID;

-- 지역별 사용자 수
SELECT addr, COUNT(*) AS 사용자수
FROM userTbl
GROUP BY addr;

-- 그룹별 판매 합계
SELECT groupName, SUM(price * amount) AS 판매액
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY groupName;
```

### 🧐 HAVING 절 활용

```sql
-- 총 구매액이 1000 이상인 사용자
SELECT userID, SUM(price * amount) AS 총구매액
FROM buyTbl
GROUP BY userID
HAVING SUM(price * amount) >= 1000;

-- 평균 키가 175cm 이상인 지역
SELECT addr, AVG(height) AS 평균키
FROM userTbl
GROUP BY addr
HAVING AVG(height) >= 175;
```

### 🔠 문자열 함수

```sql
-- 대소문자 변환
SELECT userID, LOWER(userID) AS 소문자ID, UPPER(name) AS 대문자이름
FROM userTbl;

-- 문자열 길이
SELECT name, LENGTH(name) AS 이름길이
FROM userTbl;

-- 특정 문자 찾기
SELECT name, INSTR(name, '김') AS 김위치
FROM userTbl;

-- 문자열 연결
SELECT name, mobile1 || '-' || mobile2 AS 휴대폰번호
FROM userTbl;
```

### 🔗 JOIN문 활용

```sql
-- 구매한 회원 정보 + 상품명
SELECT u.userID, u.name, b.prodName
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID;

-- 회원별 총 구매금액
SELECT u.userID, u.name, SUM(b.price * b.amount) AS 총구매금액
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID
GROUP BY u.userID, u.name;

-- 외부 조인 ( 구매 기록 없는 회원 찾기 )
SELECT u.userID, u.name
FROM userTbl u
LEFT JOIN buyTbl b ON u.userID = b.userID
WHERE b.userID IS NULL;
```

### 🧮 고급 GROUPING (ROLLUP, CUBE, GROUPING SETS)

```sql
-- 카테고리별 소계와 총계
SELECT groupName, SUM(price * amount) AS 판매액
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY ROLLUP(groupName);

-- 그룹과 상품별 소계와 총계
SELECT groupName, prodName, SUM(price * amount) AS 판매액
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY CUBE(groupName, prodName);

-- GROUPING SETS 사용
SELECT groupName, prodName, SUM(price * amount) AS 판매액
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY GROUPING SETS((groupName), (prodName), ());
```

