# 🧩 SQL Mapper & MyBatis 정리

## 📌 개요 (Overview)

### 🎯 왜 SQL Mapper와 ORM이 필요할까?

프로그램을 실행하는 동안 다양한 데이터가 생성되고 사용됩니다.  
이 데이터를 프로그램이 꺼져도 **계속 유지(persist)** 시키려면 어딘가에 저장해야 합니다.  
이게 바로 **영속성(Persistence)** 개념이에요! 💾

이런 영속성은 보통 **도메인 모델 ↔ 데이터베이스** 사이에 존재하며,  
객체의 데이터를 데이터베이스에 저장하거나, DB의 데이터를 객체로 가져와 사용할 수 있도록 도와줍니다.

자바에서는 JDBC로 이러한 영속성을 구현할 수 있어요.  
하지만 SQL을 일일이 작성하고, 결과를 객체로 매핑하는 건 정말 귀찮고 번거롭죠... 🥲

그래서 등장한 두 가지 도구!  

- **SQL Mapper (MyBatis)**  
- **ORM (JPA, Hibernate)**  

이들은 개발자가 직접 JDBC를 다루지 않고도 **영속성**을 관리할 수 있게 도와주는 **Persistence Framework**입니다.

---

## 💡 핵심 개념 요약 (Key Concepts)

### 🔷 SQL Mapper란?

> SQL Mapper는 **SQL과 객체 필드를 매핑**하는 방식이에요.

- **SQL문을 직접 작성**하고
- 쿼리 결과를 어떤 **객체에 매핑(bind)** 할지 설정합니다.
- 객체와 테이블의 관계를 매핑하는 것이 아니라 **SQL 중심의 방식**입니다.
- 대표 도구: `JdbcTemplate`, `MyBatis`

#### 📦 MyBatis 특징
- SQL을 **XML 또는 어노테이션**으로 분리해서 관리 가능
- **동적 쿼리** 작성 가능 (`<if>`, `<choose>`, `<foreach>` 등)
- 반복되는 코드 제거 (Boilerplate 제거)
- SQL이 분리되어 유지보수가 쉬움

---

### 🔶 ORM(Object Relational Mapping)이란?

> ORM은 **객체와 테이블 간 매핑**을 자동화해주는 기술이에요.

- SQL 없이도 객체를 저장하거나 불러올 수 있어요.
- `save()`, `findById()` 같은 메소드로 자동 SQL 생성
- 복잡한 쿼리는 JPQL 또는 SQL Mapper와 혼용 가능
- 대표 도구: `Hibernate`, `EclipseLink`, `DataNucleus`

---

### 🆚 SQL Mapper vs ORM 비교

| 항목 | SQL Mapper (MyBatis) | ORM (JPA, Hibernate) |
|------|------------------------|----------------------|
| SQL 작성 | 직접 작성 | 자동 생성 |
| 유연성 | SQL 완전 제어 가능 | 추상화되어 있음 |
| 동적 쿼리 | 가능 (`<if>`, `<choose>`) | JPQL 또는 네이티브 쿼리 |
| DB 의존성 | 있음 (DBMS 종속적) | 상대적으로 적음 |
| 객체 지향과의 불일치 | 존재 | 매핑으로 해결 가능 |
| 학습 난이도 | 중간 (SQL 잘 알아야 함) | 초반 진입장벽 있음 |

---

## ⚠ 주의사항 (Cautions)

### MyBatis의 단점
- SQL을 **직접 작성**해야 하므로 **반복작업**이 많아질 수 있음
- **DBMS 종속성**이 있음 (Oracle vs MySQL 등)
- 객체와 테이블 구조의 불일치로 **매핑 이슈** 발생 가능

---

## 🧪 예제 또는 비유 (Examples or Analogies)

### 🎨 비유: 그림 주문 시스템

- **SQL Mapper (MyBatis)**  
: “이렇게 그려주세요” 하고 구체적으로 써서 요청 (SQL 직접 작성)  
→ 작가는 그 내용 그대로 그린다 (쿼리 결과를 객체로 매핑)

- **ORM (JPA)**  
: “강아지 한 마리 그려줘요~” 라고 말하면  
→ 작가는 알아서 자료 찾아 그리고 그려준다 (자동 SQL 생성)

---

### 🧪 MyBatis 실습 예시 (어노테이션 기반)

```java
@Mapper
public interface MemoMapper {

    @Insert("INSERT INTO tbl_memo VALUES(#{id}, #{text})")
    int insert(MemoDto dto);

    @Select("SELECT * FROM tbl_memo WHERE id = #{id}")
    MemoDto selectAt(int id);

    @Update("UPDATE tbl_memo SET text = #{text} WHERE id = #{id}")
    int update(MemoDto dto);

    @Delete("DELETE FROM tbl_memo WHERE id = #{id}")
    int delete(int id);
}
```

---

### 🧪 MyBatis 실습 예시 (XML 기반)

```xml
<mapper namespace="com.example.app.domain.common.mapper.MemoMapper">
    <insert id="insertXml" useGeneratedKeys="true" keyProperty="id">
        <selectKey keyProperty="id" order="AFTER" resultType="int">
            SELECT MAX(id) + 1 FROM tbl_memo
        </selectKey>
        INSERT INTO tbl_memo (id, text) VALUES (#{id}, #{text})
    </insert>
</mapper>
```

---
---

## 💻 실습 코드 정리 (ex05_dataSource 기반)

### 📄 MemoDto.java

```java
public class MemoDto {
    private int id;
    private String text;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
```

➡ MyBatis에서 데이터를 매핑할 **기본 DTO 클래스**에요.  
SQL 결과와 필드를 연결해주는 역할을 합니다!

---

### 📄 MemoMapper.xml (부분)

```xml
<mapper namespace="memo">
    <insert id="insert" parameterType="MemoDto">
        INSERT INTO tbl_memo (id, text) VALUES (#{id}, #{text})
    </insert>

    <select id="selectAll" resultType="MemoDto">
        SELECT * FROM tbl_memo
    </select>
</mapper>
```

➡ namespace가 `"memo"`로 설정된 **XML 기반 Mapper**  
`MemoDaoImpl.java`에서 이 mapper의 `insert`를 호출합니다.

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

➡ SQL문을 직접 호출하는 DAO 클래스입니다.  
MyBatis의 `SqlSessionTemplate`을 통해 XML Mapper를 실행합니다.

---

### 📄 실습 흐름 요약

1. 사용자가 메모 데이터를 입력
2. `MemoDaoImpl`이 `SqlSessionTemplate`으로 XML의 insert 쿼리 호출
3. XML의 `<insert>`가 실행되어 `tbl_memo`에 저장
4. 결과는 `MemoDto` 객체로 매핑되어 반환

🔁 실습을 통해 SQL Mapper 방식의 전체 흐름을 손쉽게 이해할 수 있어요!

---

### 🧪 동적 SQL 예시

```xml
<select id="selectIf" resultType="map">
    SELECT * FROM tbl_memo
    <where>
        <if test="type == 'text'">
            AND text LIKE CONCAT('%', #{text}, '%')
        </if>
        <if test="type == 'id'">
            AND id = #{id}
        </if>
    </where>
</select>
```

---

## ✅ 한 줄 요약 (1-Line Summary)

> **MyBatis는 SQL을 직접 작성해서 객체와 매핑하는 SQL 중심의 영속성 프레임워크이다!** 💾

---

> 😊 이 문서를 보면 SQL Mapper vs ORM의 차이점이 한눈에 들어오죠?  
> 실무에서는 두 방식을 상황에 맞게 섞어 쓰는 경우도 많답니다!