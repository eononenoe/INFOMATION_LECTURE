
# 📘 Spring JPA 정리

---

## 📌 개요 (Overview)

Spring Data JPA는 자바 객체와 관계형 데이터베이스 간의 매핑을 쉽게 해주는 JPA(Java Persistence API)와 스프링 생태계의 통합 도구입니다.  
SQL을 거의 작성하지 않고도 복잡한 데이터베이스 조작이 가능하며, `Repository` 인터페이스 기반으로 쿼리를 자동 생성할 수 있습니다.

---

## 🔖 JPA 주요 애노테이션 정리

### 📄 Entity 관련
- `@Entity`: 해당 클래스가 JPA 엔티티임을 표시합니다.
- `@Table`: 매핑될 테이블 이름, 인덱스 등을 설정할 수 있습니다.
- `@Id`: 기본 키(primary key) 지정
- `@GeneratedValue`: 기본 키 자동 생성 전략 설정
- `@Column`: 컬럼 세부 설정 (길이, null 여부 등)
- `@Temporal`: 날짜/시간 필드 매핑 시 사용
- `@Transient`: DB에 매핑되지 않는 필드로 설정

### 📄 관계 매핑
- `@OneToOne`, `@OneToMany`, `@ManyToOne`, `@ManyToMany`: 엔티티 간 관계 설정
- `@JoinColumn`: 외래 키(FK) 지정
- `@JoinTable`: 다대다 관계 시 중간 테이블 지정
- `@PrimaryKeyJoinColumn`: 상속 매핑 시 기본 키 연결
- `@OrderColumn`, `@MapKeyJoinColumn`: 컬렉션 매핑에서 순서나 키 설정
- `@JoinColumnOrFormula`: 수식 기반 조인

---

## 🔄 GenerationType 전략 정리

| 전략 | 설명 |
|------|------|
| `AUTO` | DB에 맞게 자동 선택 (기본값) |
| `IDENTITY` | DB에서 자동 증가 (MySQL 등) |
| `SEQUENCE` | DB 시퀀스를 이용한 생성 (Oracle 등) |
| `TABLE` | 키 전용 테이블 사용 (호환성 높음) |

---

## 🗂 Repository 함수명 명명 규칙

### 📄 기본 구조
`findBy[속성명][조건자][정렬자]`

예:
- `findByUsername`
- `findByBooknameContaining`
- `deleteByBookname`
- `countByPublisher`
- `findByBookcodeBetween`

### 📚 사용 가능한 접두사
- `findBy`, `readBy`, `queryBy`, `countBy`, `deleteBy`, `existsBy`

### 📊 조건 연산자
- `Is`, `Equals`, `GreaterThan`, `LessThan`, `Between`, `Like`, `StartingWith`, `Containing`, `IsNull`, `In` 등

### 🔃 정렬 / 결과 수 제한
- `OrderByBooknameAsc`
- `Top3ByAgeGreaterThan`
- `FirstByUsername`

### 🧩 Pageable / Sort 지원
```java
Page<User> findByAgeGreaterThan(int age, Pageable pageable);
List<User> findByAgeGreaterThan(int age, Sort sort);
```

---

## 📜 JPQL (Java Persistence Query Language)

### 📄 특징
- 객체(Entity) 기반 쿼리
- SQL과 문법 유사하지만 대상이 다름

### 🧪 문법 예시
```java
@Query("SELECT u FROM User u WHERE u.username LIKE CONCAT('%',:username,'%')")
List<User> selectAllLikeUsername(@Param("username") String username);
```

### 주요 문법 요약

| 기능 | 예시 |
|------|------|
| SELECT | `SELECT m FROM Member m` |
| WHERE | `WHERE m.age >= 20` |
| JOIN | `JOIN FETCH m.team` |
| ORDER BY | `ORDER BY m.age DESC` |
| GROUP BY | `GROUP BY t.name` |
| SUBQUERY | `WHERE m.age > (SELECT AVG(m2.age) FROM Member m2)` |
| UPDATE/DELETE | `UPDATE Member m SET m.age = 30` |

---

## 🔗 연관관계 매핑 정리

### 📌 단방향
```java
@OneToMany
@JoinColumn(name = "team_id")
private List<Member> members;
```

### 📌 양방향
```java
@ManyToOne
@JoinColumn(name = "team_id")
private Team team;

@OneToMany(mappedBy = "team")
private List<Member> members;
```

### ⚠️ 주의사항
- 연관관계의 주인은 FK가 있는 쪽 (`@JoinColumn`)
- 무한 루프 방지 → DTO 변환 또는 `@JsonIgnore`

---

## 🚀 Cascade, OrphanRemoval, Fetch 전략

| 항목 | 설명 |
|------|------|
| `cascade = CascadeType.ALL` | 부모 저장/삭제 시 자식도 적용 |
| `orphanRemoval = true` | 연관이 끊긴 자식 자동 삭제 |
| `fetch = FetchType.LAZY` | 지연 로딩 (기본값) |
| `fetch = FetchType.EAGER` | 즉시 로딩 (주의 필요) |

---

## ⚙️ DDL 자동 생성 설정 (application.properties)

```properties
spring.jpa.hibernate.ddl-auto=update
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.properties.hibernate.jdbc.batch_size=1000
spring.jpa.properties.hibernate.order_inserts=true
spring.jpa.properties.hibernate.order_updates=true
spring.jpa.sql.init.mode=always
spring.jpa.defer-datasource-initialization=true
```

---

## 💻 실전 예시 요약

### 📄 Book 엔티티
```java
@Entity
@Table(name="book")
public class Book {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookCode;
    private String bookName;
    private String publisher;
    private String author;
    private String isbn;
}
```

### 📄 Repository
```java
public interface BookRepository extends JpaRepository<Book, Long> {
    List<Book> findByBookNameContaining(String keyword);
    void deleteByBookName(String bookName);
}
```

### 📄 JPQL 쿼리 예시
```java
@Query("SELECT l FROM Lend AS l JOIN FETCH l.user WHERE l.user.username = :username")
List<Lend> findLendsByUser(@Param("username") String username);
```

---

## 📚 한 줄 요약 (1-Line Summary)

Spring Data JPA는 SQL 없이도 객체 중심으로 DB를 설계하고 조회할 수 있게 해주는 강력한 ORM 프레임워크입니다.


---

## 📂 실습 코드 및 전체 예시 정리

### 📁 BookRepository - 실전 함수명 예제

```java
// 책 이름으로 책 검색
List<Book> findByBookname(String bookname);

// 출판사로 책 검색
List<Book> findByPublisher(String publisher);

// ISBN으로 책 검색
Book findByIsbn(String isbn);

// 책 코드 범위로 책 검색
List<Book> findByBookcodeBetween(long start, long end);

// 책 이름이나 출판사로 책 검색
List<Book> findByBooknameOrPublisher(String bookname, String publisher);

// 정렬된 검색
List<Book> findByBooknameOrPublisherOrderByBooknameAsc(String bookname, String publisher);

// 특정 문자열 포함
List<Book> findByBooknameContaining(String keyword);

// 접두어 검색
List<Book> findByPublisherStartingWith(String prefix);

// 책 개수 반환
int countByBookname(String bookname);
int countByPublisher(String publisher);

// 책 삭제
void deleteByBookname(String bookname);
```

---

### 📁 BookRepositoryTest.java

```java
@SpringBootTest
@TestPropertySource(properties = {
        "logging.level.com.example=error"
})
class BookRepositoryTest {

    @Autowired
    private BookRepository bookRepository;

    @Test
    public void t1() {
        Book book = Book.builder()
            .bookCode(1L)
            .bookName("book122")
            .author("author122")
            .publisher("publisher1")
            .isbn("111-222")
            .build();

        Book result = bookRepository.save(book);
        assertThat(result).isEqualTo(book);
    }

    @Test
    public void t2() {
        Book book = Book.builder()
            .bookCode(1L)
            .bookName("bookUpdate1")
            .author("authorUpdate1")
            .publisher("publisherUpdate1")
            .isbn("111-222Update")
            .build();

        Book result = bookRepository.save(book);
        assertThat(result).isEqualTo(book);
    }

    @Test
    public void t3() {
        bookRepository.deleteById(1L);
    }

    @Test
    public void t4() {
        Optional<Book> bookOptional = bookRepository.findById(1L);
        bookOptional.ifPresent(System.out::println);
    }

    @Test
    public void t5() {
        List<Book> list = bookRepository.findAll();
        list.forEach(System.out::println);
    }

    @Test
    public void t6() {
        List<Book> list = bookRepository.findByBookName("a");
        list.forEach(System.out::println);
    }

    @Test
    public void t7() {
        List<Book> list = bookRepository.findByBookNameContains("a");
        list.forEach(System.out::println);
    }
}
```

---

### 📁 LendRepository.java (JPQL 예제 포함)

```java
@Repository
public interface LendRepository extends JpaRepository<Lend, Long> {

    @Query("SELECT l FROM Lend AS l JOIN FETCH l.user WHERE l.user.username = :username")
    List<Lend> findLendsByUser(@Param("username") String username);

    @Query("SELECT l FROM Lend AS l JOIN FETCH l.user JOIN FETCH l.book")
    List<Lend> findLendsByUserAndBook();
}
```

---

### 📁 application.properties 예시

```properties
spring.jpa.hibernate.ddl-auto=update
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.properties.hibernate.jdbc.batch_size=1000
spring.jpa.properties.hibernate.order_inserts=true
spring.jpa.properties.hibernate.order_updates=true
spring.jpa.properties.hibernate.jdbc.batch_versioned_data=true
spring.sql.init.mode=always
spring.jpa.defer-datasource-initialization=true
```

---

### 📁 JpaConfig.java 설정 예시

```java
@Configuration
@EntityScan(basePackages = {"com.example.demo.domain.entity"})
@EnableJpaRepositories(basePackages = {"com.example.demo.domain.repository"})
public class JpaConfig {
    @Autowired
    private DataSource dataSource;

    @Bean
    LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
        entityManagerFactoryBean.setDataSource(dataSource);
        entityManagerFactoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        entityManagerFactoryBean.setPackagesToScan("com.example.demo.domain.entity");

        Map<String, Object> properties = new HashMap<>();
        properties.put("hibernate.hbm2ddl.auto", "update");
        properties.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
        properties.put("hibernate.show_sql", true);
        properties.put("hibernate.format_sql", true);
        properties.put("hibernate.hibernate.jdbc.batch_size", 1000);
        properties.put("hibernate.hibernate.order_inserts", true);
        properties.put("hibernate.order_updates", true);
        properties.put("hibernate.jdbc.batch_versioned_data", true);

        entityManagerFactoryBean.setJpaPropertyMap(properties);
        return entityManagerFactoryBean;
    }

    @Bean
    public DataSourceInitializer dataSourceInitializer() {
        DataSourceInitializer initializer = new DataSourceInitializer();
        initializer.setDataSource(dataSource);
        initializer.setDatabasePopulator(databasePopulator());
        return initializer;
    }

    private DatabasePopulator databasePopulator() {
        ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
        populator.addScript(new ClassPathResource("schema.sql"));
        populator.addScript(new ClassPathResource("data.sql"));
        return populator;
    }
}
```

---

📚 한 줄 요약 (1-Line Summary)

JPA는 단순한 SQL을 넘어서 엔티티 중심의 객체 설계, 매핑, 쿼리 최적화, 생명주기 제어까지 모두 포괄하는 강력한 데이터 처리 프레임워크입니다.
