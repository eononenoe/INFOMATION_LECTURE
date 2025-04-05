# 📇 SQL 기본 + 견연 실습 정리

---

## 📈 01. 텍입벡 생성 및 데이터 삽입

### 텍입벡: `userSelfTestTbl`

```sql
CREATE TABLE userSelfTestTbl (
    userID      VARCHAR2(10) PRIMARY KEY,
    name        VARCHAR2(50),
    birthYear   NUMBER(4),
    addr        VARCHAR2(100),
    mobile1     VARCHAR2(10),
    mobile2     VARCHAR2(20),
    height      NUMBER(3),
    mDate       DATE,
    managerID   VARCHAR2(10)
);

-- 데이터 삽입 (userSelfTestTbl)
INSERT INTO userSelfTestTbl VALUES ('LSG', '이승기', 1987, '서울', '011', '1111111', 182, TO_DATE('08/08/08', 'RR/MM/DD'), 'JYP');
(...계속)
```

### 텍입벡: `empTbl`

```sql
CREATE TABLE empTbl (
  empID     NUMBER PRIMARY KEY,
  empName   VARCHAR2(20),
  position  VARCHAR2(20),
  managerID NUMBER
);

-- 데이터 삽입 (empTbl)
INSERT INTO empTbl VALUES (1, '김대표', '대표이사', NULL);
(...계속)
```

---

## 🤠 02. 텍입벡 조회

```sql
-- userSelfTestTbl 전체 조회
SELECT * FROM userSelfTestTbl;

-- empTbl 전체 조회
SELECT * FROM empTbl;
```

### 자기참조 JOIN 예시 (userSelfTestTbl)

```sql
SELECT E.name AS 직원명, M.name AS 관리자명
FROM userSelfTestTbl E
JOIN userSelfTestTbl M ON E.managerID = M.userID;
```

### 자기참조 JOIN 예시 (empTbl)

```sql
SELECT E.empName AS 직원, M.empName AS 상사
FROM empTbl E
LEFT JOIN empTbl M ON E.managerID = M.empID;
```

---

## 🔗 03. 다양한 JOIN 실습

### INNER JOIN

```sql
-- 문제 01
SELECT u.name, b.prodName, b.price, b.amount
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID;

-- 문제 02
SELECT u.userID, SUM(b.price * b.amount) AS 총금액
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID
GROUP BY u.userID
ORDER BY 총금액;

-- 문제 03
SELECT DISTINCT u.name
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID
WHERE b.prodName = '책';
```

### LEFT JOIN

```sql
-- 문제 01
SELECT u.name, b.prodName, b.price
FROM userTbl u
LEFT JOIN buyTbl b ON u.userID = b.userID;

-- 문제 02 (구매 기록 없는 회원 찾기)
SELECT u.name, u.userID
FROM userTbl u
LEFT JOIN buyTbl b ON u.userID = b.userID
WHERE b.userID IS NULL;
```

### RIGHT JOIN

```sql
-- 문제 01
SELECT u.name, b.prodName
FROM userTbl u
RIGHT JOIN buyTbl b ON u.userID = b.userID;

-- 문제 02 (구매자는 없고 상품만 존재하는 경우)
SELECT b.prodName, b.price
FROM userTbl u
RIGHT JOIN buyTbl b ON u.userID = b.userID
WHERE u.userID IS NULL;
```

---

## 🧩 04. 서브쿼리 실습

```sql
-- 문제 01: 서울 지역에 거주하며 전체 평균 키보다 큰 회원 조회
SELECT name, height
FROM userTbl
WHERE addr = '서울'
  AND height > (SELECT AVG(height) FROM userTbl);

-- 문제 02: 물품을 한 번이라도 구매한 회원 조회
SELECT name, addr
FROM userTbl
WHERE userID IN (SELECT DISTINCT userID FROM buyTbl);

-- 문제 03: 전자 분류 가장 비싼 상품 구매자
SELECT u.name, b.prodName, b.price
FROM buyTbl b
JOIN userTbl u ON b.userID = u.userID
WHERE groupName = '전자'
  AND price = (SELECT MAX(price) FROM buyTbl WHERE groupName = '전자');
```

---

## 🛠 05. MySQL Forward Engineering 예시

```sql
-- 예시: Member_Tbl 생성
CREATE TABLE Member_Tbl (
  Member_id INT NOT NULL PRIMARY KEY,
  Member_name VARCHAR(45),
  Member_identity VARCHAR(45),
  Member_grade VARCHAR(45),
  Member_addr VARCHAR(45),
  Member_phone VARCHAR(45)
);

-- 외래 키 관계 설정 예시 (Book_tbl, Rental_Tbl 등)
(...계속)
```

---

## 🏛 06. Oracle 예시 (시험용)

Oracle DB 환경에서는 `TO_DATE`, `NVL` 함수 사용법에 주의! (기본 날짜 변환 함수, NULL 처리 등)

```sql
-- 대표 예시
SELECT empName, NVL(managerID, '없음')
FROM empTbl;
```

---

# ✅ 정리

> 테이블 생성과 JOIN, 서브쿼리, 그리고 MySQL/Oracle 기본적인 데이터베이스 구축까지! 🌟
>
> 다음은 "**윈도우 함수(Window Function)**"와 "**트랜잭션 제어(Transaction Control)**" 로 이어집니다! 🚀

