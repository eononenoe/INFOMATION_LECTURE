
# 🔄 Spring Transaction(TX) 정리

---

## 📌 개요 (Overview)

Spring Boot에서의 트랜잭션 처리는 데이터 일관성을 보장하고, 작업 중 오류 발생 시 안전하게 롤백할 수 있게 해줍니다.  
특히 MyBatis와 JPA를 혼용할 경우 트랜잭션 매니저를 구분하여 명시적으로 설정해야 합니다.

---

## ⚙️ MyBatis + JPA 트랜잭션 설정 예시

### 📄 TxConfig.java

```java
@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(
    basePackages = "com.example.demo.domain.repository",
    transactionManagerRef = "jpaTransactionManager"
)
public class TxConfig {

    @Autowired
    private DataSource dataSource2;

    @Bean(name = "transactionManager")
    public DataSourceTransactionManager transactionManager2() {
        return new DataSourceTransactionManager(dataSource2);
    }

    @Bean(name="jpaTransactionManager")
    public JpaTransactionManager jpaTransactionManager(EntityManagerFactory emf) {
        JpaTransactionManager tx = new JpaTransactionManager();
        tx.setEntityManagerFactory(emf);
        tx.setDataSource(dataSource2);
        return tx;
    }
}
```

---

## 🧪 트랜잭션 테스트 서비스

### 📄 TxTestService.java

```java
@Service
@Slf4j
public class TxTestService {

    @Autowired
    private MemoMapper memoMapper;

    @Transactional(rollbackFor = SQLException.class, transactionManager = "transactionManager")
    public void addMemoTx(MemoDto dto) throws Exception {
        memoMapper.insert(dto);
        throw new SQLException(); // 롤백 발생
    }

    @Autowired
    private MemoRepository memoRepository;

    @Transactional(rollbackFor = SQLException.class, transactionManager = "jpaTransactionManager")
    public void addMemoTx2(MemoDto dto) throws Exception {
        Memo memo = new Memo();
        memo.setId(dto.getId());
        memo.setText(dto.getText());
        memoRepository.save(memo);
        throw new SQLException(); // 롤백 발생
    }
}
```

---

### 📄 TxTestServiceTest.java

```java
@SpringBootTest
class TxTestServiceTest {

    @Autowired
    private TxTestService txTestService;

    @Test
    void t2() throws Exception {
        txTestService.addMemoTx(new MemoDto(1,"TEST1")); // MyBatis TX
    }

    @Test
    void t3() throws Exception {
        txTestService.addMemoTx2(new MemoDto(1,"TEST1")); // JPA TX
    }
}
```

---

## 🔀 트랜잭션 전파(Propagation) 정리

### 💡 전파란?

트랜잭션이 이미 존재할 때, 기존 트랜잭션을 유지할지, 새로 시작할지 등 **행동 방식**을 지정합니다.  
Spring에서는 `@Transactional(propagation = Propagation.XXX)` 형태로 사용합니다.

---

### 📚 전파 옵션 요약표

| 전파 타입 | 기존 트랜잭션 있을 때 | 없을 때 | 설명 |
|-----------|----------------------|---------|------|
| REQUIRED (기본값) | 참여 | 새로 생성 | 가장 많이 사용 |
| REQUIRES_NEW | 일시 중단 후 새로 생성 | 생성 | 완전 독립 트랜잭션 |
| NESTED | 내부 트랜잭션 생성 (Savepoint) | 생성 | 부모 롤백 시 분리 가능 |
| SUPPORTS | 참여 | 트랜잭션 없이 실행 | 선택적 참여 |
| NOT_SUPPORTED | 일시 중단 | 트랜잭션 없이 실행 | 비트랜잭션 처리 |
| MANDATORY | 참여 | 예외 발생 | 항상 트랜잭션 필요 |
| NEVER | 예외 발생 | 실행 | 트랜잭션 없어야 실행 가능 |

---

### 🧪 사용 예시

```java
@Transactional(propagation = Propagation.REQUIRED)
public void save() {}

@Transactional(propagation = Propagation.REQUIRES_NEW)
public void saveLog() {}

@Transactional(propagation = Propagation.NESTED)
public void saveDetail() {}
```

---

### ⚠️ 실전 팁 & 주의사항

- `REQUIRES_NEW`는 로그, 알림 등 트랜잭션 분리 작업에 적합
- `NESTED`는 드라이버에 따라 Savepoint 기능이 제대로 동작하지 않을 수 있음
- **같은 클래스 내부 메서드 호출은 전파 설정이 무시될 수 있으므로 주의**
- 복잡한 로직에서는 트랜잭션 전략을 **의도에 따라 명확히 분리**해야 함

---

📚 한 줄 요약 (1-Line Summary)

Spring Boot의 트랜잭션은 MyBatis와 JPA의 혼용 상황에서도 정교하게 제어할 수 있으며, 전파 속성까지 활용하면 유연하고 안정적인 데이터 처리를 설계할 수 있습니다.
