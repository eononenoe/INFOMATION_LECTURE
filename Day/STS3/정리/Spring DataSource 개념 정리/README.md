# 💾 DataSource 개념 정리 (Spring JDBC & HikariCP)

📌 **개요 (Overview)**  
`DataSource`는 DB랑 연결을 관리해주는 핵심 인터페이스임.  
Spring에서는 `Connection`을 직접 만들지 않고, `DataSource`를 통해 연결함.  
그 덕분에 **성능**, **자원 관리**, **트랜잭션 처리**가 훨씬 편하고 안정적임!

---

## 💡 핵심 개념 요약 (Key Concepts)

### ✔ DataSource 정의
- JDBC의 `Connection`을 추상화한 인터페이스 (`javax.sql.DataSource`)
- 직접 커넥션 만들지 않고, 이걸로 연결 관리
- DAO나 Repository 클래스에서 주로 사용함

### ✔ 특징 요약
- ✅ 커넥션 풀(Pooling) 기반 → **성능 향상**
- 🔄 트랜잭션 관리 / 자원 반환 자동화
- 🔌 다양한 구현체 사용 가능:
  - `HikariCP` (Spring Boot 기본)
  - `DBCP2`, `Tomcat JDBC`, 등등
- ⚙ 설정만 해주면 바로 연동됨

### ✔ 어디에 쓰냐?
- DAO/Repository에서 DB 연결할 때
- `@Transactional`이랑 같이 트랜잭션 처리
- JPA, MyBatis 등 ORM에서 자동으로 연결 관리
- 테스트할 때 H2 같은 인메모리 DB 연동

---

## ⚙ 설정 예제 (Dependencies & Config)

### 📦 `pom.xml` 의존성

```xml
<!-- MySQL Connector -->
<dependency>
  <groupId>com.mysql</groupId>
  <artifactId>mysql-connector-j</artifactId>
  <version>8.1.0</version>
</dependency>

<!-- Spring JDBC -->
<dependency>
  <groupId>org.springframework</groupId>
  <artifactId>spring-jdbc</artifactId>
  <version>5.0.7.RELEASE</version>
</dependency>

<!-- HikariCP -->
<dependency>
  <groupId>com.zaxxer</groupId>
  <artifactId>HikariCP</artifactId>
  <version>5.0.1</version>
</dependency>
```

---

## 🛠️ 자바 설정 예제 (Java Config)

### 🧪 DataSource 설정 – XML 없이 자바로

```java
@Configuration
public class DataSourceConfig {

    // Spring JDBC용 DataSource
    @Bean
    public DataSource dataSource2() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/bookdb");
        dataSource.setUsername("root");
        dataSource.setPassword("1234");
        return dataSource;
    }

    // HikariCP DataSource
    @Bean
    public HikariDataSource dataSource3() {
        HikariDataSource dataSource = new HikariDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setJdbcUrl("jdbc:mysql://localhost:3306/bookdb");
        dataSource.setUsername("root");
        dataSource.setPassword("1234");
        return dataSource;
    }
}
```

---

## 🧪 테스트 예제 (JUnit으로 확인)

```java
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class C01DataSource {

    // XML 기반 bean
    @Autowired
    private DataSource dataSource;

    @Test
    public void xml_bean_dataSource() throws SQLException {
        assertNotNull(dataSource);
        assertNotNull(dataSource.getConnection());
        log.info(dataSource.toString());
    }

    // Java Config 기반
    @Autowired
    private DataSource dataSource2;

    @Test
    public void rootConfig_dataSource() throws SQLException {
        assertNotNull(dataSource2);
        assertNotNull(dataSource2.getConnection());
        log.info(dataSource2.toString());
    }

    // HikariCP 기반
    @Autowired
    private DataSource dataSource3;

    @Test
    public void rootConfig_dataSource_Hikari() throws SQLException {
        assertNotNull(dataSource3);
        assertNotNull(dataSource3.getConnection());
        log.info(dataSource3.toString());
    }
}
```

---

## ⚠ 주의사항 (Cautions)

- 꼭 DB 드라이버(mysql-connector-j 등) 의존성 추가해야 함!
- 비밀번호, URL, 드라이버 설정 잘못되면 연결 실패함
- HikariCP는 Spring Boot에서는 기본으로 설정돼 있음 → `application.yml`로도 가능
- 테스트에서는 `@RunWith`, `@ContextConfiguration`, `@Autowired`로 연결 확인 가능

---

## ✅ 한 줄 요약 (1-Line Summary)

> DataSource는 DB 연결을 관리하는 핵심 도구고, HikariCP 같은 커넥션 풀을 쓰면 성능도 좋아지고 트랜잭션 처리도 쉬워짐! 💪
