# 🔄 Spring Transaction 정리

## 📌 개요

**트랜잭션(Transaction)**  
: 데이터베이스의 상태를 변경시키는 **작업의 논리적 단위**

트랜잭션은 한꺼번에 수행되어야 할 연산을 모아 놓은 것이며, 일부 연산만 처리된 경우에는 원상태로 복구함으로써 **작업의 완전성**을 보장합니다.  
사용자 입장에서는 논리적 작업 단위, 시스템 입장에서는 DB 접근 또는 변경 단위가 됩니다.

---

## 💡 ACID (트랜잭션의 특징)

1. **Atomicity (원자성)**  
   - 트랜잭션은 전부 실행되거나, 전혀 실행되지 않아야 함 (All or Nothing)

2. **Consistency (일관성)**  
   - 트랜잭션 전/후 DB 상태는 항상 일관적이어야 함
   - 제약조건 위배 없이, 예: 정수형 컬럼을 문자열로 바꾸는 건 불가

3. **Isolation (독립성)**  
   - 여러 트랜잭션이 동시에 실행되어도 서로 간섭 불가

4. **Durability (지속성)**  
   - 성공한 트랜잭션의 결과는 영구적으로 반영됨

---

## 🛠 트랜잭션 연산

- **COMMIT**: 성공적으로 완료되었음을 선언, DB에 반영
- **ROLLBACK**: 실패 시 이전 상태로 되돌림

---

## 🔁 트랜잭션 상태

- **Active**: 실행 중
- **Partially Committed**: COMMIT 명령 직전 상태
- **Failed**: 실패로 더 이상 진행 불가
- **Committed**: COMMIT 완료
- **Aborted**: ROLLBACK 수행 후 상태

**Partially Committed vs Committed**  
- COMMIT 요청 시: Partially Committed  
- 실제 완료 시: Committed

---

## ⚠ 트랜잭션 적용 시 주의사항

- 꼭 필요한 최소한의 코드에만 적용
- DB 커넥션 점유 시간 최소화
- 커넥션은 자원이므로 효율적으로 사용해야 함

---

## 🤝 병행제어 (Concurrency Control)

### 발생 가능한 문제

1. **분실된 갱신 (Lost Update)**
2. **모순성 (Inconsistency)**
3. **연쇄복귀 (Cascading Rollback)**
4. **비완료 의존성 (Uncommitted Dependency)**

### 병행제어 기법

1. **로킹 (Locking)**  
   - S-lock (공유 잠금), X-lock (배타 잠금)
   - 2단계 로킹 규약 (2PL): 확장 → 축소 단계 구분

2. **타임스탬프 방식**
3. **낙관적 병행제어**
4. **다중 버전 병행제어 (MVCC)**

---

## 🧨 교착 상태 (Deadlock)

- 서로 잠금을 기다리다 **무한 대기 상태**
- MySQL 예시, `ERROR 1213` 발생
- 예방 방법:
  - 트랜잭션 자주 COMMIT
  - 테이블 접근 순서 통일
  - SELECT FOR UPDATE 사용 최소화
  - 테이블 단위 잠금 고려

---

## 🔐 트랜잭션 격리수준 (Isolation Level)

| 수준 | 설명 | 발생 문제 |
|------|------|-----------|
| **READ UNCOMMITTED** | 커밋되지 않은 것도 읽음 | Dirty Read |
| **READ COMMITTED** | 커밋된 것만 읽음 | Non-repeatable Read |
| **REPEATABLE READ** | 반복 조회 보장 | Phantom Read |
| **SERIALIZABLE** | 완벽한 고립 | 성능 저하, 거의 사용 안 함 |

> 격리수준이 높을수록 일관성은 ↑, 성능은 ↓  
> Oracle 기본: READ COMMITTED / MySQL 기본: REPEATABLE READ

---

## 🧪 병행 제어와 문제

### 병행 실행 시 발생할 수 있는 문제
- **Dirty Read**: 커밋되지 않은 데이터 읽음
- **Non-repeatable Read**: 같은 데이터 조회 결과가 달라짐
- **Phantom Read**: 조건 만족 레코드 개수가 달라짐

### 병행 제어 기법
- **로킹 (Locking)**  
  - S-lock (읽기 전용), X-lock (읽기/쓰기 가능)
- **타임스탬프 기반 제어**
- **낙관적 병행 제어 (Optimistic)**
- **다중 버전 제어 (MVCC)**

---

## 🔥 교착 상태 (Deadlock)

### 정의
- 서로 자원을 점유하고 해제되지 않아 **무한 대기 상태** 발생

### 해결법
- 테이블 접근 순서 통일
- 트랜잭션 범위 최소화
- SELECT FOR UPDATE 자제
- 주기적인 COMMIT

---

## 💻 실습 - Spring에서의 트랜잭션

**pom.xml**
```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-tx</artifactId>
    <version>5.0.7.RELEASE</version>
</dependency>
```

**TxConfig.java**
```java
@Configuration
@EnableTransactionManagement
public class TxConfig {
    @Autowired
    private DataSource dataSource3;

    @Bean
    public DataSourceTransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource3);
    }
}
```

**@Transactional 예제**
```java
@Transactional(rollbackFor = Exception.class)
public void addMemoTx(MemoDto dto) {
    mapper.insert(dto);
    mapper.insert(dto); // PK 중복 오류 유발 → ROLLBACK
}
```

### @Transactional 옵션

| 옵션 | 설명 |
|------|------|
| `propagation` | 전파 방식: REQUIRED, REQUIRES_NEW 등 |
| `isolation` | 격리 수준 설정 |
| `timeout` | 제한 시간 초 단위 |
| `readOnly` | 읽기 전용 여부 |
| `rollbackFor` | 롤백할 예외 지정 |

---

## ✅ 한 줄 요약

> **트랜잭션은 DB의 신뢰성과 무결성을 지키는 핵심 개념! ACID 원칙을 따르고, 스프링에서는 `@Transactional`로 쉽게 적용 가능!** ✅

## 🧪 트랜잭션 실습 코드 정리

### 📄 MemoServiceImpl.java

```java
@Service
public class MemoServiceImpl {
    @Autowired
    MemoDaoImpl dao;

    // 트랜잭션 적용 메서드
    @Transactional(rollbackFor = Exception.class)
    public void insertMultiTx(MemoDto dto) throws Exception {
        dao.insert(dto);
        dao.insert(dto); // 일부러 예외 유도 → 롤백 테스트
    }

    public void insertNoTx(MemoDto dto) throws Exception {
        dao.insert(dto);
        dao.insert(dto); // 트랜잭션 미적용 시 하나만 들어감
    }
}
```

➡ `@Transactional`이 붙은 `insertMultiTx()`는 **중복 입력 시 모두 롤백**되고, `insertNoTx()`는 **하나는 입력됨**.  
즉, 트랜잭션의 롤백 효과를 명확히 확인할 수 있음! 💥

---

### 📄 MemoDaoImpl.java

```java
@Repository
public class MemoDaoImpl {
    @Autowired
    SqlSessionTemplate session;

    public void insert(MemoDto dto) {
        session.insert("memo.insert", dto);
    }
}
```

➡ `SqlSessionTemplate`을 통해 실제 insert 수행.  
Mapper에서 동일한 PK를 넣으면 예외가 발생하고, `@Transactional`이 처리함.

---

### 📄 GlobalExceptionHandler.java

```java
@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(Exception.class)
    public String error(Exception e, Model model) {
        model.addAttribute("error", "⚠ 트랜잭션 롤백 발생: " + e.getMessage());
        return "error";
    }
}
```

➡ 모든 예외를 잡아주는 글로벌 예외 처리기 💡  
`rollbackFor = Exception.class`를 선언하면 이 핸들러에서 메시지를 확인할 수 있음!

---

### 📄 실습 흐름 요약

1. `MemoServiceImpl`의 `insertMultiTx()` 호출
2. `MemoDaoImpl`을 통해 두 번 insert
3. 두 번째 insert에서 예외 → `@Transactional`로 ROLLBACK
4. `GlobalExceptionHandler`가 예외를 잡아 사용자에게 알림

🧠 이렇게 트랜잭션의 중요성과 적용 효과를 실습으로 명확히 확인 가능!

---

## ✅ 한 줄 요약

> **트랜잭션은 DB의 신뢰성과 무결성을 지키는 핵심 개념! ACID 원칙을 따르고, 스프링에서는 `@Transactional`로 쉽게 적용 가능! 실습을 통해 ROLLBACK 동작을 직접 체험하자!** ✅
