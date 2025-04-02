# 📘 MySQL 실습: DDL, DML, 사용자 권한 관리

---

## 📌 개요 (Overview)

이 문서는 MySQL에서 데이터베이스 및 테이블을 만들고, 데이터를 삽입·수정·삭제하는 실습과  
사용자 계정 및 권한 관리까지 포함한 실전 중심 실습 내용입니다.

---

## 💡 핵심 명령어 정리 (DDL/DML)

### 📂 데이터베이스 & 테이블 기초

```sql
-- 데이터베이스 조회
SHOW DATABASES;

-- 사용할 데이터베이스 선택
USE mysql;

-- 테이블 목록 확인
SHOW TABLES;

-- 특정 테이블 조회
SELECT * FROM user;
```

---

### 🏗 DB 및 테이블 생성

```sql
-- 데이터베이스 생성
CREATE DATABASE testdb;
USE testdb;

-- 테이블 생성
CREATE TABLE tbl_user (
  user_id VARCHAR(10) PRIMARY KEY,
  user_password VARCHAR(100) NOT NULL,
  user_name VARCHAR(45) NOT NULL
);
```

---

### 📌 테이블 구조 문제 예시

```sql
-- tbl_product 테이블 생성
CREATE TABLE tbl_product (
  prod_id INT PRIMARY KEY,
  prod_name VARCHAR(100) NOT NULL,
  prod_category VARCHAR(10),
  prod_details VARCHAR(1024),
  reg_date DATETIME NOT NULL,
  prod_price INT NOT NULL
);
```

---

### 🔁 ALTER 실습

```sql
-- 컬럼 추가
ALTER TABLE tbl_user ADD COLUMN user_tel VARCHAR(30) NULL AFTER user_name;

-- 컬럼 삭제
ALTER TABLE tbl_user DROP COLUMN user_password;

-- 컬럼명 변경 및 자료형 수정
ALTER TABLE tbl_user CHANGE COLUMN user_tel user_phone VARCHAR(100) NOT NULL;
```

---

### ✍️ tbl_product 구조 변경 문제

```sql
-- 컬럼 추가
ALTER TABLE tbl_product ADD COLUMN amount INT NOT NULL;

-- 컬럼 수정
ALTER TABLE tbl_product CHANGE COLUMN prod_price prod_price VARCHAR(100) NULL;

-- 컬럼 삭제
ALTER TABLE tbl_product DROP COLUMN prod_details;
```

---

## 🧪 DML 실습

### ➕ INSERT (데이터 삽입)

```sql
INSERT INTO tbl_user (user_id, user_name, user_phone)
VALUES ('user10', '홍길동', '010-222-3333');

INSERT INTO tbl_user VALUES ('user20', '남길동', '010-555-6666');
```

---

### 🔍 SELECT (조회)

```sql
-- 전체 조회
SELECT * FROM tbl_user;

-- 일부 컬럼만 조회
SELECT user_id, user_name FROM tbl_user;
```

---

### 🖊 UPDATE (수정)

```sql
UPDATE tbl_user SET user_name = '철수' WHERE user_id = 'user20';
```

---

### ❌ DELETE (삭제)

```sql
DELETE FROM tbl_user WHERE user_id = 'user10';
```

---

## 🧠 DML 실습 문제

### 1. 값 추가

```sql
INSERT INTO tbl_product VALUES
(1111, 'LG_GRAM_2023', '가전', '2024-01-22', '830000', 100),
(1112, 'SAMSUNG_FLEX2', '가전', '2024-01-22', '3000000', 50),
(2000, '대우_통돌이_01', '가전', '2024-01-22', '590000', 25),
(3001, '이것이리눅스다', '도서', '2023-01-22', '30000', 1000);
```

### 2. 값 수정

```sql
UPDATE tbl_product SET reg_date = '2023-01-01' WHERE prod_category = '가전';
```

### 3. 값 삭제

```sql
DELETE FROM tbl_product WHERE prod_id = 1111;
```

---

## 🔐 사용자 계정 관리 (DCL)

### 👤 사용자 계정 생성

```sql
-- 로컬 접속 전용
CREATE USER user10@localhost IDENTIFIED BY 'bsit@COM';

-- 외부 접속 허용
CREATE USER user30@'%' IDENTIFIED BY 'bsit@COM';

-- 권한 적용
FLUSH PRIVILEGES;
```

---

### 🔑 권한 부여

```sql
-- 읽기 전용 권한
GRANT SELECT ON test1.* TO user10@'%';

-- 읽기 + 삽입 권한
GRANT SELECT, INSERT ON test1.* TO user20@'%';

-- 읽기 + 삽입 + 수정 권한
GRANT SELECT, INSERT, UPDATE ON test1.* TO user30@'%';

-- 전체 권한 부여
GRANT ALL PRIVILEGES ON test1.* TO user40@'%';

-- 권한 적용
FLUSH PRIVILEGES;
```

---

### ❌ 권한 회수 및 확인

```sql
-- 권한 제거
REVOKE ALL ON test1.* FROM user10@'%';

-- 권한 확인
SHOW GRANTS FOR user10@'%';
```

---

### 🧪 CMD로 접속 예시

```bash
mysql -u user40 -p -h 192.168.1.10 --port 3306
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> MySQL 실습은 테이블을 만들고, 데이터를 다루며, 사용자 권한을 통해 보안을 강화하는 과정입니다! 🔐🛠️

---
