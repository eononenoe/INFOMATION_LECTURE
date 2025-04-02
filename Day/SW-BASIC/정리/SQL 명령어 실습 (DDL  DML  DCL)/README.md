# 🛠️ SQL 명령어 정리 (DDL / DML / DCL)

---

## 📌 개요 (Overview)

SQL은 데이터베이스에서 데이터를 **정의하고, 조작하고, 제어**할 수 있는 언어예요.  
이 문서에서는 SQL을 3가지 유형으로 나누어 정리합니다:

- DDL: 데이터 구조 정의
- DML: 데이터 조작
- DCL: 데이터 권한 및 제어

---

## 💡 핵심 개념 요약 (Key Concepts)

---

### 📐 1. DDL (Data Definition Language)

> **데이터의 틀을 만드는 언어**  
→ 테이블, DB 생성/삭제/수정

```sql
CREATE   -- 테이블, DB 생성
ALTER    -- 구조 수정 (컬럼 추가/삭제/수정)
DROP     -- 삭제
TRUNCATE -- 테이블 비우기 (초기화)
```

---

### 🧾 2. DML (Data Manipulation Language)

> **데이터를 직접 다루는 언어**  
→ 조회, 입력, 수정, 삭제

```sql
SELECT -- 조회
INSERT -- 삽입
UPDATE -- 수정
DELETE -- 삭제
```

---

### 🔐 3. DCL (Data Control Language)

> **권한 제어 및 트랜잭션 관리**

```sql
GRANT    -- 권한 부여
REVOKE   -- 권한 회수
COMMIT   -- 변경사항 저장
ROLLBACK -- 변경사항 취소
```

---

## 🧪 실습 예제 (DML 중심)

### 📦 데이터베이스 및 테이블 생성

```sql
-- 데이터베이스 생성
CREATE DATABASE testdb;

-- 사용할 DB 선택
USE testdb;

-- 테이블 생성
CREATE TABLE tbl_user (
  user_id VARCHAR(10) PRIMARY KEY,
  user_password VARCHAR(100) NOT NULL,
  user_name VARCHAR(45) NOT NULL
);
```

---

### ✍️ 테이블 문제 생성 (tbl_product)

```sql
CREATE TABLE testdb.tbl_product (
  prod_id INT PRIMARY KEY,
  prod_name VARCHAR(100) NOT NULL,
  prod_category VARCHAR(10),
  prod_details VARCHAR(1024),
  reg_date DATETIME NOT NULL,
  prod_price INT NOT NULL
);
```

---

### 🛠 ALTER 실습

```sql
-- 컬럼 추가
ALTER TABLE tbl_user ADD COLUMN user_tel VARCHAR(30) NULL AFTER user_name;

-- 컬럼 삭제
ALTER TABLE tbl_user DROP COLUMN user_password;

-- 컬럼 수정
ALTER TABLE tbl_user CHANGE COLUMN user_tel user_phone VARCHAR(100) NOT NULL;
```

---

### 🧪 ALTER 실습 문제 (tbl_product)

```sql
-- 컬럼 추가
ALTER TABLE tbl_product ADD COLUMN amount INT NOT NULL;

-- 컬럼 수정
ALTER TABLE tbl_product CHANGE COLUMN prod_price prod_price VARCHAR(100) NULL;

-- 컬럼 삭제
ALTER TABLE tbl_product DROP COLUMN prod_details;
```

---

### ➕ INSERT 데이터 삽입

```sql
-- 단일 삽입
INSERT INTO tbl_user (user_id, user_name, user_phone)
VALUES ('user10', '홍길동', '010-222-3333');

-- 전체 컬럼 삽입
INSERT INTO tbl_user VALUES ('user20', '남길동', '010-555-6666');
```

---

### 🔍 SELECT 조회

```sql
-- 전체 조회
SELECT * FROM tbl_user;

-- 일부 컬럼 조회
SELECT user_id, user_name FROM tbl_user;
```

---

### 🖊 UPDATE 수정

```sql
-- user_id가 'user20'인 사용자의 이름을 '철수'로 수정
UPDATE tbl_user SET user_name = '철수' WHERE user_id = 'user20';
```

---

### ❌ DELETE 삭제

```sql
-- user_id가 'user10'인 사용자 삭제
DELETE FROM tbl_user WHERE user_id = 'user10';
```

---

### 🧪 DML 실습 문제 (tbl_product)

#### ✅ [1] 값 추가

```sql
INSERT INTO tbl_product VALUES
(1111, 'LG_GRAM_2023', '가전', '2024-01-22', '830000', 100),
(1112, 'SAMSUNG_FLEX2', '가전', '2024-01-22', '3000000', 50),
(2000, '대우_통돌이_01', '가전', '2024-01-22', '590000', 25),
(3001, '이것이리눅스다', '도서', '2023-01-22', '30000', 1000);
```

#### 🖊 [2] 값 수정

```sql
-- prod_category가 '가전'인 제품들의 등록일을 수정
UPDATE tbl_product SET reg_date = '2023-01-01'
WHERE prod_category = '가전';
```

#### ❌ [3] 값 삭제

```sql
-- prod_id가 1111인 제품 삭제
DELETE FROM tbl_product WHERE prod_id = 1111;
```

---

## ⚠ 주의사항 (Cautions)

- `varchar`에 길이 제한 필수 (예: varchar(100))
- `NOT NULL`, `PRIMARY KEY` 같은 제약조건 활용
- `ALTER`로 컬럼 수정 시 `CHANGE` 사용 시 기존 컬럼명과 새 컬럼명 모두 지정 필요

---

## ✅ 한 줄 요약 (1-Line Summary)

> SQL은 데이터를 만들고(DDL), 다루고(DML), 통제(DCL)하는 가장 강력한 도구입니다! 💾🧙‍♂️

---
