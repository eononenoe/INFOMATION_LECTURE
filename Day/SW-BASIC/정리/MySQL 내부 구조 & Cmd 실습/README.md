# 🧱 MySQL 시스템 구조 & 명령어 실습

---

## 📌 개요 (Overview)

MySQL은 다양한 **시스템 데이터베이스**와 **명령어 기능**을 통해  
데이터베이스의 상태를 분석하고, 데이터를 직접 다룰 수 있도록 도와줍니다.  
이 문서에서는 MySQL의 구조적 특징과 **CMD 기반 실습 예제**를 정리합니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🧠 MySQL의 기본 시스템 데이터베이스

```jsx
information_schema
: 메타데이터 제공 (테이블, 열, 인덱스 등)

performance_schema
: 시스템 성능 정보 제공 (쿼리 성능, 서버 리소스 상태)

mysql
: 사용자, 권한, 인증 관련 정보 포함

sys
: 위 두 스키마를 쉽게 분석할 수 있도록 도와주는 DB
```

---

## 🎯 주요 SQL 명령어 (CMD 실습용)

### ✅ 테이블 구조 관련

```sql
-- 컬럼 추가
ALTER TABLE 테이블명 ADD COLUMN 컬럼명 자료형 제약조건;

-- 컬럼 삭제
ALTER TABLE 테이블명 DROP COLUMN 컬럼명;

-- 컬럼 수정
ALTER TABLE 테이블명 CHANGE COLUMN 기존컬럼명 변경컬럼명 변경자료형 제약조건;
```

---

### ➕ INSERT 문 (값 삽입)

```sql
-- 기본 문법
INSERT INTO 테이블명 (컬럼명1, 컬럼명2) VALUES ('값1', '값2');
```

---

### ✏️ UPDATE 문 (값 수정)

```sql
-- 특정 조건에 해당하는 행 수정
UPDATE 테이블명 SET 컬럼명 = '새로운값' WHERE 컬럼명 = '기존값';
```

---

### ❌ DELETE 문 (값 삭제)

```sql
-- 특정 조건에 해당하는 행 삭제
DELETE FROM 테이블명 WHERE 컬럼명 = '값';
```

## 🧪 스네이크 표기법 vs 카멜 표기법

| 표기법       | 예시            |
|--------------|-----------------|
| 스네이크(snake_case) | `user_id`, `reg_date` |
| 카멜(camelCase)      | `userId`, `regDate`   |

※ 일반적으로 **데이터베이스에서는 스네이크 표기법**을 주로 사용합니다.

---

## ⚠ 주의사항 (Cautions)

- `Ctrl + Enter`로 명령 실행 가능 (워크벤치 기준)
- `CHANGE` 문 사용 시 기존 컬럼명과 새 컬럼명을 **모두 명시**
- 실습은 **테스트용 DB에서 수행**하고, 실 DB에서는 신중하게 실행하세요!

---

## ✅ 한 줄 요약 (1-Line Summary)

> MySQL은 구조부터 명령어까지 탄탄하게 배우면 데이터 다루는 실력이 확 올라갑니다! 🧱💡

---
